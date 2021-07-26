import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_chart_exam/data/post/api.dart';
import 'package:flutter_chart_exam/data/respose/fetch_data.dart';
import 'package:flutter_chart_exam/view/bar_chart/bar_chart_bloc.dart';
import 'package:flutter_chart_exam/view/bar_chart/bar_chart_event.dart';
import 'package:flutter_chart_exam/view/bar_chart/bar_chart_state.dart';
import 'package:flutter_chart_exam/view/widget/drawer_view.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:teq_flutter_core/teq_flutter_core.dart';
import 'package:charts_flutter/flutter.dart' as charts;

class HistogramChartView extends StatefulWidget {
  final String title;
  HistogramChartView({Key? key, required this.title}) : super(key: key);

  @override
  _HistogramChartViewState createState() => _HistogramChartViewState();
}

class _HistogramChartViewState extends BaseBlocState<HistogramChartView> {
  @override
  Widget build(BuildContext context) => MultiBlocProvider(
      providers: [BlocProvider(create: (context) => bloc as BarChartBloc)],
      child: BaseBlocBuilder<BarChartState>(bloc as BarChartBloc, _buildBody));

  Widget _buildBody(BuildContext context, BarChartState state) {
    List<FetchData> chartData = [];

    state.covidModel?.All.dates?.forEach((key, value) {
      // if (value > 100) {
      chartData.add(
          FetchData(key, value, charts.ColorUtil.fromDartColor(Colors.blue)));
      // }
    });
    //chartData = chartData.reversed.toList();
    return Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
        ),
        drawer: DrawerView(),
        body: Center(
            child: state.isLoading
                ? CircularProgressIndicator()
                : Container(
                    child: SfCartesianChart(series: <ChartSeries>[
                    HistogramSeries<FetchData, num>(
                        dataSource: chartData,
                        yValueMapper: (FetchData sales, _) => sales.value,
                        //binInterval: 30,
                        showNormalDistributionCurve: true,
                        curveColor: const Color.fromRGBO(192, 108, 132, 1),
                        borderWidth: 3),
                  ]))));
  }

  @override
  BaseBloc createBloc() =>
      BarChartBloc(context.read<Api>())..add(BarChartEvent());
}
