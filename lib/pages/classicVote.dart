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
  GlobalKey<ScaffoldState> scaffoldState = new GlobalKey<ScaffoldState>();
  List<Concorrente> concorrentiCanto = Concorrente.returnListCanto(10);
  List<Concorrente> concorrentiBallo = Concorrente.returnListBallo(10);

  void incrementSMS(SmsMessage msg) {
    print('Messaggio ricevuto!');
    if (msg.body != '') {
      List<String> splitString = msg.body.split(new RegExp(' '));
      if (splitString.length > 0 && splitString.length == 7) {
        String code = splitString[0];
        if (VotingUtils.isCodeValid(code)) {
          int code1 = int.tryParse(splitString[1]);
          if (code1 == null || code1 <= 0 || code1 > 10) {
            return;
          }
          int code2 = int.tryParse(splitString[2]);
          if (code2 == null || code2 <= 0 || code2 > 10) {
            return;
          }
          int code3 = int.tryParse(splitString[3]);
          if (code3 == null || code3 <= 0 || code3 > 10) {
            return;
          }
          int code4 = int.tryParse(splitString[4]);
          if (code4 == null || code4 <= 0 || code4 > 10) {
            return;
          }
          int code5 = int.tryParse(splitString[5]);
          if (code5 == null || code5 <= 0 || code5 > 10) {
            return;
          }
          int code6 = int.tryParse(splitString[6]);
          if (code6 == null || code6 <= 0 || code6 > 10) {
            return;
          }
          if (code1 == code2 || code1 == code3 || code2 == code3) {
            return;
          }
          if (code4 == code5 || code4 == code6 || code5 == code6) {
            return;
          }
          concorrentiCanto[code1 - 1].voti =
              concorrentiCanto[code1 - 1].voti + 1;
          concorrentiCanto[code2 - 1].voti =
              concorrentiCanto[code2 - 1].voti + 1;
          concorrentiCanto[code3 - 1].voti =
              concorrentiCanto[code3 - 1].voti + 1;
          concorrentiBallo[code4 - 1].voti =
              concorrentiBallo[code4 - 1].voti + 1;
          concorrentiBallo[code5 - 1].voti =
              concorrentiBallo[code5 - 1].voti + 1;
          concorrentiBallo[code6 - 1].voti =
              concorrentiBallo[code6 - 1].voti + 1;
        }
      }
    }
  }

  @override
  void initState() {
    super.initState();
    VotingUtils.generateCodeList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: scaffoldState,
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
                                  new Text(
                                      concorrentiCanto[i - 1].voti.toString())
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
                                  new Text(
                                      concorrentiBallo[i - 1].voti.toString())
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
        ),
        floatingActionButton: new Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          mainAxisAlignment: MainAxisAlignment.end,
          children: <Widget>[
            new Padding(
              padding: EdgeInsets.all(5),
              child: new FloatingActionButton(
                heroTag: null,
                onPressed: () {
                  final snackBar = new SnackBar(
                    content: Text("Votazione in corso..."),
                  );
                  VBSMSReciver.startListenToSMS(incrementSMS);
                  scaffoldState.currentState.showSnackBar(snackBar);
                },
                child: new Icon(Icons.play_arrow),
              ),
            ),
            new Padding(
              padding: EdgeInsets.all(5),
              child: new FloatingActionButton(
                heroTag: null,
                onPressed: () {
                  VotingUtils.generateCodeList();
                  VBSMSReciver.stopListenToSMS();
                  setState(() {});
                },
                child: new Icon(Icons.stop),
              ),
            ),
            new Padding(
              padding: EdgeInsets.all(5),
              child: new FloatingActionButton(
                heroTag: null,
                onPressed: () {                 
                  concorrentiCanto = Concorrente.returnListCanto(10);
                  concorrentiBallo = Concorrente.returnListBallo(10);
                  setState(() {});
                },
                child: new Icon(Icons.delete),
              ),
            )
          ],
        ));
  }
}
