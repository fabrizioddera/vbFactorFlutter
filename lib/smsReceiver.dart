import 'package:sms/sms.dart';
class VBSMSReciver{

  VBSMSReciver();

static void startListenToSMS(Function f){
SmsReceiver receiver = new SmsReceiver();
    receiver.onSmsReceived.listen((SmsMessage msg) => f(msg));
}
}

