import 'package:sms/sms.dart';
import 'dart:async';

class VBSMSReciver {
  VBSMSReciver();
  static SmsReceiver receiver = new SmsReceiver();
  static StreamSubscription<SmsMessage> stream;

  static bool isEnabled = false;

  static void startListenToSMS(Function f) {
    if (isEnabled == false) {
      isEnabled = true;
      stream = receiver.onSmsReceived.listen((SmsMessage msg) => f(msg));
    }
    return;
  }

  static void stopListenToSMS() {
    if (isEnabled == true) {
      isEnabled = false;
      stream.cancel();
    }
  }
}
