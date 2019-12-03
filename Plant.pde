class Plant extends Fuzzy {
  PImage icon;
  PVector position;
  PVector target;
  String name;

  Plant(String planta) throws IOException {
    super(planta);
    name = planta;
    icon = loadImage(planta+".png");
    position = new PVector(0, 0);
    target = new PVector(0, 0);
  }

  PVector getPosition() {
    if (position.dist(target) > 1) {
      position = PVector.lerp(position, target, 0.05f);
    } else {
      position = target.copy();
    }
    return position;
  }

  void moveTo(PVector t) {
    target = t;
  }
}
