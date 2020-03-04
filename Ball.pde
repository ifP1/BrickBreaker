import processing.sound.*;

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

  void tick(SoundFile bounce) {
    if (stick) {
      stick();
      if (keyPressed && key == 32) {
        stick = false;
        calcxSpeed();
        xSpeed *= 2;
        ySpeed = -4;
      }
    } else {
      move(bounce);
    }
    anzeigen();
  }

  void anzeigen() {
    ellipse(x, y, d, d);
  }

  void stick() {  
    y = pl.y - d / 2 - 2;
    x = pl.x;
  }

  void move(SoundFile bounce) {
    if (y < 2 * height) {
      wallCollDect(bounce);
      platformCollDect(bounce);
      brickCollDect(bounce);

      x += xSpeed;
      y += ySpeed;
    }
  }

  void calcxSpeed() {
    xSpeed += (pl.x - pl.xlast) / 7;
  }

  void wallCollDect(SoundFile bounce) {
    if (x < d / 2) {
      bounce.play();
      xSpeed *= -1;
    }
    if (x > width - d / 2) {
      bounce.play();
      xSpeed *= -1;
    }
    if (y < d / 2) {
      bounce.play();
      ySpeed *= -1;
    }
    if (y > height + d / 2 && ingame) {
      bounce.play();
      ballCount--;
      ingame = false;
      multi = 1;
    }
  }

  void platformCollDect(SoundFile bounce) {
    //check X collision
    if (x + d / 2 + xSpeed > pl.x - pl.breite / 2 && x - d / 2 + xSpeed < pl.x + pl.breite / 2 && y + d / 2 > pl.y && y - d / 2 < pl.y + pl.hoehe) {
      bounce.play();
      xSpeed *= -1;
      multi += 0.1;
      calcxSpeed();
    }

    //check Y collision
    if (x + d / 2 > pl.x - pl.breite / 2 && x - d / 2 < pl.x + pl.breite / 2 && y + d / 2 + ySpeed > pl.y && y - d / 2 + ySpeed < pl.y + pl.hoehe) {
      bounce.play();
      ySpeed *= -1;
      multi += 0.1;
      calcxSpeed();
    }
  }

  void brickCollDect(SoundFile bounce) {
    for (int i = 0; i < br.length; i++) {
      for (int j = 0; j < br[i].length; j++) {
        if (br[i][j].heile) {
          //check X collision
          if (x + d + xSpeed > br[i][j].x && x + xSpeed < br[i][j].x + br[i][j].breite && y + d > br[i][j].y && y < br[i][j].y + br[i][j].hoehe) {
            bounce.play();
            xSpeed *= -1;
            br[i][j].hit();
          }

          //check Y collision
          if (x + d> br[i][j].x && x < br[i][j].x + br[i][j].breite && y + d + ySpeed > br[i][j].y && y + ySpeed < br[i][j].y + br[i][j].hoehe) {
            bounce.play();
            ySpeed *= -1;
            br[i][j].hit();
          }
        }
      }
    }
  }
}
