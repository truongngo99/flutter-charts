import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_chart_exam/data/post/api.dart';
import 'package:flutter_chart_exam/data/respose/detail_chart_model.dart';
import 'package:flutter_chart_exam/view/detail_chart/detail_chart_bloc.dart';
import 'package:flutter_chart_exam/view/detail_chart/detail_chart_event.dart';
import 'package:flutter_chart_exam/view/detail_chart/detail_chart_state.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:teq_flutter_core/teq_flutter_core.dart';

class DetailChartYearView extends StatefulWidget {
  final String code;
  final String status;
  DetailChartYearView({Key? key, required this.code, required this.status})
      : super(key: key);

  @override
  _DetailChartYearViewState createState() => _DetailChartYearViewState();
}

class _DetailChartYearViewState extends BaseBlocState<DetailChartYearView> {
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
      if (key == '2020-12-31') {
        listask.add(DetailChartModel('2020', value));
      }
    });

    if (state.covidModel?.All.dates?.keys != null) {
      var curKey = state.covidModel?.All.dates?.keys.elementAt(1);
      var max = DateTime.parse(curKey ?? '');
      var curValue = state.covidModel?.All.dates?.values.elementAt(1);
      state.covidModel?.All.dates?.forEach((key, value) {
        var temp = DateTime.parse(key);
        if (max.compareTo(temp) < 0) {
          max = temp;
          curValue = value;
        }
      });
      listask.add(DetailChartModel('2021', curValue));
    }

    return state.isLoading
        ? Center(
            child: CircularProgressIndicator(),
          )
        : Container(
            color: Colors.white,
            child: SfCartesianChart(
              primaryXAxis: CategoryAxis(),
              tooltipBehavior: TooltipBehavior(
                enable: true,
                activationMode: ActivationMode.singleTap,
                tooltipPosition: TooltipPosition.pointer,
              ),
              crosshairBehavior: CrosshairBehavior(
                  activationMode: ActivationMode.singleTap,
                  enable: true,
                  lineType: CrosshairLineType.horizontal),
              series: [
                ColumnSeries<DetailChartModel, int>(
                  dataSource: listask,
                  name: 'Covid-19',
                  xValueMapper: (DetailChartModel data, _) =>
                      int.parse(data.date),
                  yValueMapper: (DetailChartModel data, _) => data.value,
                  enableTooltip: true,
                  color: widget.status == 'confirmed'
                      ? Colors.green
                      : widget.status == 'recovered'
                          ? Colors.blue
                          : Colors.red,
                )
              ],
            ),
          );
  }
}
