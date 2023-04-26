import 'dart:async';
import 'package:flutter/material.dart';


class WorkoutTimerHomePage extends StatefulWidget {
  WorkoutTimerHomePage({Key? key}) : super(key: key);
  @override
  _WorkoutTimerHomePageState createState() => _WorkoutTimerHomePageState();
}

class _WorkoutTimerHomePageState extends State<WorkoutTimerHomePage> {
  Timer ? _timer;
  int _start = 30;
  bool _isRunning = false;

  void startTimer() {
    const oneSec = const Duration(seconds: 1);
    if (!_isRunning) {
      _timer = new Timer.periodic(
        oneSec,
        (Timer timer) => setState(
          () {
            if (_start < 1) {
              timer.cancel();
            } else {
              _start = _start - 1;
            }
          },
        ),
      );
      setState(() {
        _isRunning = true;
      });
    }
  }

  void pauseTimer() {
    if (_isRunning) {
      _timer?.cancel();
      setState(() {
        _isRunning = false;
      });
    }
  }

  void stopTimer() {
    if (_timer != null) {
      _timer?.cancel();
      setState(() {
        _isRunning = false;
        _start = 30;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
            'Time remaining:',
          ),
          Text(
            '$_start',
            style: Theme.of(context).textTheme.headline4,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              ElevatedButton(
                onPressed: _isRunning ? pauseTimer: startTimer,
                child: Text(_isRunning ? 'Pause' : 'Start'),
              ),
              SizedBox(width: 10),
              ElevatedButton(
                onPressed: stopTimer,
                child: Text('Stop'),
              ),
              SizedBox(width: 10),
              ElevatedButton(
                onPressed: () {
                  stopTimer();
                  startTimer();
                },
                child: Text('Reset'),
              ),
            ],
          ),
        ],
      ),
    );
  }
}


