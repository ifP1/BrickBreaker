import java.util.Scanner;
import java.io.File;

Platform pl;
Ball[] ba;
Brick[][] br;
PowerUp[] po;
boolean started = false;
int ballCount = 0, brickCount = 0;
float multi, Score;

void setup() {
  size(800, 600);
}

void draw() {
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
    text("Score: " + (Score - (Score % 0.01)), 20, height - 30);
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

void start(int i) {
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

void lose() {
  background(100, 10, 10);
  text("You Lose!\nPress TAB to restart!\nScore: " + (Score - (Score % 0.01)), 100, 100);
  if (keyPressed && key == TAB) {
    started = false;
  }
}

void baExtender(int toExtendBy, boolean stick) {
  int i = ba.length;
  ba = baarrExtender(ba, toExtendBy);
  baSetup(i, stick);
}

Ball[] baarrExtender(Ball[] arr, int toExtendBy) {
  Ball[] arrnew = new Ball[arr.length + toExtendBy];
  for (int i = 0; i < arr.length; i++) {
    arrnew[i] = arr[i];
  }
  return arrnew;
}

void baSetup(int startBy, boolean stick) {
  for (int i = startBy; i < ba.length; i++) {
    ba[i] = new Ball(stick);
  }
}

void dropPowerUp(float x, float y, int index1) {
  if (random(100) < 25) {
    int i = po.length;
    po = poarrExtender(po, 1);
    poSetup(i, x, y, index1);
  }
}

PowerUp[] poarrExtender(PowerUp[] arr, int toExtendBy) {
  PowerUp[] arrnew = new PowerUp[arr.length + toExtendBy];
  for (int i = 0; i < arr.length; i++) {
    arrnew[i] = arr[i];
  }
  return arrnew;
}

void poSetup(int startBy, float x, float y, int index1) {
  for (int i = startBy; i < po.length; i++) {
    po[i] = new PowerUp(x, y, index1);
  }
}

void levelBuilder(int txt) {
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
