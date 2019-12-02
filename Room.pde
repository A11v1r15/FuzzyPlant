class Room {
  PVector position;
  String name;
  double persiana;
  double temperatura;
  double conforto = -1;

  Room(String n, float x, float y) {
    position = new PVector(x, y);
    name = n;
    temperatura = 0;
    persiana = 0;
  }

  public double getTemp() {
    return temperatura;
  }
  public PVector getPosition() {
    return position;
  }
  public double getPersiana() {
    return persiana;
  }
  public String getName() {
    return name;
  }
}
