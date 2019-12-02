class Room{
  PVector position;
  String name;
  int temp;
  int persiana;
  
  Room(String n, float x, float y) {
    position = new PVector(x, y);
    name = n;
    temp = 0;
    persiana = 0;
  }
  
  public int getTemp(){
    return temp;
  }
  public PVector getPosition(){
    return position;
  }
  public int getPersiana(){
    return persiana;
  }
  public String getName(){
    return name;
  }
}
