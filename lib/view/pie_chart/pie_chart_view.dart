import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_chart_exam/data/post/api.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:flutter_chart_exam/data/respose/timeline.dart';
import 'package:flutter_chart_exam/view/bar_chart/bar_chart_bloc.dart';
import 'package:flutter_chart_exam/view/bar_chart/bar_chart_event.dart';
import 'package:flutter_chart_exam/view/bar_chart/bar_chart_state.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:teq_flutter_core/teq_flutter_core.dart';

class PieChartBasic extends StatefulWidget {
  final String title;
  PieChartBasic({Key? key, required this.title}) : super(key: key);

  @override
  _PieChartBasicState createState() => _PieChartBasicState();
}

class _PieChartBasicState extends BaseBlocState<PieChartBasic> {
  late TooltipBehavior _tooltipBehavior;
  @override
  void initState() {
    _tooltipBehavior = TooltipBehavior(enable: true);
    super.initState();
  }

  @override
  Widget build(BuildContext context) => MultiBlocProvider(
      providers: [BlocProvider(create: (context) => bloc as BarChartBloc)],
      child: BaseBlocBuilder<BarChartState>(bloc as BarChartBloc, _buildBody));

  Widget _buildBody(BuildContext context, BarChartState state) {
    List<FetchData> listask = [];
    List<FetchData> listask2 = [];
    state.covidModel?.All.dates.forEach((key, value) {
      if (value > 100) {
        listask.add(
            FetchData(key, value, charts.ColorUtil.fromDartColor(Colors.blue)));
      }
    });
    listask = listask.reversed.toList();
    state.covidModel?.All.dates.forEach((key, value) {
      if (value > 200) {
        listask2.add(
            FetchData(key, value, charts.ColorUtil.fromDartColor(Colors.blue)));
      }
    });
    listask2 = listask2.reversed.toList();
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
          bottom: TabBar(
            tabs: [
              Tab(
                icon: Icon(FontAwesomeIcons.chartPie),
              ),
              Tab(
                icon: Icon(FontAwesomeIcons.chartPie),
              ),
              Tab(
                icon: Icon(FontAwesomeIcons.chartPie),
              ),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            state.isLoading
                ? Center(child: CircularProgressIndicator())
                : Container(
                    padding: EdgeInsets.all(15),
                    child: Column(
                      children: [
                        Text(
                          'Những tháng có số người chết > 100 vì COVID-19 ở VN',
                          style: TextStyle(color: Colors.red, fontSize: 20),
                        ),
                        Expanded(
                          child: SfCircularChart(
                            tooltipBehavior: _tooltipBehavior,
                            legend: Legend(
                                isVisible: true,
                                overflowMode: LegendItemOverflowMode.wrap),
                            series: <CircularSeries>[
                              PieSeries<FetchData, String>(
                                dataSource: listask,
                                xValueMapper: (FetchData data, _) => data.date,
                                yValueMapper: (FetchData data, _) => data.value,
                                //dataLabelSettings: DataLabelSettings(isVisible: true),
                                enableTooltip: true,
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
            state.isLoading
                ? Center(child: CircularProgressIndicator())
                : Container(
                    padding: EdgeInsets.all(15),
                    child: Column(
                      children: [
                        Text(
                          'Những tháng có số người chết > 100 vì COVID-19 ở VN',
                          style: TextStyle(color: Colors.red, fontSize: 20),
                        ),
                        Expanded(
                          child: SfCircularChart(
                            legend: Legend(
                                isVisible: true,
                                overflowMode: LegendItemOverflowMode.wrap),
                            series: <CircularSeries>[
                              DoughnutSeries<FetchData, String>(
                                dataSource: listask,
                                xValueMapper: (FetchData data, _) => data.date,
                                yValueMapper: (FetchData data, _) => data.value,
                                dataLabelSettings:
                                    DataLabelSettings(isVisible: true),
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
            state.isLoading
                ? Center(child: CircularProgressIndicator())
                : Container(
                    padding: EdgeInsets.all(15),
                    child: Column(
                      children: [
                        Text(
                          'Những tháng có số người chết > 200 vì COVID-19 ở VN',
                          style: TextStyle(color: Colors.red, fontSize: 20),
                        ),
                        Expanded(
                          child: SfCircularChart(
                            legend: Legend(
                                isVisible: true,
                                overflowMode: LegendItemOverflowMode.wrap),
                            series: <CircularSeries>[
                              RadialBarSeries<FetchData, String>(
                                dataSource: listask2,
                                xValueMapper: (FetchData data, _) => data.date,
                                yValueMapper: (FetchData data, _) => data.value,
                                maximumValue: 350,
                                dataLabelSettings:
                                    DataLabelSettings(isVisible: true),
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
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
