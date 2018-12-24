class Concorrente {
  String name;
  int voti;

  Concorrente(String name, int voti){
    this.name = name;
    this.voti = voti;
  }

  static List<Concorrente> returnListCanto() {
    List<Concorrente> list = new List();
    for (var i = 0; i < 10; i++) {
      list.add(new Concorrente("Canto_$i", 1));
    }
    return list;
  }

  static List<Concorrente> returnListBallo() {
    return new List(10);
  }
}
