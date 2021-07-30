import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_chart_exam/data/post/api.dart';
import 'package:flutter_chart_exam/data/respose/detail_chart_model.dart';
import 'package:flutter_chart_exam/view/detail_chart/detail_chart_bloc.dart';
import 'package:flutter_chart_exam/view/detail_chart/detail_chart_event.dart';
import 'package:flutter_chart_exam/view/detail_chart/detail_chart_state.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:teq_flutter_core/teq_flutter_core.dart';

class DetailChartMonthView extends StatefulWidget {
  final String code;
  final String status;
  DetailChartMonthView({Key? key, required this.code, required this.status})
      : super(key: key);

  @override
  _DetailChartMonthViewState createState() => _DetailChartMonthViewState();
}

class _DetailChartMonthViewState extends BaseBlocState<DetailChartMonthView> {
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
    List<DetailChartModel> listaskmonth = [];

    state.covidModel?.All.dates?.forEach((key, value) {
      if (key == '2020-01-31') {
        listask.add(DetailChartModel('1', value));
      }
      if (key == '2020-02-29') {
        listask.add(DetailChartModel('2', value));
      }
      if (key == '2020-03-31') {
        listask.add(DetailChartModel('3', value));
      }
      if (key == '2020-04-30') {
        listask.add(DetailChartModel('4', value));
      }
      if (key == '2020-05-31') {
        listask.add(DetailChartModel('5', value));
      }
      if (key == '2020-06-30') {
        listask.add(DetailChartModel('6', value));
      }
      if (key == '2020-07-31') {
        listask.add(DetailChartModel('7', value));
      }
      if (key == '2020-08-31') {
        listask.add(DetailChartModel('8', value));
      }
      if (key == '2020-09-30') {
        listask.add(DetailChartModel('9', value));
      }
      if (key == '2020-10-31') {
        listask.add(DetailChartModel('10', value));
      }
      if (key == '2020-11-30') {
        listask.add(DetailChartModel('11', value));
      }
      if (key == '2020-12-31') {
        listask.add(DetailChartModel('12', value));
      }
    });
    state.covidModel?.All.dates?.forEach((key, value) {
      if (key == '2021-01-31') {
        listaskmonth.add(DetailChartModel('1', value));
      }
      if (key == '2021-02-28') {
        listaskmonth.add(DetailChartModel('2', value));
      }
      if (key == '2021-03-31') {
        listaskmonth.add(DetailChartModel('3', value));
      }
      if (key == '2021-04-30') {
        listaskmonth.add(DetailChartModel('4', value));
      }
      if (key == '2021-05-31') {
        listaskmonth.add(DetailChartModel('5', value));
      }
      if (key == '2021-06-30') {
        listaskmonth.add(DetailChartModel('6', value));
      }
      if (key == '2021-07-27') {
        listaskmonth.add(DetailChartModel('7', value));
      }
    });
    listaskmonth = listaskmonth.reversed.toList();
    listask = listask.reversed.toList();
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          bottom: TabBar(
            indicatorColor: Colors.black,
            indicatorWeight: 4,
            unselectedLabelColor: Colors.grey,
            tabs: [
              Tab(
                child: Container(
                  child: Text(
                    '2020',
                    style: TextStyle(color: Colors.black, fontSize: 18.0),
                  ),
                ),
              ),
              Tab(
                child: Container(
                  child: Text(
                    '2021',
                    style: TextStyle(color: Colors.black, fontSize: 18.0),
                  ),
                ),
              ),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            state.isLoading
                ? Center(
                    child: CircularProgressIndicator(),
                  )
                : Container(
                    child: Column(
                      children: [
                        Expanded(
                          child: Container(
                            height: double.infinity,
                            width: double.infinity,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(20.0),
                                topRight: Radius.circular(20.0),
                              ),
                            ),
                            child: SfCartesianChart(
                              primaryXAxis: CategoryAxis(),
                              tooltipBehavior: TooltipBehavior(
                                enable: true,
                                // activationMode: ActivationMode.singleTap,
                                //tooltipPosition: TooltipPosition.pointer,
                              ),
                              crosshairBehavior: CrosshairBehavior(
                                  activationMode: ActivationMode.singleTap,
                                  enable: true,
                                  lineType: CrosshairLineType.horizontal),
                              series: [
                                ColumnSeries<DetailChartModel, String>(
                                  dataSource: listask,
                                  name: 'Covid-19',
                                  xValueMapper: (DetailChartModel data, _) =>
                                      data.date,
                                  yValueMapper: (DetailChartModel data, _) =>
                                      data.value,
                                  enableTooltip: true,
                                  color: widget.status == 'confirmed'
                                      ? Colors.green
                                      : widget.status == 'recovered'
                                          ? Colors.blue
                                          : Colors.red,
                                )
                              ],
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
            state.isLoading
                ? Center(
                    child: CircularProgressIndicator(),
                  )
                : Container(
                    child: Column(
                      children: [
                        Expanded(
                          child: Container(
                            height: double.infinity,
                            width: double.infinity,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(20.0),
                                topRight: Radius.circular(20.0),
                              ),
                            ),
                            child: SfCartesianChart(
                              primaryXAxis: CategoryAxis(),
                              tooltipBehavior: TooltipBehavior(
                                enable: true,
                                // activationMode: ActivationMode.singleTap,
                                //tooltipPosition: TooltipPosition.pointer,
                              ),
                              crosshairBehavior: CrosshairBehavior(
                                  activationMode: ActivationMode.singleTap,
                                  enable: true,
                                  lineType: CrosshairLineType.horizontal),
                              series: [
                                ColumnSeries<DetailChartModel, String>(
                                  dataSource: listaskmonth,
                                  name: 'Covid-19',
                                  xValueMapper: (DetailChartModel data, _) =>
                                      data.date,
                                  yValueMapper: (DetailChartModel data, _) =>
                                      data.value,
                                  enableTooltip: true,
                                  color: widget.status == 'confirmed'
                                      ? Colors.green
                                      : widget.status == 'recovered'
                                          ? Colors.blue
                                          : Colors.red,
                                )
                              ],
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
          ],
        ),
      ),
    );
  }
}
