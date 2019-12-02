class Fuzzy {
  FIS fis;
  FunctionBlock fb;

  Fuzzy (String planta) throws IOException {
    fis = FIS.load(sketchPath() + "\\" + planta.toLowerCase() + ".fcl", true);
    if (fis==null) {
      throw new IOException("Can't load " + planta.toLowerCase() + ".fcl");
    }
    fb = fis.getFunctionBlock(null);
  }

  void setTemperatura(double temp) {
    fb.setVariable("temperatura", temp);
  }

  void setPersiana(double temp) {
    fb.setVariable("persiana", temp);
  }

  void setUv(double temp) {
    fb.setVariable("uv", temp);
  }

  void setUmidade(double temp) {
    fb.setVariable("umidade", temp);
  }

  void setEnergia(double temp) {
    fb.setVariable("energia", temp);
  }

  double getConforto() {
    fb.evaluate();
    return fb.getVariable("conforto").defuzzify();
  }
}
