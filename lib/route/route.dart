import 'package:flutter/cupertino.dart';
import 'package:flutter_chart_exam/view/bar_chart/bar_chart_view.dart';
import 'package:flutter_chart_exam/view/bar_chart_stack/bar_chart_stack_view.dart';
import 'package:flutter_chart_exam/view/group_bar_chart/group_bar_chart_view.dart';
import 'package:flutter_chart_exam/view/home/home_view.dart';

import 'package:flutter_chart_exam/view/pie_chart/pie_chart_view.dart';
import 'package:flutter_chart_exam/view/stack_area_line_chart/stack_area_line_chart_view.dart';
import 'package:flutter_chart_exam/view/time_line_chart/time_line_chart_basic_view.dart';

class Routes {
  Map<String, Widget Function(BuildContext context)> route = {
    '/': (context) => HomeView(),
    'barchartbasic': (context) => BarChartView(
          title: 'Bar Chart Basic',
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
  };
}
