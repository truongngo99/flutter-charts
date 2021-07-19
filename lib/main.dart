import 'package:flutter/material.dart';
import 'package:flutter_chart_exam/view/bar_chart/bar_chart_view.dart';
import 'package:flutter_chart_exam/view/time_chart/time_chart_basic_view.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: TimeChartBasic(),
    );
  }
}
