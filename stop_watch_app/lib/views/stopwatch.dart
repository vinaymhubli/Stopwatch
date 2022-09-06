import 'dart:async';

import 'package:flutter/material.dart';

class StopwatchHome extends StatefulWidget {
  StopwatchHome({Key? key}) : super(key: key);

  @override
  State<StopwatchHome> createState() => _StopwatchHomeState();
}

class _StopwatchHomeState extends State<StopwatchHome> {
  int seconds = 0, minutes = 0, hours = 0;

  String digitsecounds = "00", digitminutes = "00", digithours = "00";
  Timer? timer;
  bool started = false;
  List laps = [];

  void stop() {
    timer!.cancel();
    setState(() {
      started = false;
    });
  }

  void reset() {
    timer!.cancel();
    setState(() {
      seconds = 0;
      minutes = 0;
      hours = 0;

      digitsecounds = "00";
      digitminutes = "00";
      digithours = "00";
      started = false;
    });
    String lap = "$digithours:$digitminutes:$digitsecounds";
    setState(() {
      laps.clear();
    });
  }

  void addlaps() {
    String lap = "$digithours:$digitminutes:$digitsecounds";
    setState(() {
      laps.add(lap);
    });
  }

  void start() {
    started = true;
    timer = Timer.periodic(Duration(seconds: 1), (timer) {
      int localSecounds = seconds + 1;
      int localMinutes = minutes;
      int localHours = hours;
      if (localSecounds > 59) {
        if (localMinutes > 59) {
          localHours++;
          localMinutes = 0;
        } else {
          localMinutes++;
          localSecounds = 0;
        }
      }
      setState(() {
        seconds = localSecounds;
        minutes = localMinutes;
        hours = localHours;
        digitsecounds = (seconds >= 10) ? "$seconds" : "0$seconds";
        digithours = (hours >= 10) ? "$hours" : "0$hours";
        digitminutes = (minutes >= 10) ? "$minutes" : "0$minutes";
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:
          // const Color(0xff213a20),
          Color.fromARGB(255, 138, 11, 87),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(18),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Center(
                child: Text(
                  "Stopwatch",
                  style: TextStyle(
                    color: Color.fromARGB(255, 247, 231, 10),
                    fontWeight: FontWeight.bold,
                    fontSize: 40,
                  ),
                ),
              ),
              SizedBox(height: 20.0),
              Center(
                child: Text(
                  "$digithours:$digitminutes:$digitsecounds",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 73.0,
                      fontWeight: FontWeight.bold),
                ),
              ),
              Container(
                height: 300.0,
                decoration: BoxDecoration(
                    color: Color.fromARGB(255, 162, 109, 145),
                    borderRadius: BorderRadius.circular(10)),
                child: ListView.builder(
                    itemCount: laps.length,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.all(18.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "‣ Lap Number  ${index + 1}     ➡",
                              style:
                                  TextStyle(color: Colors.white, fontSize: 16),
                            ),
                            Text("${laps[index]}",
                                style: TextStyle(
                                    color: Colors.white, fontSize: 16))
                          ],
                        ),
                      );
                    }),
              ),
              SizedBox(height: 23),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                      child: RawMaterialButton(
                    onPressed: () {
                      (!started) ? start() : stop();
                    },
                    fillColor: Color.fromARGB(255, 73, 119, 4),
                    shape: StadiumBorder(side: BorderSide(color: Colors.blue)),
                    child: Text(
                      (!started) ? "START" : "PAUSE",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          fontStyle: FontStyle.italic),
                    ),
                  )),
                  SizedBox(width: 8),
                  IconButton(
                      onPressed: () {
                        addlaps();
                      },
                      icon: Icon(
                        Icons.timelapse_rounded,
                        color: Colors.red,
                      )),
                  Expanded(
                      child: RawMaterialButton(
                    onPressed: () {
                      reset();
                    },
                    fillColor: Color.fromARGB(255, 132, 9, 23),
                    shape: StadiumBorder(
                        side: BorderSide(
                            color: Color.fromARGB(255, 40, 129, 11))),
                    child: Text(
                      "RESET",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          fontStyle: FontStyle.italic),
                    ),
                  ))
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
