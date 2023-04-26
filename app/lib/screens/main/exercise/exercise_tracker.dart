import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;


class Tracker extends StatelessWidget {
  // Generate some mockup data for the chart
  final List<ExerciseTime> data = [
    ExerciseTime('Push-ups', 30),
    ExerciseTime('Squats', 60),
    ExerciseTime('Lunges', 120),
    ExerciseTime('Plank', 30),
    ExerciseTime('Jumping Jacks', 0),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Exercise Tracker'),
      ),
      body: Center(
        child: ExerciseChart(data),
      ),
    );
  }
}

class ExerciseTime {
  final String exercise;
  final int time;

  ExerciseTime(this.exercise, this.time);
}

class ExerciseChart extends StatelessWidget {
  final List<ExerciseTime> data;

  ExerciseChart(this.data);

  @override
  Widget build(BuildContext context) {
    // Create a series from the data
    final series = [
      charts.Series(
        id: 'Exercise Time',
        data: data,
        domainFn: (ExerciseTime time, _) => time.exercise,
        measureFn: (ExerciseTime time, _) => time.time,
        labelAccessorFn: (ExerciseTime time, _) => '${time.time} min',
      ),
    ];

    return Padding (padding: EdgeInsets.all(20),
      child: charts.BarChart(
        series,
        animate: true,
        // Configure the chart's appearance
        domainAxis: charts.OrdinalAxisSpec(
          renderSpec: charts.SmallTickRendererSpec(
            labelStyle: charts.TextStyleSpec(fontSize: 14,color: charts.MaterialPalette.white),
          ),
        ),
        primaryMeasureAxis: charts.NumericAxisSpec(
          renderSpec: charts.GridlineRendererSpec(
            labelStyle: charts.TextStyleSpec(fontSize: 14,color: charts.MaterialPalette.white),
          ),
        ),
        // Add a chart title
        defaultRenderer: charts.BarRendererConfig(
          groupingType: charts.BarGroupingType.grouped,
          strokeWidthPx: 2.0,
        ),
        // Set the chart title using the ChartTitle widget
        behaviors: [
          charts.ChartTitle(
            'Time Spent on Each Exercise',
            behaviorPosition: charts.BehaviorPosition.top,
            titleOutsideJustification: charts.OutsideJustification.start,
            innerPadding: 18,
            titleStyleSpec: charts.TextStyleSpec(
              color: charts.MaterialPalette.white
            ),
          ),
        ],
      )
    );
  }
}
