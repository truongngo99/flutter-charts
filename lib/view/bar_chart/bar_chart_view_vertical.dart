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

class BarChartVerticalView extends StatefulWidget {
  final String title;
  BarChartVerticalView({Key? key, required this.title}) : super(key: key);

  @override
  _BarChartVerticalViewState createState() => _BarChartVerticalViewState();
}

class _BarChartVerticalViewState extends BaseBlocState<BarChartVerticalView> {
  @override
  Widget build(BuildContext context) => MultiBlocProvider(
      providers: [BlocProvider(create: (context) => bloc as BarChartBloc)],
      child: BaseBlocBuilder<BarChartState>(bloc as BarChartBloc, _buildBody));

  Widget _buildBody(BuildContext context, BarChartState state) {
    List<FetchData> listask = [];
    state.covidModel?.All.dates?.forEach((key, value) {
      if (int.parse(key.substring(5, 7)) == 7 &&
          int.parse(key.substring(0, 4)) == 2021) {
        listask.add(
            FetchData(key, value, charts.ColorUtil.fromDartColor(Colors.blue)));
      }
    });
    listask = listask.reversed.toList();
    List<charts.Series<FetchData, String>> timeline = [
      charts.Series(
        id: 'Subscribes',
        data: listask,
        domainFn: (FetchData timeline, _) => timeline.date,
        measureFn: (FetchData timeline, _) => timeline.value,
        // colorFn: (Task timeline, _) =>
        //     charts.ColorUtil.fromDartColor(timeline.colorValue),
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
                height: double.infinity,
                padding: EdgeInsets.all(10),
                child: Card(
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          'The number of deaths from COVID-19 in Vietnam in July',
                          style: TextStyle(color: Colors.red, fontSize: 18),
                        ),
                      ),
                      Expanded(
                        child: charts.BarChart(
                          timeline,
                          animate: true,
                          vertical: false,
                          // barRendererDecorator: charts.BarLabelDecorator(
                          //     labelPadding: 30,
                          //     labelPosition: charts.BarLabelPosition.inside,
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
