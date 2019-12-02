Plant violeta;
Room[] casa = new Room[9];
PImage bg;
import org.json.JSONObject;

import io.socket.client.IO;
import io.socket.client.Socket;
import io.socket.emitter.Emitter;
import java.net.URISyntaxException;

int uv = 0; //incidencia de raios UV


void setup() {
  networking();
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
  casa[0] = new Room("Sala de estar", 390, 120);
  casa[1] = new Room("Sala de jantar", 510, 160);
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
}

void keyPressed() {
  violeta.moveTo(casa[int(random(0, 9))].position);
}

void decisao() {
  Table confortoLugar = new Table();
  confortoLugar.addColumn("local");
  confortoLugar.addColumn("conforto");
  //baseado nos valores Fuzzy, decidir qual a melhor sala e se mover para lá.
  for (int i = 0; i < casa.length; i++) {

    double temp = casa[i].getTemp();
    double persiana = casa[i].getPersiana();
    TableRow entrada = confortoLugar.addRow();
    entrada.setFloat("conforto", (float)violeta.getConforto(temp, persiana, uv));
    entrada.setInt("local", i);
  }
  confortoLugar.sort("conforto"); //ordena tabela pelo conforto (ascendente)
  TableRow ultimo = confortoLugar.getRow(confortoLugar.getRowCount() -1); //primeira entrada tem o melhor valor
  int melhorLugar = ultimo.getInt("local");
  violeta.moveTo(casa[melhorLugar].position);
  for (TableRow row : confortoLugar.rows()) {
    println(casa[row.getInt("local")].getName() + ": " + row.getFloat("conforto"));
  }
  println("Melhor lugar: " + casa[melhorLugar].getName());
}

void networking() {
  //vai na fe, funciona
  try {

    final Socket socket;
    socket = IO.socket("http://localhost:8080");



    Emitter.Listener onHouseChange = new Emitter.Listener() {
      @Override
        public void call(final Object... args) {

        JSONObject data = (JSONObject) args[0];
        try{
        String local = data.getString("name");
        int temperatura = data.getInt("temperatura");
        int persiana = data.getInt("persiana");
        for (int i = 0; i < casa.length; i++) {
          if (casa[i].getName().equals(local)) {
            casa[i].setTemp(temperatura);
            casa[i].setPersiana(persiana);
          }
        }
        decisao();
        } catch(JSONException ex){
          println("JSONException");
        }
        System.out.println(data.toString());
      }
    };
    Emitter.Listener onUVChange = new Emitter.Listener() {
      @Override
        public void call(final Object... args) {

        JSONObject data = (JSONObject) args[0];
        try{
        uv = data.getInt("iuv");
        } catch(JSONException ex){
          println("JSONException");
        }
        decisao();
        System.out.println(data.toString());
      }
    };
    Emitter.Listener onCommand = new Emitter.Listener() {
      @Override
        public void call(final Object... args) {

        //JSONObject data = (JSONObject) args[0];
       // System.out.println(data.toString());
      }
    };
    Emitter.Listener onConnect = new Emitter.Listener() {
      @Override
        public void call(final Object... args) {    
        System.out.println("connectado");
      }
    };


    socket.on(Socket.EVENT_CONNECT, onConnect);
    socket.on("houseChange", onHouseChange);
    socket.on("uvChange", onUVChange);
    socket.on("command", onCommand);
    socket.connect();
  } 
  catch (URISyntaxException lol) {
    println("PAU");
  }
}
