import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_chart_exam/data/post/api.dart';
import 'package:flutter_chart_exam/data/respose/covid/properti.dart';
import 'package:flutter_chart_exam/data/respose/ordinal_sales.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:flutter_chart_exam/data/respose/timeline.dart';
import 'package:flutter_chart_exam/view/bar_chart/bar_chart_bloc.dart';
import 'package:flutter_chart_exam/view/bar_chart/bar_chart_event.dart';
import 'package:flutter_chart_exam/view/bar_chart/bar_chart_state.dart';
import 'package:teq_flutter_core/teq_flutter_core.dart';

class LineChartBasic extends StatefulWidget {
  final String title;
  LineChartBasic({Key? key, required this.title}) : super(key: key);

  @override
  _LineChartBasicState createState() => _LineChartBasicState();
}

class _LineChartBasicState extends BaseBlocState<LineChartBasic> {
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

    List<charts.Series<FetchData, DateTime>> timeline = [
      charts.Series(
        id: 'Subscribes',
        data: listask,
        domainFn: (FetchData timeline, _) =>
            DateTime.parse(timeline.date.replaceAll('-', '')),
        measureFn: (FetchData timeline, _) => timeline.value,
        // colorFn: (Task timeline, _) =>
        //     charts.ColorUtil.fromDartColor(timeline.colorValue),
        //labelAccessorFn: (Properties row, _) => '${row.death}',
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
                      child: charts.TimeSeriesChart(
                        timeline,
                        animate: true,

                        //animationDuration: Duration(seconds: 2),
                        behaviors: [
                          // charts.DatumLegend(
                          //   outsideJustification:
                          //       charts.OutsideJustification.endDrawArea,
                          //   horizontalFirst: false,
                          //   desiredMaxRows: 2,
                          //   cellPadding:
                          //       EdgeInsets.only(right: 4.0, bottom: 4.0),
                          //   entryTextStyle: charts.TextStyleSpec(
                          //     color: charts.MaterialPalette.purple.shadeDefault,
                          //   ),
                          // ),
                          new charts.ChartTitle('Mã Code',
                              behaviorPosition: charts.BehaviorPosition.bottom,
                              titleOutsideJustification:
                                  charts.OutsideJustification.middleDrawArea),
                          new charts.ChartTitle('Số người chết',
                              behaviorPosition: charts.BehaviorPosition.start,
                              titleOutsideJustification:
                                  charts.OutsideJustification.middleDrawArea),
                        ],
                        // barRendererDecorator: charts.BarLabelDecorator(
                        //     outsideLabelStyleSpec: charts.TextStyleSpec()),
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
