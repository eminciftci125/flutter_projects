import 'package:burayabakarlar/values/theme.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';

class Welcome extends StatefulWidget {
  @override
  _Welcome createState() => _Welcome();
}

class _Welcome extends State<Welcome> {
  List<Questions> questions = List();
  Questions question;
  DatabaseReference questionRef;
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    question = Questions("","","");
    final FirebaseDatabase database = FirebaseDatabase
        .instance; //Rather then just writing FirebaseDatabase(), get the instance.
    questionRef = database.reference().child('questions');
    questionRef.onChildAdded.listen(_onEntryAdded);
    questionRef.onChildChanged.listen(_onEntryChanged);
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
       mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Flexible(
            flex: 0,
            child: Center(
              child: Form(
                key: formKey,
                child: Flex(
                  direction: Axis.vertical,
                  children: <Widget>[
                    ListTile(
                     
                      title: TextFormField(
                        decoration: InputDecoration(
                          hintText: 'Kutuda kac smoke',
                          icon: new Icon(
                            Icons.add_circle,
                            color: Colors.black54,
                          ),
                        ),
                        initialValue: "",
                        onSaved: (val) => question._boxcigarettescount = val,
                        validator: (val) => val == "" ? val : null,
                      ),
                    ),
                    ListTile(

                      title: TextFormField(
                        decoration: InputDecoration(
                          hintText: 'günlük içilen',
                          icon: new Icon(
                            Icons.add_circle,
                            color: Colors.black54,
                          ),
                        ),
                        initialValue: '',
                        onSaved: (val) => question._dailycigarettescount = val,
                        validator: (val) => val == "" ? val : null,
                      ),
                    ),  ListTile(
                     
                      title: TextFormField(
                        decoration: InputDecoration(
                          hintText: 'Kutu Fiyat',
                          icon: new Icon(
                            Icons.add_circle,
                            color: Colors.black54,
                          ),
                        ),
                        initialValue: '',
                        onSaved: (val) => question._boxprice = val,
                        validator: (val) => val == "" ? val : null,
                      ),
                    ),
                    IconButton(
                      icon: Icon(Icons.send),
                      onPressed: () {
                        handleSubmit();
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),
          Flexible(
            child: FirebaseAnimatedList(
              query: questionRef,
              itemBuilder: (BuildContext context, DataSnapshot snapshot,
                  Animation<double> animation, int index) {
                return new ListTile(
                  leading: Icon(Icons.message),
                  title: Text(questions[index]._boxprice.toString()),
                  subtitle: Text(questions[index]._boxcigarettescount.toString()),
                );
              },
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
       _boxprice =  snapshot.value["bp"],
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
