import 'package:flutter/material.dart';
import 'package:flutter_chart_exam/data/respose/ordinal_sales.dart';
import 'package:charts_flutter/flutter.dart' as charts;

class BarChartView extends StatefulWidget {
  BarChartView({Key? key}) : super(key: key);

  @override
  _BarChartViewState createState() => _BarChartViewState();
}

class _BarChartViewState extends State<BarChartView> {
  @override
  Widget build(BuildContext context) {
    final List<Task> listask = [
      Task(task: 'Work ', value: 35.8, colorValue: Colors.amber),
      Task(task: 'Eat', value: 8.3, colorValue: Colors.amberAccent),
      Task(task: 'Commute', value: 10.8, colorValue: Colors.black),
      Task(task: 'TV', value: 15.6, colorValue: Colors.blue),
      Task(task: 'Sleep', value: 19.2, colorValue: Colors.blueAccent),
      Task(task: 'Other', value: 10.3, colorValue: Colors.blueGrey),
    ];
    List<charts.Series<Task, String>> timeline = [
      charts.Series(
        id: 'Subscribes',
        data: listask,
        domainFn: (Task timeline, _) => timeline.task,
        measureFn: (Task timeline, _) => timeline.value,
        colorFn: (Task timeline, _) =>
            charts.ColorUtil.fromDartColor(timeline.colorValue),
        labelAccessorFn: (Task row, _) => '${row.value}',
      )
    ];
    return Scaffold(
      appBar: AppBar(
        title: Text('Chart Flutter'),
      ),
      body: Center(
        child: Container(
          height: 400,
          padding: EdgeInsets.all(20),
          child: Column(
            children: [
              Text(
                'Cristiano Ronaldo Earnings (\$M)',
              ),
              Expanded(
                child: charts.BarChart(
                  timeline,
                  animate: true,
                  //vertical: false,
                  //animationDuration: Duration(seconds: 2),
                  behaviors: [
                    charts.DatumLegend(
                      outsideJustification:
                          charts.OutsideJustification.endDrawArea,
                      horizontalFirst: false,
                      desiredMaxRows: 2,
                      cellPadding: EdgeInsets.only(right: 4.0, bottom: 4.0),
                      entryTextStyle: charts.TextStyleSpec(
                        color: charts.MaterialPalette.purple.shadeDefault,
                      ),
                    ),
                  ],
                  barRendererDecorator: charts.BarLabelDecorator(
                      outsideLabelStyleSpec: charts.TextStyleSpec()),
                ),
              ),
              Text(
                'Source: Forbes',
              ),
            ],
          ),
        ),
      ),
    );
  }
}
