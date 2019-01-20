class Concorrente {
  String name;
  int voti;

  Concorrente(String name, int voti) {
    this.name = name;
    this.voti = voti;
  }

  static List<Concorrente> returnListCanto(int size) {
    List<Concorrente> list = new List();
    for (var i = 0; i < size; i++) {
      list.add(new Concorrente("Canto_$i", 0));
    }
    return list;
  }

  static List<Concorrente> returnListBallo(int size) {
    List<Concorrente> list = new List();
    for (var i = 0; i < size; i++) {
      list.add(new Concorrente("Ballo_$i", 0));
    }
    return list;
  }

  static List<Concorrente> returnListMusical(int size) {
    List<Concorrente> list = new List();
    for (var i = 0; i < size; i++) {
      list.add(new Concorrente("Musical_$i", 0));
    }
    return list;
  }
}
