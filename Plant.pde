class Plant extends Fuzzy {
  PImage icon;
  Room room;
  PVector position;
  PVector target;
  String name;
  double waterLevel = 512;
  boolean thirsty = false;
  double min;
  double max;

  Plant(String planta, double m, double M) throws IOException {
    super(planta);
    name = planta;
    icon = loadImage(planta+".png");
    position = new PVector(0, 0);
    target = new PVector(0, 0);
    min = m;
    max = M;
  }

  PVector getPosition() {
    if (position.dist(target) > 1) {
      position = PVector.lerp(position, target, 0.05f);
    } else {
      position = target.copy();
    }
    return position;
  }

  void moveTo(Room r) {
    room = r;
    target = r.position;
  }
}
