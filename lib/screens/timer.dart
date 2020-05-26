import 'dart:async';

import 'package:flutter/cupertino.dart';

class DateInput extends StatefulWidget {
  DateInput({Key key, this.controller, this.date}) : super(key: key);
  DateTime date;
  final TextEditingController controller;

  @override
  _DateInputState createState() => _DateInputState(this.date);
}

class _DateInputState extends State<DateInput> {
  DateTime date;

  _DateInputState(this.date);

   String _currentDateTime;
  Timer _tickTock;

  @override
  void initState() {
    super.initState();
    _currentDateTime = date.toString();
    _tickTock = Timer.periodic(const Duration(seconds: 1), (Timer t) {
      if (mounted) {
        setState(() {
          _currentDateTime = DateTime.now().toString();
        });
      }
    });
  }

  @override
  void dispose() {
    _tickTock.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Text(_currentDateTime);
  }
}
