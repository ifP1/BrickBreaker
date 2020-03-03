class PowerUp {

  float x, y;
  float d = 20;
  int type;
  int r, g, b;
  String code = "";
  boolean collected = false;

  PowerUp(float xPos, float yPos, int index1) {
    x = xPos + random((width / br.length) - 2 * d) + d;
    y = yPos + (height / 2.2 / br[index1].length) / 2;
    typisierung();
  }

  void typisierung() {
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

  void collectionAction() {
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

  void platformExtender() {
    r = 90;
    g = 120;
    b = 120;
    code = "_";
  }

  void platformExtenderCollected() {
    pl.breite += (150 - pl.breite) * 0.1;
  }

  void ballAdd(int i) {
    r = 50;
    g = 80;
    b = 180;
    code = "+";
  }

  void ballAddCollected(int i) {
    baExtender(i, false);
  }

  void extraLife() {
    r = 220;
    g = 100;
    b = 100;
    code = "L";
  }

  void extraLifeCollected() {
    baExtender(1, true);
  }

  void brickBreaker() {
    r = 60;
    g = 140;
    b = 140;
    code = "B";
  }

  void brickBreakerCollected() {
    for (int i = 0; i < br.length; i++) {
      for (int j = 0; j < br[i].length; j++) {
        if (random(100) < 2) {
          br[i][j].hit();
        }
      }
    }
  }

  void tick() {
    move();
    anzeigen();
  }

  void anzeigen() {
    if (!collected) {
      fill(r, g, b);
      ellipse(x, y, d, d);
      fill(255);
      text(code, x - (d / 5), y + (d / 5));
    }
  }

  void move() {
    y += 2;

    if (y > pl.y && y < pl.y + pl.hoehe && x > pl.x - pl.breite / 2 && x < pl.x + pl.breite / 2 && !collected) {
      collected = true;
      collectionAction();
    }
  }
}
