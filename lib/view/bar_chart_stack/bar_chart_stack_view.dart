import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_chart_exam/data/post/api.dart';
import 'package:flutter_chart_exam/data/respose/covid/properti.dart';
import 'package:flutter_chart_exam/data/respose/data_model.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:flutter_chart_exam/data/respose/fetch_data.dart';
import 'package:flutter_chart_exam/view/bar_chart/bar_chart_bloc.dart';
import 'package:flutter_chart_exam/view/bar_chart/bar_chart_event.dart';
import 'package:flutter_chart_exam/view/bar_chart/bar_chart_state.dart';
import 'package:flutter_chart_exam/view/bar_chart_stack/bar_chart_stack_bloc.dart';
import 'package:flutter_chart_exam/view/bar_chart_stack/bar_chart_stack_event.dart';
import 'package:flutter_chart_exam/view/bar_chart_stack/bar_chart_stack_state.dart';
import 'package:flutter_chart_exam/view/widget/drawer_view.dart';
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
      providers: [BlocProvider(create: (context) => bloc as BarChartStackBloc)],
      child: BaseBlocBuilder<BarChartStackState>(
          bloc as BarChartStackBloc, _buildBody));

  Widget _buildBody(BuildContext context, BarChartStackState state) {
    List<FetchData> listaskVN = [];
    List<FetchData> listaskCam = [];
    state.covidModelVN?.All.dates?.forEach((key, value) {
      if (int.parse(key.substring(5, 7)) == 7 &&
          int.parse(key.substring(0, 4)) == 2021) {
        listaskVN.add(
            FetchData(key, value, charts.ColorUtil.fromDartColor(Colors.blue)));
      }
    });
    state.covidModelCam?.All.dates?.forEach((key, value) {
      if (int.parse(key.substring(5, 7)) == 7 &&
          int.parse(key.substring(0, 4)) == 2021) {
        listaskCam.add(FetchData(
            key, value, charts.ColorUtil.fromDartColor(Colors.blueGrey)));
      }
    });
    listaskVN = listaskVN.reversed.toList();
    listaskCam = listaskCam.reversed.toList();

    List<charts.Series<FetchData, String>> timeline = [
      charts.Series(
        id: 'Campuchia',
        data: listaskCam,
        domainFn: (FetchData timeline, _) => timeline.date,
        measureFn: (FetchData timeline, _) => timeline.value,
        colorFn: (FetchData timeline, _) => timeline.barColor,
        labelAccessorFn: (FetchData row, _) => '${row.value}',
      ),
      charts.Series(
        id: 'VN',
        data: listaskVN,
        domainFn: (FetchData timeline, _) => timeline.date,
        measureFn: (FetchData timeline, _) => timeline.value,
        colorFn: (FetchData timeline, _) => timeline.barColor,
        labelAccessorFn: (FetchData row, _) => '${row.value}',
      ),
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
                          'Death toll in COVID-19 between Vietnam and Cambodia in July',
                          style: TextStyle(color: Colors.red, fontSize: 18),
                        ),
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
                            decoration: BoxDecoration(color: Colors.blueGrey),
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
                          //     insideJustification: charts.InsideJustification.topEnd,
                          //     horizontalFirst: false,
                          //     desiredMaxRows: 4,
                          //     cellPadding: EdgeInsets.only(right: 4.0, bottom: 4.0),
                          //     entryTextStyle: charts.TextStyleSpec(
                          //       color: charts.MaterialPalette.purple.shadeDefault,
                          //     ),
                          //   ),
                          // ],
                          barGroupingType: charts.BarGroupingType.stacked,
                          domainAxis: charts.OrdinalAxisSpec(
                              renderSpec: charts.SmallTickRendererSpec(
                                  labelRotation: 80)),
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
