import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_chart_exam/data/post/api.dart';
import 'package:flutter_chart_exam/data/respose/covid/features.dart';
import 'package:flutter_chart_exam/data/respose/covid/properti.dart';
import 'package:flutter_chart_exam/data/respose/ordinal_sales.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:flutter_chart_exam/data/respose/timeline.dart';
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
    state.covidModel?.All.dates.forEach((key, value) {
      if (value > 200) {
        listask.add(FetchData(key, value));
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
                child: Column(
                  children: [
                    Expanded(
                      child: charts.BarChart(
                        timeline,
                        animate: true,
                        //độ nghiêng label trục x
                        domainAxis: charts.OrdinalAxisSpec(
                            renderSpec: charts.SmallTickRendererSpec(
                                labelRotation: 80)),
                        //vertical: false,
                        //animationDuration: Duration(seconds: 2),
                        behaviors: [
                          new charts.ChartTitle('Bệnh Nhân',
                              behaviorPosition: charts.BehaviorPosition.start,
                              titleStyleSpec:
                                  charts.TextStyleSpec(fontSize: 14))
                        ],
                        barRendererDecorator: charts.BarLabelDecorator(
                            outsideLabelStyleSpec: charts.TextStyleSpec()),
                      ),
                    ),
                  ],
                ),
              ),
      ),
    );
  }

  @override
  BaseBloc createBloc() =>
      BarChartBloc(context.read<Api>())..add(BarChartEvent());
}
