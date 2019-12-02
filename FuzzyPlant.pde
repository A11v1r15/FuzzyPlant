Plant violeta;
Room[] casa = new Room[9];
PImage bg;

void setup() {
  size(800, 600);
  colorMode(HSB);
  try {
    violeta = new Plant("violeta");
    violeta.setTemperatura(35.0);
    violeta.setPersiana(50.0);
    violeta.setUv(2.0);
    print(violeta.getConforto());
  } 
  catch (IOException e) {
    print(e);
  }
  imageMode(CENTER);
  bg = loadImage("Planta-Baixa.png");
  casa[0] = new Room("Sala de Estar", 390, 120);
  casa[1] = new Room("Sala de Jantar", 510, 160);
  casa[2] = new Room("Cozinha", 440, 250);
  casa[3] = new Room("Quarto 1", 310, 155);
  casa[4] = new Room("Quarto 2", 140, 70);
  casa[5] = new Room("Area de convivência", 230, 245);
  casa[6] = new Room("Quintal", 630, 220);
  casa[7] = new Room("Jardim", 390, 120);
  casa[8] = new Room("Garagem", 580, 310);
  violeta.position = casa[0].position;
  violeta.moveTo(casa[0].position);
}

void draw() {
  image(bg, width / 2, height / 2);
  image(violeta.icon, (width - bg.width)/2 + violeta.getPosition().x, (height - bg.height)/2 + violeta.getPosition().y, 50, 50);
  if (frameCount % 60 == 0) {
    int best = 0;
    for (int i = 0; i < casa.length; i++) {
      if (casa[i].conforto < 0) {
        violeta.setTemperatura(casa[i].temperatura);
        violeta.setPersiana(casa[i].persiana);
        casa[i].conforto = violeta.getConforto();
      }
      if (casa[i].conforto > casa[best].conforto){
        best = i;
      }
    }
    violeta.moveTo(casa[best].position);
  }
}
