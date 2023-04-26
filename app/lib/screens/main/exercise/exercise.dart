import 'package:flutter/material.dart';
import 'dart:async';

class Exercise extends StatefulWidget {
  @override
  _ExerciseState createState() => _ExerciseState();
}

class _ExerciseState extends State<Exercise> {
  List<String> exercises = ['Push-ups','Squats', 'Lunges','Plank','Jumping Jacks',];
  Timer ? _timer;
  int _start = 30;
  bool _isRunning = false;
  int _selectedIndex = 0;

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

  void _onExerciseSelected(int index) {
    setState(() {
      _selectedIndex = index;
    });
    stopTimer();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Exercise'),
        actions: [
          Container(
            width: 100,
            height: 50,
            child: IconButton(
              onPressed: () {
                Navigator.pushNamed(
                  context,
                  "/tracker",
                );
              },
              icon: Row(
                children: [
                  Expanded(
                    child: Text("Track workout"),
                  ),
                  Icon(Icons.history),
                ],
              ),
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Container(
              height: 500,
              child: Column(
                children: [
                  Center(
                    child: Text(
                    exercises[_selectedIndex],
                    style: Theme.of(context).textTheme.headline2,
                    )
                  ),
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
                  Container(
                    height: 300,
                    child: ListView.builder(
                      itemCount: exercises.length,
                      itemBuilder: (context, index) {
                        return ListTile(
                          title: Text(exercises[index]),
                          onTap: () => _onExerciseSelected(index),
                          selected: _selectedIndex == index,
                        );
                      },
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
