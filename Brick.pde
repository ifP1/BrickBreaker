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
    hoehe = height / 2.2 / br[index1].length + 1;
    x = index1 * breite;
    y = index2 * hoehe;
  }

  void tick() {
    anzeigen();
  }

  void anzeigen() {
    if (heile) {
      colorPicker();
      rect(x, y, breite, hoehe);
      fill(255);
    }
  }

  void hit() {
    durability--;
    multi += 0.2;
    Score += multi / 10;
    if (durability == 0) {
      heile = false;
      Score += multi;
      dropPowerUp(x, y, index1);
    }
  }

  void colorPicker() {
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
