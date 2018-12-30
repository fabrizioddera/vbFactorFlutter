import 'package:flutter/material.dart';
import 'package:sms/sms.dart';
import '../concorrenti.dart';
import '../smsReceiver.dart';
import '../votingUtils.dart';
import '../my_custom_class_icons.dart';
import '../style.dart';

class ClassicVote extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'VB Factor 2019',
      theme: ThemeData(
        primarySwatch: StyleVBFactor.getMainColorMaterial(),
      ),
      home: ClassicVoteStateful(title: 'VB Factor 2019 Votazione Classica'),
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
        body: CustomScrollView(
      slivers: <Widget>[
        SliverAppBar(
          title: Text(widget.title),
        ),
        SliverList(
          delegate: SliverChildListDelegate([
            ListView.builder(
              shrinkWrap: true,
              physics: ClampingScrollPhysics(),
              itemCount: concorrentiCanto.length,
              itemBuilder: (context, i) {
                i = i + 1;
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
                              new Text(concorrentiCanto[i - 1].voti.toString())
                            ],
                          )
                        ],
                      )
                    ]));
              },
            )
          ]),
        ),
        SliverList(
          delegate: SliverChildListDelegate([
            new ListView.builder(
              shrinkWrap: true,
              physics: ClampingScrollPhysics(),
              itemCount: concorrentiBallo.length,
              itemBuilder: (context, i) {
                i = i + 1;
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
                              new Text(concorrentiBallo[i - 1].voti.toString())
                            ],
                          )
                        ],
                      )
                    ]));
              },
            )
          ]),
        )
      ],
    ));
  }
}
