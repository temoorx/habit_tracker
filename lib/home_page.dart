import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:habittracker/util/habit_tile.dart';
import 'package:google_fonts/google_fonts.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
// Habbit summary
  List habitList = [
    // habitname, habitstarted(false), timespent (sec), timegoal (min)
    [
      'Exercise',
      false,
      0,
      10
    ],
    [
      'Read',
      false,
      0,
      40
    ],
    [
      'Meditate',
      false,
      0,
      20
    ],
    [
      'Learn',
      false,
      0,
      30
    ],
  ];

  void habitStarted(int index) {
    // note what the start time is
    var startTime = DateTime.now();

    //inculde the time already elapsed
    int elapsedTime = habitList[index][2];

    //habit started or stopped
    setState(() {
      habitList[index][1] = !habitList[index][1];
    });

    //Timer
    if (habitList[index][1]) {
      Timer.periodic(Duration(seconds: 1), (timer) {
        //check when user has stopped the timer
        setState(() {
          if (!habitList[index][1]) {
            timer.cancel();
          }
        });

        //Calculate the time elapsed by comparing current time with start time
        var currentTime = DateTime.now();
        habitList[index][2] = elapsedTime + currentTime.second - startTime.second + 60 * (currentTime.minute - startTime.minute) + 60 * 60 * (currentTime.hour - startTime.hour);
      });
    }
  }

  void settingOpened(int index) {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(title: Text('Settings for ' + habitList[index][0]));
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.grey[300],
        appBar: AppBar(
          backgroundColor: Colors.grey[900],
          title: Text('Consistency is key', style: GoogleFonts.poppins()),
          centerTitle: false,
        ),
        body: ListView.builder(
            itemCount: habitList.length,
            itemBuilder: (context, index) => HabitTile(
                habitName: habitList[index][0],
                habitStarted: habitList[index][1],
                onTap: () {
                  habitStarted(index);
                },
                settings: () {
                  settingOpened(index);
                },
                timeSpent: habitList[index][2],
                timeGoal: habitList[index][3])));
  }
}
