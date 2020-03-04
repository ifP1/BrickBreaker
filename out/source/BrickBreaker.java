import processing.core.*; 
import processing.data.*; 
import processing.event.*; 
import processing.opengl.*; 

import java.util.Scanner; 
import java.io.File; 

import java.util.HashMap; 
import java.util.ArrayList; 
import java.io.File; 
import java.io.BufferedReader; 
import java.io.PrintWriter; 
import java.io.InputStream; 
import java.io.OutputStream; 
import java.io.IOException; 

public class BrickBreaker extends PApplet {




Platform pl;
Ball[] ba;
Brick[][] br;
PowerUp[] po;
boolean started = false;
int ballCount = 0, brickCount = 0;
float multi, Score;

public void setup() {
  
}

public void draw() {
  background(100);
  if (started) {
    pl.tick();
    for (int i = 0; i < ba.length; i++) {
      ba[i].tick();
    }
    for (int i = 0; i < br.length; i++) {
      for (int j = 0; j < br[i].length; j++) {
        br[i][j].tick();
      }
    }
    for (int i = 0; i < po.length; i++) {
      po[i].tick();
    }
    text("Score: " + (Score - (Score % 0.01f)), 20, height - 30);
    if (ballCount <= 0) {
      lose();
    }
  } else {
    text("Select Level 0 - 9\nLvl 0 - Das Tor\nLvl 1 - Der Stern \nLvl 2 - Der Berg\nLvl 3 - Der Vogel\nLvl 4 - Der Himmel\nLvl 5 - Die Faust\nLvl 6 - Die Welle\nLvl 7 - Der Teppich\nLvl 8 - Die Primzahlen\nLvl 9 - Zufällig", 100, 100);
    if (keyPressed) {
      switch(key) {
      case '0':
        start(0);
        break;
      case '1':
        start(1);
        break;
      case '2':
        start(2);
        break;
      case '3':
        start(3);
        break;
      case '4':
        start(4);
        break;
      case '5':
        start(5);
        break;
      case '6':
        start(6);
        break;
      case '7':
        start(7);
        break;
      case '8':
        start(8);
        break;
      case '9':
        start(9);
        break;
      }
    }
  }
}

public void start(int i) {
  multi = 1;
  Score = 0;
  ballCount = 0;
  levelBuilder(i);
  pl = new Platform();
  ba = new Ball[1];
  ba[0] = new Ball(true);
  po = new PowerUp[1];
  po[0] = new PowerUp(0, height * 2, 0);
  started = true;
}

public void lose() {
  background(100, 10, 10);
  text("You Lose!\nPress TAB to restart!\nScore: " + (Score - (Score % 0.01f)), 100, 100);
  if (keyPressed && key == TAB) {
    started = false;
  }
}

public void baExtender(int toExtendBy, boolean stick) {
  int i = ba.length;
  ba = baarrExtender(ba, toExtendBy);
  baSetup(i, stick);
}

public Ball[] baarrExtender(Ball[] arr, int toExtendBy) {
  Ball[] arrnew = new Ball[arr.length + toExtendBy];
  for (int i = 0; i < arr.length; i++) {
    arrnew[i] = arr[i];
  }
  return arrnew;
}

public void baSetup(int startBy, boolean stick) {
  for (int i = startBy; i < ba.length; i++) {
    ba[i] = new Ball(stick);
  }
}

public void dropPowerUp(float x, float y, int index1) {
  if (random(100) < 25) {
    int i = po.length;
    po = poarrExtender(po, 1);
    poSetup(i, x, y, index1);
  }
}

public PowerUp[] poarrExtender(PowerUp[] arr, int toExtendBy) {
  PowerUp[] arrnew = new PowerUp[arr.length + toExtendBy];
  for (int i = 0; i < arr.length; i++) {
    arrnew[i] = arr[i];
  }
  return arrnew;
}

public void poSetup(int startBy, float x, float y, int index1) {
  for (int i = startBy; i < po.length; i++) {
    po[i] = new PowerUp(x, y, index1);
  }
}

public void levelBuilder(int txt) {
  if (txt == 9) {
    br = new Brick[10][10];
    for (int i = 0; i < br.length; i++) {
      for (int j = 0; j < br[i].length; j++) {
        br[i][j] = new Brick(i, j, (int) random(10));
      }
    }
  } else {
    String[] bricks;
    bricks = loadStrings(txt + ".txt");
    br = new Brick[bricks.length][];
    for (int k = 0; k < br.length; k++) {
      br[k] = new Brick[bricks[k].length()];
      for (int l = 0; l < br[k].length; l++) {
        br[k][l] = new Brick(k, l, bricks[k].charAt(l) - 48);
      }
    }
  }
}
class Ball {

