import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_chart_exam/data/post/api.dart';

import 'package:charts_flutter/flutter.dart' as charts;
import 'package:flutter_chart_exam/data/respose/fetch_data.dart';
import 'package:flutter_chart_exam/view/bar_chart/bar_chart_bloc.dart';
import 'package:flutter_chart_exam/view/bar_chart/bar_chart_event.dart';
import 'package:flutter_chart_exam/view/bar_chart/bar_chart_state.dart';
import 'package:flutter_chart_exam/view/widget/drawer_view.dart';
import 'package:teq_flutter_core/teq_flutter_core.dart';

class TimeLineChartBasic extends StatefulWidget {
  final String title;
  TimeLineChartBasic({Key? key, required this.title}) : super(key: key);

  @override
  _TimeLineChartBasicState createState() => _TimeLineChartBasicState();
}

class _TimeLineChartBasicState extends BaseBlocState<TimeLineChartBasic> {
  @override
  Widget build(BuildContext context) => MultiBlocProvider(
      providers: [BlocProvider(create: (context) => bloc as BarChartBloc)],
      child: BaseBlocBuilder<BarChartState>(bloc as BarChartBloc, _buildBody));

  Widget _buildBody(BuildContext context, BarChartState state) {
    List<FetchData> listask = [];
    state.covidModel?.All.dates?.forEach((key, value) {
      // if (int.parse(key.substring(0, 4)) == 2021) {
      listask.add(
          FetchData(key, value, charts.ColorUtil.fromDartColor(Colors.blue)));
      // }
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
      drawer: DrawerView(),
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
                          'The number of deaths from COVID-19 in Vietnam from 2020',
                          style: TextStyle(color: Colors.red, fontSize: 18),
                        ),
                      ),
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
      ),
    );
  }

  @override
  BaseBloc createBloc() =>
      BarChartBloc(context.read<Api>())..add(BarChartEvent());
}
