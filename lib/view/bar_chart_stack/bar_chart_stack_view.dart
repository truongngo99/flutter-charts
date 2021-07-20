import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_chart_exam/data/post/api.dart';
import 'package:flutter_chart_exam/data/respose/covid/properti.dart';
import 'package:flutter_chart_exam/data/respose/ordinal_sales.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:flutter_chart_exam/view/bar_chart/bar_chart_bloc.dart';
import 'package:flutter_chart_exam/view/bar_chart/bar_chart_event.dart';
import 'package:flutter_chart_exam/view/bar_chart/bar_chart_state.dart';
import 'package:teq_flutter_core/teq_flutter_core.dart';

class BarChartStackView extends StatefulWidget {
  final String title;
  BarChartStackView({Key? key, required this.title}) : super(key: key);

  @override
  _BarChartStackViewState createState() => _BarChartStackViewState();
}

class _BarChartStackViewState extends BaseBlocState<BarChartStackView> {
  @override
  Widget build(BuildContext context) => MultiBlocProvider(
      providers: [BlocProvider(create: (context) => bloc as BarChartBloc)],
      child: BaseBlocBuilder<BarChartState>(bloc as BarChartBloc, _buildBody));

  Widget _buildBody(BuildContext context, BarChartState state) {
    // final List<Properties> listask = [];
    // final List<Properties> listask1 = [];
    // final List<Properties> listask2 = [];
    // //state.covidModel?.features.forEach((element) {
    //   if (element.properties.active > 0) {
    //     listask.add(element.properties);
    //     listask1.add(element.properties);
    //     listask2.add(element.properties);
    //   }
    // });
    // print(listask.length);

    // List<charts.Series<Properties, String>> timeline = [
    //   charts.Series(
    //     id: 'listask',
    //     data: listask,
    //     domainFn: (Properties timeline, _) => timeline.Name_VN,
    //     measureFn: (Properties timeline, _) => timeline.active,
    //     // colorFn: (Task timeline, _) =>
    //     //     charts.ColorUtil.fromDartColor(timeline.colorValue),
    //     labelAccessorFn: (Properties row, _) => '${row.death}',
    //   ),
    //   charts.Series(
    //     id: 'listask1',
    //     data: listask1,
    //     domainFn: (Properties timeline, _) => timeline.Name_VN,
    //     measureFn: (Properties timeline, _) => timeline.death,
    //     // colorFn: (Task timeline, _) =>
    //     //     charts.ColorUtil.fromDartColor(timeline.colorValue),
    //     labelAccessorFn: (Properties row, _) => '${row.death}',
    //   ),
    //   charts.Series(
    //     id: 'listask2',
    //     data: listask2,
    //     domainFn: (Properties timeline, _) => timeline.Name_VN,
    //     measureFn: (Properties timeline, _) => timeline.infected,
    //     // colorFn: (Task timeline, _) =>
    //     //     charts.ColorUtil.fromDartColor(timeline.colorValue),
    //     labelAccessorFn: (Properties row, _) => '${row.death}',
    //   )
    // ];

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Container(
          // child: charts.BarChart(
          //   timeline,
          //   animate: true,
          //   vertical: false,
          //   barGroupingType: charts.BarGroupingType.stacked,
          // ),
          ),
    );
  }

  @override
  BaseBloc createBloc() =>
      BarChartBloc(context.read<Api>())..add(BarChartEvent());
}
