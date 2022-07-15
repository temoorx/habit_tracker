import 'package:google_fonts/google_fonts.dart';
import 'package:flutter/material.dart';
import 'package:percent_indicator/percent_indicator.dart';

class HabitTile extends StatelessWidget {
  final String habitName;
  final VoidCallback onTap;
  final VoidCallback settings;
  final int timeSpent;
  final int timeGoal;
  final bool habitStarted;

  const HabitTile({Key? key, required this.habitName, required this.onTap, required this.settings, required this.timeSpent, required this.habitStarted, required this.timeGoal}) : super(key: key);

  //Convert seconds into mins:sec e.g: 62 seconds = 1:02 min

  String formatToMinSec(int totalSeconds) {
    String secs = (totalSeconds % 60).toString();
    String mins = (totalSeconds / 60).toStringAsFixed(4);

    // If sec is a 1 digit number, place  a 0 infront of it.
    if (secs.length == 1) {
      secs == '0' + secs;
    }

    //If min is a 1 digit number
    if (mins[1] == '.') {
      mins = mins.substring(0, 1);
    }

    return mins + ':' + secs;
  }

  //Calculate progress percentage
  double percentCompleted() {
    return timeSpent / timeGoal * 60;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 20, right: 20, top: 20),
      child: Container(
          decoration: BoxDecoration(color: Colors.grey[100], borderRadius: BorderRadius.circular(12.0)),
          padding: EdgeInsets.all(20.0),
          child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            //Percentage Indicator
            Row(children: [
              GestureDetector(
                onTap: onTap,
                child: SizedBox(
                    height: 50,
                    width: 50,
                    child: Stack(children: [
                      CircularPercentIndicator(
                        radius: 25,
                        percent: percentCompleted() < 1 ? percentCompleted() : 1,
                        progressColor: percentCompleted() > 0.5 ? (percentCompleted() > 0.75 ? Colors.green : Colors.orange) : Colors.red,
                      ),
                      //Play/Pause Icon
                      Center(child: Icon(habitStarted ? Icons.pause : Icons.play_arrow)),
                    ])),
              ),
              const SizedBox(width: 25),
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                //habit name
                Text(habitName,
                    style: GoogleFonts.poppins(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    )),
                SizedBox(
                  height: 4,
                ),
                //Progress
                Text(formatToMinSec(timeSpent) + '/ ' + timeGoal.toString() + '=' + percentCompleted().toStringAsFixed(0) + '%', style: GoogleFonts.poppins(color: Colors.grey))
              ])
            ]),
            GestureDetector(onTap: settings, child: Icon(Icons.settings)),
          ])),
    );
  }
}
