import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:flutter_chart_exam/data/respose/ordinal_sales.dart';

class TimeChartBasic extends StatefulWidget {
  TimeChartBasic({Key? key}) : super(key: key);

  @override
  _TimeChartBasicState createState() => _TimeChartBasicState();
}

class _TimeChartBasicState extends State<TimeChartBasic> {
  final List<Task> createSampleData=[
    var desktopSalesData = [
      Task(task: 'Work ', value: 35.8, colorValue: Colors.amber),
      Task(task: 'Eat', value: 8.3, colorValue: Colors.amberAccent),
      Task(task: 'Commute', value: 10.8, colorValue: Colors.black),
      Task(task: 'TV', value: 15.6, colorValue: Colors.blue),
      Task(task: 'Sleep', value: 19.2, colorValue: Colors.blueAccent),
      Task(task: 'Other', value: 10.3, colorValue: Colors.blueGrey),
    ]

    final tableSalesData = [
      Task(task: 'Work ', value: 45.8, colorValue: Colors.amber),
      Task(task: 'Eat', value: 9.3, colorValue: Colors.amberAccent),
      Task(task: 'Commute', value: 15.8, colorValue: Colors.black),
      Task(task: 'TV', value: 19.6, colorValue: Colors.blue),
      Task(task: 'Sleep', value: 12.2, colorValue: Colors.blueAccent),
      Task(task: 'Other', value: 19.3, colorValue: Colors.blueGrey),
    ];

    final mobileSalesData = [
      Task(task: 'Work ', value: 40.8, colorValue: Colors.amber),
      Task(task: 'Eat', value: 12.3, colorValue: Colors.amberAccent),
      Task(task: 'Commute', value: 24.8, colorValue: Colors.black),
      Task(task: 'TV', value: 37.6, colorValue: Colors.blue),
      Task(task: 'Sleep', value: 16.2, colorValue: Colors.blueAccent),
      Task(task: 'Other', value: 15.3, colorValue: Colors.blueGrey),
    ];

   
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Time Chart'),
      ),
      body: Center(child: Container(child: Expanded(
        child: charts.BarChart(
          
        ),
      ),),),
    );
  }
}
