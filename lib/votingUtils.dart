import 'dart:math';

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
      var rand = new Random();
      var rNumber = rand.nextInt(10);
      codes.add("vb$i$rNumber");
    }
    print(codes[0]);
    return codes;
  }
}