  float d = 15;
  float x = width / 2, y = pl.y - d / 2 - 2;
  boolean stick = true, ingame = true;
  float xSpeed = 0, ySpeed = 0;

  Ball(boolean sticky) {
    ballCount++;
    stick();
    stick = sticky;
    if (!stick) {
      calcxSpeed();
      ySpeed = -4;
    }
  }

  public void tick() {
    if (stick) {
      stick();
      if (keyPressed && key == 32) {
        stick = false;
        calcxSpeed();
        xSpeed *= 2;
        ySpeed = -4;
      }
    } else {
      move();
    }
    anzeigen();
  }

  public void anzeigen() {
    ellipse(x, y, d, d);
  }

  public void stick() {  
    y = pl.y - d / 2 - 2;
    x = pl.x;
  }

  public void move() {
    if (y < 2 * height) {
      wallCollDect();
      platformCollDect();
      brickCollDect();

      x += xSpeed;
      y += ySpeed;
    }
  }

  public void calcxSpeed() {
    xSpeed += (pl.x - pl.xlast) / 7;
  }

  public void wallCollDect() {
    if (x < d / 2) {
      xSpeed *= -1;
    }
    if (x > width - d / 2) {
      xSpeed *= -1;
    }
    if (y < d / 2) {
      ySpeed *= -1;
    }
    if (y > height + d / 2 && ingame) {
      ballCount--;
      ingame = false;
      multi = 1;
    }
  }

  public void platformCollDect() {
    //check X collision
    if (x + d / 2 + xSpeed > pl.x - pl.breite / 2 && x - d / 2 + xSpeed < pl.x + pl.breite / 2 && y + d / 2 > pl.y && y - d / 2 < pl.y + pl.hoehe) {
      xSpeed *= -1;
      multi += 0.1f;
      calcxSpeed();
    }

    //check Y collision
    if (x + d / 2 > pl.x - pl.breite / 2 && x - d / 2 < pl.x + pl.breite / 2 && y + d / 2 + ySpeed > pl.y && y - d / 2 + ySpeed < pl.y + pl.hoehe) {
      ySpeed *= -1;
      multi += 0.1f;
      calcxSpeed();
    }
  }

  public void brickCollDect() {
    for (int i = 0; i < br.length; i++) {
      for (int j = 0; j < br[i].length; j++) {
        if (br[i][j].heile) {
          //check X collision
          if (x + d + xSpeed > br[i][j].x && x + xSpeed < br[i][j].x + br[i][j].breite && y + d > br[i][j].y && y < br[i][j].y + br[i][j].hoehe) {
            xSpeed *= -1;
            br[i][j].hit();
          }

          //check Y collision
          if (x + d> br[i][j].x && x < br[i][j].x + br[i][j].breite && y + d + ySpeed > br[i][j].y && y + ySpeed < br[i][j].y + br[i][j].hoehe) {
            ySpeed *= -1;
            br[i][j].hit();
          }
        }
      }
    }
  }
}
class Brick {

  int index1, index2, durability = 1;
  float x, y;
  float breite, hoehe;
  boolean heile = true;

  Brick(int i1, int i2, int du) {
    brickCount++;
    durability = du;
    if (durability == 0) {
      heile = false;
    }
    index1 = i1;
    index2 = i2;
    breite = width / br.length + 1;
    hoehe = height / 2.2f / br[index1].length + 1;
    x = index1 * breite;
    y = index2 * hoehe;
  }

  public void tick() {
    anzeigen();
  }

  public void anzeigen() {
    if (heile) {
      colorPicker();
      rect(x, y, breite, hoehe);
      fill(255);
    }
  }

  public void hit() {
    durability--;
    multi += 0.2f;
    Score += multi / 10;
    if (durability == 0) {
      heile = false;
      Score += multi;
      dropPowerUp(x, y, index1);
    }
  }

