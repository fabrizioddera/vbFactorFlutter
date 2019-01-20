class VotingUtils {
  static List<String> codes = new List();

  static bool isCodeValid(String code) {
    if (codes.contains(code)) {
      codes.remove(code);
      return true;
    }
    return false;
  }

  static List<String> generateCodeList() {
    for (var i = 0; i < 301; i++) {
      var rNumber = 0;
      if(i%11 == 0){
        rNumber = 88;
      }
      if(i%7 == 0){
        rNumber = 21;
      }
      if(i%5 == 0){
        rNumber = 33;
      }
      if(i%2 == 0){
        rNumber = 75;
      }
      codes.add("vb$i$rNumber");
    }
    print(codes[0]);
    return codes;
  }
}
