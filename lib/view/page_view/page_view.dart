import 'dart:ui';

import 'package:bubble_tab_indicator/bubble_tab_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_chart_exam/data/post/api.dart';
import 'package:flutter_chart_exam/data/respose/covid/features.dart';
import 'package:flutter_chart_exam/data/respose/ordinal_sales.dart';
import 'package:flutter_chart_exam/data/respose/timeline.dart';
import 'package:flutter_chart_exam/view/bar_chart/bar_chart_event.dart';

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
    int totalCase = 0;
    if (state.covidModel != null) {
      var fetchData = state.covidModel?.All;
      var death = fetchData?.deaths ?? 0;
      var confir = fetchData?.confirmed ?? 0;
      var recor = fetchData?.recovered ?? 0;
      totalCase = death + confir + recor;
      listData.add(DataModel('Confirme', fetchData!.confirmed,
          charts.ColorUtil.fromDartColor(Colors.green)));
      listData.add(DataModel('Recorver', fetchData.recovered,
          charts.ColorUtil.fromDartColor(Colors.lightBlue)));
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
      backgroundColor: Color(0xFF473F97),
      appBar: AppBar(
        backgroundColor: Color(0xFF473F97),
        title: Text('COVID-19 '),
        centerTitle: true,
      ),
      body: state.isLoading
          ? Center(child: CircularProgressIndicator())
          : CustomScrollView(
              physics: ClampingScrollPhysics(),
              slivers: [
                _buildHeader(),
                _buildRegionTabBar(),
                SliverPadding(
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  sliver: SliverToBoxAdapter(
                    child: TextField(
                      controller: _search,
                      style: TextStyle(color: Colors.white),
                      decoration: InputDecoration(
                          hintText: 'Search',
                          hoverColor: Colors.white,
                          hintStyle: TextStyle(color: Colors.white),
                          suffixIcon: IconButton(
                            icon: Icon(
                              Icons.search,
                              color: Colors.white,
                            ),
                            onPressed: () {
                              addEvent(PageViewEvent(_search.text));
                            },
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20),
                          )),
                    ),
                  ),
                ),
                SliverPadding(
                  padding: const EdgeInsets.symmetric(horizontal: 10.0),
                  sliver: SliverToBoxAdapter(
                    child: Container(
                      height: MediaQuery.of(context).size.height * 0.25,
                      child: Column(
                        children: <Widget>[
                          Flexible(
                            child: Row(
                              children: <Widget>[
                                _buildStatCard('Total Cases',
                                    totalCase.toString(), Colors.orange),
                                _buildStatCard(
                                    'Deaths',
                                    '${state.covidModel?.All.deaths}',
                                    Colors.red),
                              ],
                            ),
                          ),
                          Flexible(
                            child: Row(
                              children: <Widget>[
                                _buildStatCard(
                                    'Recovered',
                                    '${state.covidModel?.All.confirmed}',
                                    Colors.green),
                                _buildStatCard(
                                    'Active',
                                    '${state.covidModel?.All.recovered}',
                                    Colors.lightBlue),
                                _buildStatCard(
                                    'Critical', 'N/A', Colors.purple),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                SliverPadding(
                  padding: const EdgeInsets.only(top: 20.0),
                  sliver: SliverToBoxAdapter(
                    child: Container(
                      height: 350.0,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(20.0),
                          topRight: Radius.circular(20.0),
                        ),
                      ),
                      child: Column(
                        children: <Widget>[
                          Container(
                            padding: const EdgeInsets.all(20.0),
                            alignment: Alignment.centerLeft,
                            child: Text(
                              '${state.covidModel?.All.country}',
                              style: const TextStyle(
                                fontSize: 22.0,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          Expanded(
                            child: Container(
                              width: MediaQuery.of(context).size.width * 0.85,
                              child: charts.BarChart(
                                timeline,
                                animate: true,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
    );
  }

  SliverPadding _buildHeader() {
    return SliverPadding(
      padding: EdgeInsets.all(20),
      sliver: SliverToBoxAdapter(
        child: Text(
          'Statistics',
          style: TextStyle(
            color: Colors.white,
            fontSize: 25,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }

  SliverToBoxAdapter _buildRegionTabBar() {
    return SliverToBoxAdapter(
      child: DefaultTabController(
        length: 2,
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 20.0),
          height: 50.0,
          decoration: BoxDecoration(
            color: Colors.white24,
            borderRadius: BorderRadius.circular(25.0),
          ),
          child: TabBar(
            indicator: BubbleTabIndicator(
              tabBarIndicatorSize: TabBarIndicatorSize.tab,
              indicatorHeight: 40.0,
              indicatorColor: Colors.white,
            ),
            labelStyle: TextStyle(
              fontSize: 16.0,
              fontWeight: FontWeight.w600,
            ),
            labelColor: Colors.black,
            unselectedLabelColor: Colors.white,
            tabs: <Widget>[
              Text('My Country'),
              Text('Global'),
            ],
            onTap: (index) {},
          ),
        ),
      ),
    );
  }

  TextField _buildStatsTabBar() {
    return TextField();
  }

  Expanded _buildStatCard(String title, String count, MaterialColor color) {
    return Expanded(
      child: Container(
        margin: const EdgeInsets.all(8.0),
        padding: const EdgeInsets.all(10.0),
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              title,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 15.0,
                fontWeight: FontWeight.w600,
              ),
            ),
            Text(
              count,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 20.0,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  BaseBloc createBloc() =>
      PageViewBloc(context.read<Api>())..add(PageViewEvent('Vietnam'));
}
