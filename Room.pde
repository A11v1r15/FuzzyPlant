class Room {
  PVector position;
  String name;
  double persiana;
  double temperatura;
  double conforto = -1;

  Room(String n, float x, float y) {
    position = new PVector(x, y);
    name = n;
    temperatura = 20;
    persiana = 25;
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
  
  public void setTemp(int temp){
    this.temperatura = temp;
  }
  public void setPosition(PVector vec2){
    this.position = vec2;
  }
  public void setPersiana(int persiana){
    this.persiana = persiana;
  }
  public void setName(String name){
    this.name = name;
  }
}
