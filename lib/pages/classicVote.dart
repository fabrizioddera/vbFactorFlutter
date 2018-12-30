import 'package:flutter/material.dart';
import 'package:sms/sms.dart';
import '../concorrenti.dart';
import '../smsReceiver.dart';
import '../votingUtils.dart';
import '../my_custom_class_icons.dart';

class ClassicVote extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: ClassicVoteStateful(title: 'Flutter Demo Home Page'),
    );
  }
}

class ClassicVoteStateful extends StatefulWidget {
  ClassicVoteStateful({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _ClassicVoteState createState() => _ClassicVoteState();
}

class _ClassicVoteState extends State<ClassicVoteStateful> {
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
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
          child: new Column(
        children: <Widget>[
          new ListView.builder(
            itemCount: concorrentiCanto.length,
            itemBuilder: (context, i) {
              return new Container(
                  padding: new EdgeInsets.all(5.0),
                  child: new Row(children: <Widget>[
                    new Column(
                      children: <Widget>[
                        new Row(
                          children: <Widget>[
                            new Icon(MyCustomClass.microphone),
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
          ),
          new ListView.builder(
            itemCount: concorrentiBallo.length,
            itemBuilder: (context, i) {
              return new Container(
                  padding: new EdgeInsets.all(5.0),
                  child: new Row(children: <Widget>[
                    new Column(
                      children: <Widget>[
                        new Row(
                          children: <Widget>[
                            new Icon(MyCustomClass.ballet),
                            new Text("Concorrente: "),
                            new Text("$i"),
                          ],
                        ),
                        new Row(
                          children: <Widget>[
                            new Text("Voti: "),
                            new Text(concorrentiBallo[i].voti.toString())
                          ],
                        )
                      ],
                    )
                  ]));
            },
          )
        ],
      )),
    );
  }
}
