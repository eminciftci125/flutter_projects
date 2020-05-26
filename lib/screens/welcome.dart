import 'package:burayabakarlar/values/theme.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:burayabakarlar/values/gradient_app_bar.dart';

class Welcome extends StatefulWidget {
  @override
  _Welcome createState() => _Welcome();
}

class _Welcome extends State<Welcome> with TickerProviderStateMixin {
  List<Questions> questions = List();
  Questions question;
  DatabaseReference questionRef;
  TextEditingController _numberOfCigarettesSmokedPerDay;
  TextEditingController _numberOfCigarettesInPack;
  TextEditingController _priceOf;
  AnimationController _controller;
  Animation<Offset> _offsetFloatRightOne;
  Animation<Offset> _offsetFloatRightTwo;
  Animation<Offset> _offsetFloatLeftOne;
  Animation<Offset> _offsetFloatLeftTwo;

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    question = Questions("", "", "");
    final FirebaseDatabase database = FirebaseDatabase
        .instance; //Rather then just writing FirebaseDatabase(), get the instance.
    questionRef = database.reference().child('questions');
    questionRef.onChildAdded.listen(_onEntryAdded);
    questionRef.onChildChanged.listen(_onEntryChanged);

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
    );

    _offsetFloatRightOne =
        Tween<Offset>(begin: Offset(4.0, 0.0), end: Offset.zero)
            .animate(_controller);
    _offsetFloatLeftOne =
        Tween<Offset>(begin: Offset(-5.0, 0.0), end: Offset.zero)
            .animate(_controller);
    _offsetFloatRightTwo =
        Tween<Offset>(begin: Offset(6.0, 0.0), end: Offset.zero)
            .animate(_controller);
    _offsetFloatLeftTwo =
        Tween<Offset>(begin: Offset(-7.0, 0.0), end: Offset.zero)
            .animate(_controller);

    _controller.forward();
  }

  void handleSubmit() {
    final FormState form = formKey.currentState;

    if (form.validate()) {
      form.save();
      form.reset();
      questionRef.push().set(question.toJson());
    }
  }

  _onEntryAdded(Event event) {
    setState(() {
      questions.add(Questions.fromSnapshot(event.snapshot));
    });
  }

  _onEntryChanged(Event event) {
    var old = questions.singleWhere((entry) {
      return entry._boxcigarettescount == event.snapshot.key;
    });
    setState(() {
      questions[questions.indexOf(old)] =
          Questions.fromSnapshot(event.snapshot);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          new GradientAppBar("weDidIt"),
          Container(
            padding: EdgeInsets.fromLTRB(20, 10, 20, 10),
            child: SlideTransition(
              position: _offsetFloatRightOne,
              child: Card(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0)),
                elevation: 4.0,
                child: Padding(
                    padding: new EdgeInsets.all(10.0),
                    child: Row(
                      children: <Widget>[
                        Expanded(
                          flex: 7,
                          child: Text("Number of cigarettes smoked per day: "),
                        ),
                        Expanded(child: TextField())
                      ],
                    )),
              ),
            ),
          ),
          Container(
            padding: EdgeInsets.fromLTRB(20, 10, 20, 10),
            child: SlideTransition(
              position: _offsetFloatLeftOne,
              child: Card(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0)),
                elevation: 4.0,
                child: Padding(
                    padding: new EdgeInsets.all(10.0),
                    child: Row(
                      children: <Widget>[
                        Expanded(
                          flex: 7,
                          child: Text("Number of cigarettes in a pack: "),
                        ),
                        Expanded(child: TextField())
                      ],
                    )),
              ),
            ),
          ),
          Container(
            padding: EdgeInsets.fromLTRB(20, 10, 20, 10),
            child: SlideTransition(
              position: _offsetFloatRightTwo,
              child: Card(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0)),
                elevation: 4.0,
                child: Padding(
                    padding: new EdgeInsets.all(10.0),
                    child: Row(
                      children: <Widget>[
                        Expanded(
                          flex: 7,
                          child: Text("Price of a pack of cigarettes: "),
                        ),
                        Expanded(child: TextField())
                      ],
                    )),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class Questions {
  String key;
  String _boxprice;
  String _boxcigarettescount;
  String _dailycigarettescount;
  int _time;

  Questions(
      this._boxprice, this._boxcigarettescount, this._dailycigarettescount);

  Questions.fromSnapshot(DataSnapshot snapshot)
      : key = snapshot.key,
        _boxprice = snapshot.value["bp"],
        _boxcigarettescount = snapshot.value["bcc"],
        _dailycigarettescount = snapshot.value["dcc"];

  toJson() {
    return {
      "time": _time,
      "bp": _boxprice,
      "bcc": _boxcigarettescount,
      "dcc": _dailycigarettescount,
    };
  }
}
