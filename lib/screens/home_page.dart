import 'dart:core';

import 'package:burayabakarlar/screens/timer.dart';
import 'package:burayabakarlar/values/theme.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';

class MainPage extends StatefulWidget {
  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  Stopwatch stopwatch = new Stopwatch();

  DateTime _currentTime;

  int days;
  int hours;
  int minutes;
  int seconds;

  bool _isSelected = false;

  @override
  void initState() {
    super.initState();
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("Home"),
        flexibleSpace: Container(
          decoration: BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: <Color>[blueBackgroundColor, greenBackgroundColor])),
        ),
      ),
      body: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            FlatButton(
                onPressed: () {
                  DatePicker.showDateTimePicker(context, showTitleActions: true,
                      onChanged: (date) {
                        //print('change $date in time zone ' + date.timeZoneOffset.inHours.toString());
                      }, onConfirm: (date) {
                        _isSelected = true;
                        _currentTime = date;
                        final remaining = _currentTime.difference(date);
                        this.days = remaining.inDays;
                        this.hours = remaining.inHours - days * 24;
                        this.minutes = remaining.inMinutes - hours * 60;
                        this.seconds = remaining.inSeconds - minutes * 60;
                        stopwatch.start();
                        setState(() {
                          DateInput(date: _currentTime);
                        });

                        String _formattedRemaining =
                            '$days : $hours : $minutes : $seconds';
                      }, currentTime: DateTime.now(), maxTime: DateTime.now());
                },
                child: Text(
                  'date time picker',
                  style: TextStyle(color: Colors.blue),
                )),
            new Container(
                height: 200.0,
                child: new Center(
                    child: _isSelected
                        ? DateInput(date: _currentTime)
                        : Container())),
          ],
        ),
      ),
    );
  }
}
