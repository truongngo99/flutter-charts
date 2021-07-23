import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_chart_exam/data/post/api.dart';
import 'package:flutter_chart_exam/data/respose/covid/features.dart';
import 'package:flutter_chart_exam/data/respose/covid/properti.dart';
import 'package:flutter_chart_exam/data/respose/data_model.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:flutter_chart_exam/data/respose/fetch_data.dart';
import 'package:flutter_chart_exam/view/bar_chart/bar_chart_bloc.dart';
import 'package:flutter_chart_exam/view/bar_chart/bar_chart_event.dart';
import 'package:flutter_chart_exam/view/bar_chart/bar_chart_state.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:teq_flutter_core/teq_flutter_core.dart';

class ScatleChartView extends StatefulWidget {
  final String title;
  ScatleChartView({Key? key, required this.title}) : super(key: key);

  @override
  _ScatleChartViewState createState() => _ScatleChartViewState();
}

class _ScatleChartViewState extends BaseBlocState<ScatleChartView> {
  @override
  Widget build(BuildContext context) => MultiBlocProvider(
      providers: [BlocProvider(create: (context) => bloc as BarChartBloc)],
      child: BaseBlocBuilder<BarChartState>(bloc as BarChartBloc, _buildBody));

  Widget _buildBody(BuildContext context, BarChartState state) {
    List<FetchData> listask = [];
    state.covidModel?.All.dates?.forEach((key, value) {
      if (int.parse(key.substring(5, 7)) == 7 &&
          int.parse(key.substring(0, 4)) == 2021) {
        listask.add(
            FetchData(key, value, charts.ColorUtil.fromDartColor(Colors.blue)));
      }
    });
    listask = listask.reversed.toList();
    print(listask.length);

    List<charts.Series<FetchData, String>> timeline = [
      charts.Series(
        id: 'Subscribes',
        data: listask,
        domainFn: (FetchData timeline, _) => timeline.date,
        measureFn: (FetchData timeline, _) => timeline.value,
        // colorFn: (Task timeline, _) =>
        //     charts.ColorUtil.fromDartColor(timeline.colorValue),
        labelAccessorFn: (FetchData row, _) => '${row.value}',
      )
    ];
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: state.isLoading
            ? CircularProgressIndicator()
            : Container(
                height: double.infinity,
                padding: EdgeInsets.all(10),
                child: Card(
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          'The number of deaths from COVID-19 in Vietnam in July',
                          style: TextStyle(color: Colors.red, fontSize: 18),
                        ),
                      ),
                      Expanded(
                        child: SfCartesianChart(
                          primaryXAxis: DateTimeAxis(),
                          series: <ChartSeries>[
                            ScatterSeries<FetchData, DateTime>(
                                dataSource: listask,
                                xValueMapper: (FetchData data, _) =>
                                    DateTime.parse(
                                        data.date.replaceAll('-', '')),
                                yValueMapper: (FetchData data, _) => data.value)
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
      ),
    );
  }

  @override
  BaseBloc createBloc() =>
      BarChartBloc(context.read<Api>())..add(BarChartEvent());
}
