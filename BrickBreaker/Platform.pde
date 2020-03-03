class Platform {

  float breite = 80, hoehe = 10;
  float x = width / 2, y = height - 30;
  float xlast = x;

  Platform() {
  }

  void tick() {
    move();
    anzeigen();
  }

  void anzeigen() {
    rect(x - breite / 2, y, breite, hoehe);
  }

  void move() {
    xlast = x;
    x += (mouseX - x) / 15;
  }
}
