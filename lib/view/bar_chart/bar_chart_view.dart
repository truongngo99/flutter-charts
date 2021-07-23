import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_chart_exam/data/post/api.dart';

import 'package:charts_flutter/flutter.dart' as charts;
import 'package:flutter_chart_exam/data/respose/fetch_data.dart';
import 'package:flutter_chart_exam/view/bar_chart/bar_chart_bloc.dart';
import 'package:flutter_chart_exam/view/bar_chart/bar_chart_event.dart';
import 'package:flutter_chart_exam/view/bar_chart/bar_chart_state.dart';
import 'package:teq_flutter_core/teq_flutter_core.dart';

class BarChartView extends StatefulWidget {
  final String title;
  BarChartView({Key? key, required this.title}) : super(key: key);

  @override
  _BarChartViewState createState() => _BarChartViewState();
}

class _BarChartViewState extends BaseBlocState<BarChartView> {
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
                padding: EdgeInsets.all(20),
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
                        child: charts.BarChart(
                          timeline,
                          animate: true,
                          //độ nghiêng label trục x
                          domainAxis: charts.OrdinalAxisSpec(
                              renderSpec: charts.SmallTickRendererSpec(
                                  labelRotation: 80)),
                          // vertical: false,
                          //animationDuration: Duration(seconds: 2),
                          behaviors: [
                            new charts.ChartTitle('Người chết',
                                behaviorPosition: charts.BehaviorPosition.start,
                                titleStyleSpec:
                                    charts.TextStyleSpec(fontSize: 14))
                          ],
                          // barRendererDecorator: charts.BarLabelDecorator(
                          //     outsideLabelStyleSpec: charts.TextStyleSpec()),
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
