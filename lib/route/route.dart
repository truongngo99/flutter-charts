import 'package:flutter/cupertino.dart';
import 'package:flutter_chart_exam/view/bar_chart/bar_chart_view.dart';
import 'package:flutter_chart_exam/view/bar_chart/bar_chart_view_vertical.dart';
import 'package:flutter_chart_exam/view/bar_chart_stack/bar_chart_stack_view.dart';
import 'package:flutter_chart_exam/view/group_bar_chart/group_bar_chart_view.dart';
import 'package:flutter_chart_exam/view/histogram_chart/historgram_chart_view.dart';
import 'package:flutter_chart_exam/view/home/home_view.dart';
import 'package:flutter_chart_exam/view/page_view/page_view.dart';

import 'package:flutter_chart_exam/view/pie_chart/pie_chart_view.dart';
import 'package:flutter_chart_exam/view/scattle_chart/scattle_chart_view.dart';
import 'package:flutter_chart_exam/view/stack_area_line_chart/stack_area_line_chart_view.dart';
import 'package:flutter_chart_exam/view/time_line_chart/time_line_chart_basic_view.dart';

class Routes {
  Map<String, Widget Function(BuildContext context)> route = {
    '/': (context) => HomeView(),
    'pageview': (context) => PageViewScreen(),
    'barchartbasic': (context) => BarChartView(
          title: 'Bar Chart Basic',
        ),
    'barchartbasicvertical': (context) => BarChartVerticalView(
          title: 'Bar Chart Vertical',
        ),
    'timelinechart': (context) => TimeLineChartBasic(
          title: 'Time Chart Basic',
        ),
    'piechartbasic': (context) => PieChartBasic(title: 'Pie Chart Basic'),
    'barchartstack': (context) => BarChartStackView(title: 'Bar Chart Stack'),
    'groupbarchart': (context) =>
        GroupBarChartView(title: 'Group Bar Chart Stack'),
    'stackarealinechart': (context) =>
        StackAreaLineChartView(title: 'Stack Area Line'),
    'histogramchart': (context) => HistogramChartView(title: 'Histogram Chart'),
    'scatlechart': (context) => ScatleChartView(title: 'Scatle Chart'),
  };
}
