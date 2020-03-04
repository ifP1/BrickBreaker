import java.util.Scanner;
import java.io.File;
import processing.sound.*;

Platform pl;
Ball[] ba;
Brick[][] br;
PowerUp[] po;
boolean started = false;
int ballCount = 0, brickCount = 0;
float multi, Score;
PFont boldFont, normalFont;
SoundFile bounce;


void setup() {
  size(800, 600);
  boldFont = createFont("Lucida Sans Typewriter Bold", 11);
  normalFont = createFont("Lucida Sans Typewriter", 11);
  bounce = new SoundFile(this, "assets/bouncing_ball.wav");

}

void draw() {
  background(0);
  if (started) {
    pl.tick();
    for (int i = 0; i < ba.length; i++) {
      ba[i].tick(bounce);
    }
    for (int i = 0; i < br.length; i++) {
      for (int j = 0; j < br[i].length; j++) {
        br[i][j].tick();
      }
    }
    for (int i = 0; i < po.length; i++) {
      po[i].tick();
    }
    text("Score: " + (int) (Score), 20, height - 30);
    if (ballCount <= 0) {
      lose();
    }
  } else {
    // Brick Breaker ASCII-Art
    textFont(boldFont, 11);
    text("" +
    " ______     ______     __     ______     __  __    " + "\n" +
    "/\\  == \\   /\\  == \\   /\\ \\   /\\  ___\\   /\\ \\/ /             " + "\n" +
    "\\ \\  __<   \\ \\  __<   \\ \\ \\  \\ \\ \\____  \\ \\  _\"-.     " +"\n" +
    " \\ \\_____\\  \\ \\_\\ \\_\\  \\ \\_\\  \\ \\_____\\  \\ \\_\\ \\_\\   " + "\n" +
    "  \\/_____/   \\/_/ /_/   \\/_/   \\/_____/   \\/_/\\/_/       " + "\n" +
    "       ______     ______     ______     ______     __  __     ______     ______   " + "\n" +
    "      /\\  == \\   /\\  == \\   /\\  ___\\   /\\  __ \\   /\\ \\/ /    /\\  ___\\   /\\  == \\  " + "\n" +
    "      \\ \\  __<   \\ \\  __<   \\ \\  __\\   \\ \\  __ \\  \\ \\  _\"-.  \\ \\  __\\   \\ \\  __< " + "\n" +
    "       \\ \\_____\\  \\ \\_\\ \\_\\  \\ \\_____\\  \\ \\_\\ \\_\\  \\ \\_\\ \\_\\  \\ \\_____\\  \\ \\_\\ \\_\\ " +"\n" +
    "        \\/_____/   \\/_/ /_/   \\/_____/   \\/_/\\/_/   \\/_/\\/_/   \\/_____/   \\/_/ /_/ " +"\n" +
    "" + "\n" +
    "Unser Beitrag zum Brick Breaker \"Wettbewerb\"", 100, 25);    
    textFont(normalFont, 11);
    text("[LEVEL SELECTION] \nLVL 0 - Das Tor \nLVL 1 - Der Stern \nLVL 2 - Der Berg\nLVL 3 - Der Vogel\nLVL 4 - Der Himmel\nLVL 5 - Die Faust\nLVL 6 - Die Welle\nLVL 7 - Der Teppich\nLVL 8 - Die Primzahlen\nLVL 9 - Zufällig ¯\\_(ツ)_/¯\n\n>>>" + "\n" + 
    "" + "\n" + 
    "HOW TO PLAY" + "\n" + 
    "- Gebe eine Ziffer ein, um ein Level zu starten." + "\n" + 
    "- Wenn alle Bälle im Boden verschwinden, verlierst du und du kannst nur verlieren T_T." + "\n" + 
    "- Versuche aber trotzdem, die höchstmögliche Punktzahl zu erreichen." + "\n" + 
    "- Der Ball kann durch die Geschwindigkeit der Platform abgelenkt und beschleunigt werden."
    , 100, 250);
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
  text("▓██   ██▓ ▒█████   █    ██     ██▓     ▒█████    ██████ ▓█████ \n ▒██  ██▒▒██▒  ██▒ ██  ▓██▒   ▓██▒    ▒██▒  ██▒▒██    ▒ ▓█   ▀ \n  ▒██ ██░▒██░  ██▒▓██  ▒██░   ▒██░    ▒██░  ██▒░ ▓██▄   ▒███   \n  ░ ▐██▓░▒██   ██░▓▓█  ░██░   ▒██░    ▒██   ██░  ▒   ██▒▒▓█  ▄ \n  ░ ██▒▓░░ ████▓▒░▒▒█████▓    ░██████▒░ ████▓▒░▒██████▒▒░▒████▒\n   ██▒▒▒ ░ ▒░▒░▒░ ░▒▓▒ ▒ ▒    ░ ▒░▓  ░░ ▒░▒░▒░ ▒ ▒▓▒ ▒ ░░░ ▒░ ░\n ▓██ ░▒░   ░ ▒ ▒░ ░░▒░ ░ ░    ░ ░ ▒  ░  ░ ▒ ▒░ ░ ░▒  ░ ░ ░ ░  ░\n ▒ ▒ ░░  ░ ░ ░ ▒   ░░░ ░ ░      ░ ░   ░ ░ ░ ▒  ░  ░  ░     ░   \n ░ ░         ░ ░     ░            ░  ░    ░ ░        ░     ░  ░\n ░ ░                                               ", 100, 50);
  text("You Lose!\nDrücke <Tab>, um fortzufahren...\nScore: " + (int) Score, 100, 250);
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
