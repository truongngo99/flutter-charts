import 'package:flutter/cupertino.dart';
import 'package:flutter_chart_exam/view/bar_chart/bar_chart_view.dart';
import 'package:flutter_chart_exam/view/bar_chart_stack/bar_chart_stack_view.dart';
import 'package:flutter_chart_exam/view/home/home_view.dart';
import 'package:flutter_chart_exam/view/line_chart/line_chart_basic_view.dart';
import 'package:flutter_chart_exam/view/pie_chart/pie_chart_view.dart';

class Routes {
  Map<String, Widget Function(BuildContext context)> route = {
    '/': (context) => HomeView(),
    'barchartbasic': (context) => BarChartView(
          title: 'Bar Chart Basic',
        ),
    'timelinechart': (context) => LineChartBasic(
          title: 'Time Chart Basic',
        ),
    'piechartbasic': (context) => PieChartBasic(title: 'Pie Chart Basic'),
    'barchartstack': (context) => BarChartStackView(title: 'Bar Chart Stack'),
  };
}