  public void colorPicker() {
    switch(durability) {
    case 1:
      fill(255);
      break;
    case 2:
      fill(255, 0, 0);
      break;
    case 3:
      fill(0, 255, 0);
      break;
    case 4:
      fill(0, 0, 255);
      break;
    case 5:
      fill(255, 0, 255);
      break;
    case 6:
      fill(255, 255, 0);
      break;
    case 7:
      fill(0, 255, 255);
      break;
    case 8:
      fill(150, 250, 150);
      break;
    case 9:
      fill(100, 200, 100);
      break;
    }
  }
}
class Platform {

  float breite = 80, hoehe = 10;
  float x = width / 2, y = height - 30;
  float xlast = x;

  Platform() {
  }

  public void tick() {
    move();
    anzeigen();
  }

  public void anzeigen() {
    rect(x - breite / 2, y, breite, hoehe);
    // Ecken des Rechtecks
    ellipse(x- breite / 2, y + hoehe / 2, hoehe, hoehe);
    ellipse(x + breite / 2, y + hoehe / 2, hoehe, hoehe);
    line(0, y + hoehe + 5, width, y + hoehe + 5);
  }

  public void move() {
    xlast = x;
    x += (mouseX - x) / 15;
  }
}
class PowerUp {

  float x, y;
  float d = 20;
  int type;
  int r, g, b;
  String code = "";
  boolean collected = false;

  PowerUp(float xPos, float yPos, int index1) {
    x = xPos + random((width / br.length) - 2 * d) + d;
    y = yPos + (height / 2.2f / br[index1].length) / 2;
    typisierung();
  }

  public void typisierung() {
    type = (int) random(10);
    switch (type) {
    case 0:
    case 1:
    case 2:
      platformExtender();
      break;
    case 3:
    case 4:
      ballAdd(1);
      break;
    case 5:
      ballAdd(3);
      break;
    case 6:
    case 7:
      ballAdd(1);
      break;
    case 8:
      brickBreaker();
      break;
    case 9:
      extraLife();
      break;
    }
  }

  public void collectionAction() {
    switch (type) {
    case 0:
    case 1:
    case 2:
      platformExtenderCollected();
      break;
    case 3:
    case 4:
      ballAddCollected(1);
      break;
    case 5:
      ballAddCollected(3);
      break;
    case 6:
    case 7:
      ballAddCollected(1);
      break;
    case 8:
      brickBreakerCollected();
      break;
    case 9:
      extraLifeCollected();
      break;
    }
  }

  public void platformExtender() {
    r = 90;
    g = 120;
    b = 120;
    code = "_";
  }

  public void platformExtenderCollected() {
    pl.breite += (150 - pl.breite) * 0.1f;
  }

  public void ballAdd(int i) {
    r = 50;
    g = 80;
    b = 180;
    code = "+";
  }

  public void ballAddCollected(int i) {
    baExtender(i, false);
  }

  public void extraLife() {
    r = 220;
    g = 100;
    b = 100;
    code = "L";
  }

  public void extraLifeCollected() {
    baExtender(1, true);
  }

  public void brickBreaker() {
    r = 60;
    g = 140;
    b = 140;
    code = "B";
  }

  public void brickBreakerCollected() {
    for (int i = 0; i < br.length; i++) {
      for (int j = 0; j < br[i].length; j++) {
        if (random(100) < 2) {
          br[i][j].hit();
        }
      }
    }
  }

  public void tick() {
    move();
    anzeigen();
  }

  public void anzeigen() {
    if (!collected) {
      fill(r, g, b);
      ellipse(x, y, d, d);
      fill(255);
      text(code, x - (d / 5), y + (d / 5));
    }
  }

  public void move() {
    y += 2;

    if (y > pl.y && y < pl.y + pl.hoehe && x > pl.x - pl.breite / 2 && x < pl.x + pl.breite / 2 && !collected) {
      collected = true;
      collectionAction();
    }
  }
}
  public void settings() {  size(800, 600); }
  static public void main(String[] passedArgs) {
    String[] appletArgs = new String[] { "BrickBreaker" };
    if (passedArgs != null) {
      PApplet.main(concat(appletArgs, passedArgs));
    } else {
      PApplet.main(appletArgs);
    }
  }
}
