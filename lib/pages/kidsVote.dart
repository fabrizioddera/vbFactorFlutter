import 'package:flutter/material.dart';
import 'package:sms/sms.dart';
import '../concorrenti.dart';
import '../smsReceiver.dart';
import '../style.dart';
import '../votingUtils.dart';
import '../my_custom_class_icons.dart';

class KidsVote extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'VB Factor 2019',
      theme: ThemeData(
        primarySwatch: StyleVBFactor.getMainColorMaterial(),
      ),
      home: KidsVoteStateful(title: 'VB Factor 2019 Votazione Kids'),
    );
  }
}

class KidsVoteStateful extends StatefulWidget {
  KidsVoteStateful({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _KidsVoteState createState() => _KidsVoteState();
}

class _KidsVoteState extends State<KidsVoteStateful> {
  GlobalKey<ScaffoldState> scaffoldState = new GlobalKey<ScaffoldState>();
  List<Concorrente> concorrentiCanto = Concorrente.returnListCanto(5);
  List<Concorrente> concorrentiBallo = Concorrente.returnListBallo(5);

  void incrementSMS(SmsMessage msg) {
    if (msg.body != '') {
      List<String> splitString = msg.body.split(new RegExp(' '));
      if (splitString.length > 0 && splitString.length == 3) {
        String code = splitString[0];
        if (VotingUtils.isCodeValid(code)) {
          int code1 = int.tryParse(splitString[1]);
          if (code1 == null || code1 <= 0 || code1 > 6) {
            return;
          }
          int code2 = int.tryParse(splitString[2]);
          if (code2 == null || code2 <= 0 || code2 > 6) {
            return;
          }
          concorrentiCanto[code1 - 1].voti =
              concorrentiCanto[code1 - 1].voti + 1;
          concorrentiBallo[code2 - 1].voti =
              concorrentiBallo[code2 - 1].voti + 1;
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
                  scaffoldState.currentState.showSnackBar(snackBar);
                  VBSMSReciver.startListenToSMS(incrementSMS);
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
                  concorrentiCanto = Concorrente.returnListCanto(5);
                  concorrentiBallo = Concorrente.returnListBallo(5);
                  setState(() {});
                },
                child: new Icon(Icons.delete),
              ),
            )
          ],
        ));
  }
}
