import 'package:sms/sms.dart';

class VBSMSReciver {
  VBSMSReciver();
  static SmsReceiver receiver = new SmsReceiver();

  static bool isEnabled = false;

  static void startListenToSMS(Function f) {
    if (isEnabled == false) {
      isEnabled = true;
      receiver.onSmsReceived.listen((SmsMessage msg) => f(msg));
    }
    return;
  }

  static void stopListenToSMS() {
    if (isEnabled == true) {
      isEnabled = false;
      receiver.onSmsReceived.listen((SmsMessage msg) => {});
    }
  }
}
