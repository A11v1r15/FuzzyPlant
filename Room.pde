class Room {
  PVector position;
  String name;
  double persiana;
  double temperatura;
  double conforto = -1;

  Room(String n, float x, float y) {
    position = new PVector(x, y);
    name = n;
    persiana = random(0, 100);
    temperatura = random(-10, 50);
  }
}
