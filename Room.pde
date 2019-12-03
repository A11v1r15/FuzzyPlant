class Room {
  PVector position;
  String name;
  double persiana;
  double temperatura;
  double umidade;
  boolean waterSpot = false;

  Room(String n, float x, float y) {
    position = new PVector(x, y);
    name = n;
    temperatura = 20;
    persiana = 25;
    umidade = 256;
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
  public double getUmidade() {
    return umidade;
  }
  public String getName() {
    return name;
  }

  public void setTemp(int temp) {
    this.temperatura = temp;
  }
  public void setPosition(PVector vec2) {
    this.position = vec2;
  }
  public void setPersiana(int persiana) {
    this.persiana = persiana;
  }
  public void setUmidade(int umidade) {
    this.umidade = umidade;
  }
  public void setName(String name) {
    this.name = name;
  }
}
