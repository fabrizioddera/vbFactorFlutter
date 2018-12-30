import 'package:flutter/material.dart';
import 'package:sms/sms.dart';
import '../concorrenti.dart';
import '../smsReceiver.dart';
import '../votingUtils.dart';
import '../my_custom_class_icons.dart';
import '../style.dart';

class MusicalVote extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
         primarySwatch: StyleVBFactor.getMainColorMaterial(),
      ),
      home: MusicalVoteStateful(title: 'Flutter Demo Home Page'),
    );
  }
}

class MusicalVoteStateful extends StatefulWidget {
  MusicalVoteStateful({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MusicalVoteState createState() => _MusicalVoteState();
}

class _MusicalVoteState extends State<MusicalVoteStateful> {
  List<Concorrente> concorrentiMusical = Concorrente.returnListCanto(10);

  void incrementSMS(SmsMessage msg) {
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
          concorrentiMusical[code1 - 1].voti =
              concorrentiMusical[code1 - 1].voti + 1;
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
                  itemCount: concorrentiMusical.length,
                  itemBuilder: (context, i) {
                    i = i + 1;
                    return new Container(
                        padding: new EdgeInsets.all(5.0),
                        child: new Row(children: <Widget>[
                          new Column(
                            children: <Widget>[
                              new Row(
                                children: <Widget>[
                                  new Icon(MyCustomClass.music_player),
                                  new Text("Concorrente: "),
                                  new Text("$i"),
                                ],
                              ),
                              new Row(
                                children: <Widget>[
                                  new Text("Voti: "),
                                  new Text(
                                      concorrentiMusical[i - 1].voti.toString())
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
                  concorrentiMusical = Concorrente.returnListCanto(10);
                  setState(() {});
                },
                child: new Icon(Icons.delete),
              ),
            )
          ],
        ));
  }
}