import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_chart_exam/data/post/api.dart';
import 'package:flutter_chart_exam/data/respose/covid/features.dart';
import 'package:flutter_chart_exam/data/respose/ordinal_sales.dart';

import 'package:flutter_chart_exam/view/page_view/page_view_bloc.dart';
import 'package:flutter_chart_exam/view/page_view/page_view_event.dart';
import 'package:flutter_chart_exam/view/page_view/page_view_state.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:teq_flutter_core/teq_flutter_core.dart';
import 'package:charts_flutter/flutter.dart' as charts;

class PageViewScreen extends StatefulWidget {
  PageViewScreen({Key? key}) : super(key: key);

  @override
  _PageViewScreenState createState() => _PageViewScreenState();
}

class _PageViewScreenState extends BaseBlocState<PageViewScreen> {
  @override
  Widget build(BuildContext context) => MultiBlocProvider(
          providers: [
            BlocProvider(create: (context) => bloc as PageViewBloc),
          ],
          child:
              BaseBlocBuilder<PageViewState>(bloc as PageViewBloc, _buildBody));

  Widget _buildBody(BuildContext context, PageViewState state) {
    TextEditingController _search = TextEditingController();

    List<DataModel> listData = [];

    if (state.covidModel != null) {
      var fetchData = state.covidModel?.All;
      listData.add(DataModel('Confirme', fetchData!.confirmed,
          charts.ColorUtil.fromDartColor(Colors.green)));
      listData.add(DataModel('Recorver', fetchData.recovered,
          charts.ColorUtil.fromDartColor(Colors.blue)));
      listData.add(DataModel('Deaths', fetchData.deaths,
          charts.ColorUtil.fromDartColor(Colors.red)));
    }

    List<charts.Series<DataModel, String>> timeline = [
      charts.Series(
        id: 'Subscribes',
        data: listData,
        domainFn: (DataModel timeline, _) => timeline.catergory,
        measureFn: (DataModel timeline, _) => timeline.value,
        colorFn: (DataModel timeline, __) => timeline.barColor,
      )
    ];
    return Scaffold(
        appBar: AppBar(
          title: Text('COVID-19 '),
          centerTitle: true,
        ),
        body: SingleChildScrollView(
            child: state.isLoading
                ? Center(
                    child: CircularProgressIndicator(),
                  )
                : Container(
                    padding: EdgeInsets.all(20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        TextField(
                          controller: _search,
                          decoration: InputDecoration(
                              border: InputBorder.none,
                              hintText: 'Search Country',
                              enabledBorder: OutlineInputBorder(
                                borderSide:
                                    BorderSide(width: 1, color: Colors.blue),
                                borderRadius: BorderRadius.circular(15),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide:
                                    BorderSide(width: 1, color: Colors.red),
                                borderRadius: BorderRadius.circular(15),
                              ),
                              suffixIcon: IconButton(
                                icon: Icon(
                                  Icons.search,
                                ),
                                onPressed: () {
                                  addEvent(PageViewEvent(_search.text));
                                },
                              )),
                        ),
                        Container(
                          height: 80,
                          child: Card(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(left: 8.0),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      Text(
                                        'CONFIRMED',
                                        style: TextStyle(
                                            color: Colors.grey, fontSize: 18),
                                      ),
                                      Text(
                                        'Total',
                                        style: TextStyle(
                                            color: Colors.green, fontSize: 14),
                                      ),
                                      Text(
                                        '${state.covidModel?.All.confirmed ?? 0}',
                                        style: TextStyle(
                                            color: Colors.green,
                                            fontSize: 25,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(right: 8),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      Text(
                                        'RECOVERED',
                                        style: TextStyle(
                                            color: Colors.grey, fontSize: 18),
                                      ),
                                      Text(
                                        'Total',
                                        style: TextStyle(
                                            color: Colors.blue, fontSize: 14),
                                      ),
                                      Text(
                                        '${state.covidModel?.All.recovered ?? 0}',
                                        style: TextStyle(
                                            color: Colors.blue,
                                            fontSize: 25,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Container(
                          height: 50,
                          child: Card(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Text(
                                  'DEATHS',
                                  style: TextStyle(
                                      color: Colors.grey, fontSize: 18),
                                ),
                                Text(
                                  'Total',
                                  style: TextStyle(
                                      color: Colors.red, fontSize: 14),
                                ),
                                Text(
                                  '${state.covidModel?.All.deaths ?? 0}',
                                  style: TextStyle(
                                      color: Colors.red,
                                      fontSize: 25,
                                      fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Container(
                          height: 300,
                          child: Card(
                            child: Column(
                              children: [
                                Expanded(
                                  child: charts.BarChart(
                                    timeline,
                                    animate: true,
                                  ),
                                ),
                                Text(
                                  '${state.covidModel?.All.country}',
                                  style: TextStyle(
                                      fontSize: 30,
                                      color: Colors.redAccent,
                                      fontWeight: FontWeight.bold),
                                )
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  )));
  }

  @override
  BaseBloc createBloc() =>
      PageViewBloc(context.read<Api>())..add(PageViewEvent('Vietnam'));
}
