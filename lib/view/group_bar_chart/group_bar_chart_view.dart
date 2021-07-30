import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_chart_exam/data/post/api.dart';
import 'package:flutter_chart_exam/data/respose/fetch_data.dart';
import 'package:flutter_chart_exam/view/bar_chart_stack/bar_chart_stack_bloc.dart';
import 'package:flutter_chart_exam/view/bar_chart_stack/bar_chart_stack_event.dart';
import 'package:flutter_chart_exam/view/bar_chart_stack/bar_chart_stack_state.dart';
import 'package:flutter_chart_exam/view/widget/drawer_view.dart';
import 'package:teq_flutter_core/teq_flutter_core.dart';
import 'package:charts_flutter/flutter.dart' as charts;

class GroupBarChartView extends StatefulWidget {
  final String title;
  GroupBarChartView({Key? key, required this.title}) : super(key: key);

  @override
  _GroupBarChartViewState createState() => _GroupBarChartViewState();
}

class _GroupBarChartViewState extends BaseBlocState<GroupBarChartView> {
  @override
  Widget build(BuildContext context) => MultiBlocProvider(
      providers: [BlocProvider(create: (context) => bloc as BarChartStackBloc)],
      child: BaseBlocBuilder<BarChartStackState>(
          bloc as BarChartStackBloc, _buildBody));

  Widget _buildBody(BuildContext context, BarChartStackState state) {
    List<FetchData> listaskVN = [];
    List<FetchData> listaskLao = [];
    state.covidModelVN?.All.dates?.forEach((key, value) {
      if (int.parse(key.substring(5, 7)) == 7 &&
          int.parse(key.substring(0, 4)) == 2021 &&
          int.parse(key.substring(8, 10)) > 15) {
        listaskVN.add(
            FetchData(key, value, charts.ColorUtil.fromDartColor(Colors.blue)));
      }
    });
    state.covidModelCam?.All.dates?.forEach((key, value) {
      if (int.parse(key.substring(5, 7)) == 7 &&
          int.parse(key.substring(0, 4)) == 2021 &&
          int.parse(key.substring(8, 10)) > 15) {
        listaskLao.add(FetchData(
            key, value, charts.ColorUtil.fromDartColor(Colors.green)));
      }
    });
    listaskVN = listaskVN.reversed.toList();
    listaskLao = listaskLao.reversed.toList();

    List<charts.Series<FetchData, String>> timeline = [
      charts.Series(
        id: 'VN',
        data: listaskVN,
        domainFn: (FetchData timeline, _) => timeline.date.substring(8, 10),
        measureFn: (FetchData timeline, _) => timeline.value,
        colorFn: (FetchData timeline, _) => timeline.barColor,
        labelAccessorFn: (FetchData row, _) => '${row.value}',
      ),
      charts.Series(
        id: 'Lao',
        data: listaskLao,
        domainFn: (FetchData timeline, _) => timeline.date.substring(8, 10),
        measureFn: (FetchData timeline, _) => timeline.value,
        colorFn: (FetchData timeline, _) => timeline.barColor,
        labelAccessorFn: (FetchData row, _) => '${row.value}',
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
                padding: EdgeInsets.all(30),
                child: Card(
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                            'Death toll in COVID-19 between Vietnam and Cambodia in July',
                            style: TextStyle(color: Colors.red, fontSize: 18)),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Container(
                            height: 10,
                            width: 10,
                            decoration: BoxDecoration(color: Colors.blue),
                          ),
                          Text(' Việt Nam'),
                          SizedBox(
                            width: 20,
                          ),
                          Container(
                            height: 10,
                            width: 10,
                            decoration: BoxDecoration(color: Colors.green),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(right: 8.0),
                            child: Text(' Campuchia'),
                          ),
                        ],
                      ),
                      Expanded(
                        child: charts.BarChart(
                          timeline,
                          animate: true,
                          //vertical: false,
                          // behaviors: [
                          //   charts.DatumLegend(
                          //     outsideJustification: charts.OutsideJustification.endDrawArea,
                          //     horizontalFirst: false,
                          //     desiredMaxRows: 2,
                          //     cellPadding: EdgeInsets.only(right: 4.0, bottom: 4.0),
                          //     entryTextStyle: charts.TextStyleSpec(
                          //       color: charts.MaterialPalette.purple.shadeDefault,
                          //     ),
                          //   ),
                          // ],
                          barGroupingType: charts.BarGroupingType.grouped,
                          // domainAxis: charts.OrdinalAxisSpec(
                          //     renderSpec: charts.SmallTickRendererSpec(
                          //         labelRotation: 80)),
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
      BarChartStackBloc(context.read<Api>())..add(BarChartStackEvent());
}
