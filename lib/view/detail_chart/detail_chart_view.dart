import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_chart_exam/data/post/api.dart';

import 'package:flutter_chart_exam/view/detail_chart/detail_chart_bloc.dart';

import 'package:flutter_chart_exam/view/detail_chart/detail_chart_month_view.dart';
import 'package:flutter_chart_exam/view/detail_chart/detail_chart_state.dart';
import 'package:flutter_chart_exam/view/detail_chart/detail_chart_year_view.dart';

import 'package:teq_flutter_core/teq_flutter_core.dart';

class DetailChartView extends StatefulWidget {
  final String title;
  final String code;
  final String country;
  final String status;
  DetailChartView(
      {Key? key,
      required this.code,
      required this.status,
      required this.title,
      required this.country})
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
  BaseBloc createBloc() => DetailChartBloc(context.read<Api>());

  Widget _buildBody(BuildContext context, DetailChartState state) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: Text('${widget.country} COVID-19 ${widget.title} '),
          backgroundColor: widget.status == 'confirmed'
              ? Colors.green
              : widget.status == 'recovered'
                  ? Colors.blue
                  : Colors.red,
          bottom: TabBar(
            indicatorColor: Colors.white,
            indicatorWeight: 6,
            unselectedLabelColor: Colors.grey,
            tabs: [
              Tab(
                child: Container(
                  child: Text(
                    'Year',
                    style: TextStyle(color: Colors.white, fontSize: 18.0),
                  ),
                ),
              ),
              Tab(
                child: Container(
                  child: Text(
                    'Month',
                    style: TextStyle(color: Colors.white, fontSize: 18.0),
                  ),
                ),
              ),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            DetailChartYearView(
              code: widget.code,
              status: widget.status,
            ),
            DetailChartMonthView(
              code: widget.code,
              status: widget.status,
            ),
          ],
        ),
      ),
    );
  }
}
