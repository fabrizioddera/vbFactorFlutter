import 'package:sms/sms.dart';

void startListenToSMS(Function f){
SmsReceiver receiver = new SmsReceiver();
    receiver.onSmsReceived.listen((SmsMessage msg) => f(msg));
}

