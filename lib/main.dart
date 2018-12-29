import 'package:flutter/material.dart';
import 'package:sms/sms.dart';
import 'concorrenti.dart';
import 'smsReceiver.dart';
import 'votingUtils.dart';
import 'pages/classicVote.dart';
import 'pages/kidsVote.dart';
import 'pages/musicalVote.dart';
import 'style.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'VB Factor 2019',
      theme: ThemeData(
        buttonTheme: ButtonThemeData(
          minWidth: 200,
          height: 75,
        ),
        primarySwatch: StyleVBFactor.getMainColorMaterial(),
      ),
      home: MyHomePage(title: 'VB Factor 2019'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<Concorrente> concorrentiCanto = Concorrente.returnListCanto();
  List<Concorrente> concorrentiBallo = Concorrente.returnListBallo();

  void incrementSMS(SmsMessage msg) {
    if (msg.body != '') {
      List<String> splitString = msg.body.split(new RegExp(' '));
      if (splitString.length > 0 && splitString.length == 7) {
        String code = splitString[0];
        if (VotingUtils.isCodeValid(code)) {
          int code1 = int.tryParse(splitString[1]);
          if (code1 == null) {
            return;
          }
        }
      }
      setState(() {});
    }
  }

  @override
  void initState() {
    super.initState();
    VBSMSReciver.startListenToSMS(incrementSMS);
  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
        appBar: AppBar(
          // Here we take the value from the MyHomePage object that was created by
          // the App.build method, and use it to set our appbar title.
          title: Text(widget.title),
        ),
        body: Center(
          child: new Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              new Padding(
                  padding: new EdgeInsets.all(25),
                  child: new RaisedButton(
                    textColor: Colors.white,
                    color: StyleVBFactor.getMainColor(),
                    child: new Text('Votazione classica'),
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => ClassicVote()));
                    },
                  )),
              new Padding(
                padding: new EdgeInsets.all(25),
                child: new RaisedButton(
                  textColor: Colors.white,
                  color: StyleVBFactor.getMainColor(),
                  child: new Text('Votazione Kids'),
                  onPressed: () {
                    Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => KidsVote()));
                  },
                ),
              ),
              new Padding(
                  padding: new EdgeInsets.all(25),
                  child: new RaisedButton(
                    textColor: Colors.white,
                    color: StyleVBFactor.getMainColor(),
                    child: new Text('Votazione musical'),
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => MusicalVote()));
                    },
                  )),
            ],
          ),
        ));
  }
}
