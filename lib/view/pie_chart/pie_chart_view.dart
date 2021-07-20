import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_chart_exam/data/post/api.dart';
import 'package:flutter_chart_exam/data/respose/covid/properti.dart';

import 'package:charts_flutter/flutter.dart' as charts;
import 'package:flutter_chart_exam/data/respose/timeline.dart';
import 'package:flutter_chart_exam/view/bar_chart/bar_chart_bloc.dart';
import 'package:flutter_chart_exam/view/bar_chart/bar_chart_event.dart';
import 'package:flutter_chart_exam/view/bar_chart/bar_chart_state.dart';
import 'package:teq_flutter_core/teq_flutter_core.dart';

class PieChartBasic extends StatefulWidget {
  final String title;
  PieChartBasic({Key? key, required this.title}) : super(key: key);

  @override
  _PieChartBasicState createState() => _PieChartBasicState();
}

class _PieChartBasicState extends BaseBlocState<PieChartBasic> {
  @override
  Widget build(BuildContext context) => MultiBlocProvider(
      providers: [BlocProvider(create: (context) => bloc as BarChartBloc)],
      child: BaseBlocBuilder<BarChartState>(bloc as BarChartBloc, _buildBody));

  Widget _buildBody(BuildContext context, BarChartState state) {
    List<FetchData> listask = [];
    state.covidModel?.All.dates.forEach((key, value) {
      if (value > 100) {
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
      body: Container(
        height: double.infinity,
        width: double.infinity,
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            Text(
              'Cristiano Ronaldo Earnings (\$M)',
            ),
            Expanded(
                child: charts.PieChart(
              timeline,
              animate: true,
            )),
            Text(
              'Source: Forbes',
            ),
          ],
        ),
      ),
    );
  }

  @override
  BaseBloc createBloc() =>
      BarChartBloc(context.read<Api>())..add(BarChartEvent());
}
