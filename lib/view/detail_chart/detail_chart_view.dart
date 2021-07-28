import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_chart_exam/data/post/api.dart';
import 'package:flutter_chart_exam/data/respose/detail_chart_model.dart';
import 'package:flutter_chart_exam/data/respose/fetch_data.dart';
import 'package:flutter_chart_exam/view/detail_chart/detail_chart_bloc.dart';
import 'package:flutter_chart_exam/view/detail_chart/detail_chart_event.dart';
import 'package:flutter_chart_exam/view/detail_chart/detail_chart_state.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:teq_flutter_core/teq_flutter_core.dart';

class DetailChartView extends StatefulWidget {
  final String code;
  final String status;
  DetailChartView({Key? key, required this.code, required this.status})
      : super(key: key);

  @override
  _DetailChartViewState createState() => _DetailChartViewState();
}

class _DetailChartViewState extends BaseBlocState<DetailChartView> {
  @override
  Widget build(BuildContext context) => MultiBlocProvider(
          providers: [
            BlocProvider(create: (context) => bloc as DetailChartBloc),
          ],
          child: BaseBlocBuilder<DetailChartState>(
              bloc as DetailChartBloc, _buildBody));

  @override
  BaseBloc createBloc() => DetailChartBloc(context.read<Api>())
    ..add(DetailChartEvent(widget.code, widget.status));

  Widget _buildBody(BuildContext context, DetailChartState state) {
    List<DetailChartModel> listask = [];
    state.covidModel?.All.dates?.forEach((key, value) {
      if (int.parse(key.substring(0, 4)) == 2021) {
        listask.add(DetailChartModel(
          key,
          value,
        ));
      }
    });
    listask = listask.reversed.toList();
    return Scaffold(
      backgroundColor: Color(0xFF473F97),
      appBar: AppBar(),
      body: state.isLoading
          ? CircularProgressIndicator()
          : Column(
              children: [
                SfCartesianChart(
                  primaryXAxis: DateTimeAxis(),
                  tooltipBehavior: TooltipBehavior(
                    enable: true,
                    // activationMode: ActivationMode.singleTap,
                    //tooltipPosition: TooltipPosition.pointer,
                  ),
                  series: [
                    LineSeries<DetailChartModel, DateTime>(
                      dataSource: listask,
                      xValueMapper: (DetailChartModel data, _) =>
                          DateTime.parse(data.date.replaceAll('-', '')),
                      yValueMapper: (DetailChartModel data, _) => data.value,
                      enableTooltip: true,
                    )
                  ],
                ),
              ],
            ),
    );
  }

  _buildStatTabBar() {
    return DefaultTabController(
        length: 2,
        child: TabBar(
          indicatorColor: Colors.transparent,
          labelColor: Colors.white,
          unselectedLabelColor: Colors.white60,
          tabs: [
            Text('Month'),
            Text('Month'),
          ],
        ));
  }
}
