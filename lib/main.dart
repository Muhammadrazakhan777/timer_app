import 'dart:async';
import 'dart:html';

import 'package:flutter/material.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: Clock(),
  ));
}

class Clock extends StatefulWidget {
  @override
  _ClockState createState() => _ClockState();
}

class _ClockState extends State<Clock> {
  double percent = 0;
  static int TimeInMinute = 25;
  int TimeInSec = TimeInMinute * 60;
  Timer timer;
  _startTime() {
    TimeInMinute = 25;
    int Time = TimeInMinute * 60;
    double secPercent = (Time / 100);
    timer = Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() {
        if (Time > 0) {
          Time--;
        }
        if (Time % 60 == 0) {
          TimeInMinute--;
        }
        if (Time % secPercent == 0) {
          if (percent < 1) {
            percent += 0.01;
          } else {
            percent = 1;
          }
        } else {
          percent = 0;
          TimeInMinute = 25;
          timer.cancel();
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color(0xFF1542bf),
              Color(0xff51a8ff),
            ],
            begin: FractionalOffset(5, 1),
          ),
        ),
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: EdgeInsets.only(top: 18),
              child: Text(
                'Clock',
                style: TextStyle(color: Colors.white, fontSize: 40),
              ),
            ),
            Expanded(
              child: CircularPercentIndicator(
                circularStrokeCap: CircularStrokeCap.round,
                percent: percent,
                radius: 250.0,
                animation: true,
                animateFromLastPercent: true,
                lineWidth: 20.0,
                progressColor: Colors.white,
                center: Text(
                  '$TimeInMinute',
                  style: TextStyle(color: Colors.white, fontSize: 50),
                ),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Expanded(
              child: Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(30),
                    topRight: Radius.circular(20),
                  ),
                ),
                child: Padding(
                  padding: EdgeInsets.only(top: 30, left: 20, right: 20),
                  child: Column(
                    children: [
                      Expanded(
                        child: Row(
                          children: [
                            Expanded(
                              child: Column(
                                children: [
                                  Text(
                                    'Study Timer',
                                    style: TextStyle(fontSize: 30),
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Text(
                                    '25',
                                    style: TextStyle(fontSize: 80),
                                  ),
                                ],
                              ),
                            ),
                            Expanded(
                              child: Column(
                                children: [
                                  Text(
                                    'Pause Time',
                                    style: TextStyle(fontSize: 30),
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Text(
                                    '25',
                                    style: TextStyle(fontSize: 80),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(vertical: 20),
                        child: TextButton(
                          child: Text(
                            'start Studying',
                            style: TextStyle(fontSize: 25),
                          ),
                          onPressed: () {
                            _startTime();
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    ));
  }
}
