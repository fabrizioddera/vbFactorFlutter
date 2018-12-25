import 'package:flutter/material.dart';
import 'package:sms/sms.dart';
import 'concorrenti.dart';
import 'smsReceiver.dart';
import 'votingUtils.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
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
    if(msg.body != ''){
    List<String> splitString = msg.body.split(new RegExp(' '));
    if(splitString.length > 0 && splitString.length == 7){
      String code = splitString[0];
      if(VotingUtils.isCodeValid(code)){
        int code1 = int.tryParse(splitString[1]);
        if(code1 == null){
          return;
        }
      }
    }
    setState(() {});
    }
  }

  @override
  void initState(){
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
          child: new ListView.builder(
        itemCount: concorrentiCanto.length,
        itemBuilder: (context, i) {
          return new Container(
              padding: new EdgeInsets.all(5.0),
              child: new Row(children: <Widget>[
                new Column(
                  children: <Widget>[
                    new Row(
                      children: <Widget>[
                        new Icon(Icons.android),
                        new Text("Concorrente: "),
                        new Text("$i"),
                      ],
                    ),
                    new Row(
                      children: <Widget>[
                        new Text("Voti: "),
                        new Text(concorrentiCanto[i].voti.toString())
                      ],
                    )
                  ],
                )
              ]));
        },
      )),
    );
  }
}
