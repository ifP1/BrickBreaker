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
    // Ecken des Rechtecks
    ellipse(x- breite / 2, y + hoehe / 2, hoehe, hoehe);
    ellipse(x + breite / 2, y + hoehe / 2, hoehe, hoehe);
    line(0, y + hoehe + 5, width, y + hoehe + 5);
  }

  void move() {
    xlast = x;
    x += (mouseX - x) / 15;
  }
}
