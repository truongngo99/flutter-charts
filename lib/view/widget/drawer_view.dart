import 'package:flutter/material.dart';
import 'package:flutter_chart_exam/data/list_chart.dart';
import 'package:flutter_chart_exam/view/bar_chart/bar_chart_view.dart';
import 'package:flutter_chart_exam/view/bar_chart/bar_chart_view_vertical.dart';
import 'package:flutter_chart_exam/view/bar_chart_stack/bar_chart_stack_view.dart';
import 'package:flutter_chart_exam/view/group_bar_chart/group_bar_chart_view.dart';
import 'package:flutter_chart_exam/view/histogram_chart/historgram_chart_view.dart';
import 'package:flutter_chart_exam/view/page_view/page_view.dart';
import 'package:flutter_chart_exam/view/pie_chart/pie_chart_view.dart';
import 'package:flutter_chart_exam/view/scattle_chart/scattle_chart_view.dart';
import 'package:flutter_chart_exam/view/stack_area_line_chart/stack_area_line_chart_view.dart';
import 'package:flutter_chart_exam/view/time_line_chart/time_line_chart_basic_view.dart';
import 'package:teq_flutter_core/teq_flutter_core.dart';

class DrawerView extends StatelessWidget {
  const DrawerView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ListChart listChart = ListChart();
    return Drawer(
        child: Column(
      children: [
        Container(
          width: double.infinity,
          color: Color(0xFF473F97),
          padding: EdgeInsets.all(10),
          child: Center(
            child: Column(
              children: [
                Container(
                  width: 100,
                  height: 100,
                  margin: EdgeInsets.only(top: 20),
                  decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      image: DecorationImage(
                          fit: BoxFit.fill,
                          image: NetworkImage(
                              'https://yt3.ggpht.com/ytc/AKedOLRt1d4p7bPylasq_66BIC8-k3hkyVjJ2JICQITK=s900-c-k-c0x00ffffff-no-rj'))),
                ),
              ],
            ),
          ),
        ),
        // Container(
        //   height: 590,
        //   child: ListView.builder(
        //       itemCount: listChart.data.length,
        //       itemBuilder: (context, index) {
        //         return ListTile(
        //           title: Text('${listChart.data[index]['name']}'),
        //           onTap: () {
        //             Navigator.pushNamed(
        //                 context, listChart.data[index]['route']);
        //           },
        //         );
        //       }),
        // ),
        ListTile(
          title: Text(
            'Example',
            style: TextStyle(fontSize: 16),
          ),
          onTap: () {
            transferToNewScreen(
              context,
              PageViewScreen(),
            );
          },
        ),
        ListTile(
          title: Text(
            'Bar Chart Basic',
            style: TextStyle(fontSize: 16),
          ),
          onTap: () {
            transferToNewScreen(
              context,
              BarChartView(
                title: 'Bar Chart Basic',
              ),
            );
          },
        ),
        ListTile(
          title: Text(
            'Bar Chart Basic Vertical',
            style: TextStyle(fontSize: 16),
          ),
          onTap: () {
            transferToNewScreen(
              context,
              BarChartVerticalView(
                title: 'Bar Chart Vertical',
              ),
            );
          },
        ),
        ListTile(
          title: Text(
            'Time Line Chart Basic',
            style: TextStyle(fontSize: 16),
          ),
          onTap: () {
            transferToNewScreen(
              context,
              TimeLineChartBasic(
                title: 'Time Chart Basic',
              ),
            );
          },
        ),
        ListTile(
          title: Text(
            'Pie Chart Basic',
            style: TextStyle(fontSize: 16),
          ),
          onTap: () {
            transferToNewScreen(
              context,
              PieChartBasic(title: 'Pie Chart Basic'),
            );
          },
        ),
        ListTile(
          title: Text(
            'Bar Chart Stack',
            style: TextStyle(fontSize: 16),
          ),
          onTap: () {
            transferToNewScreen(
              context,
              BarChartStackView(title: 'Bar Chart Stack'),
            );
          },
        ),
        ListTile(
          title: Text(
            'Group Bar Chart Stack',
            style: TextStyle(fontSize: 16),
          ),
          onTap: () {
            transferToNewScreen(
              context,
              GroupBarChartView(title: 'Group Bar Chart Stack'),
            );
          },
        ),
        ListTile(
          title: Text(
            'Stack Area Line Chart',
            style: TextStyle(fontSize: 16),
          ),
          onTap: () {
            transferToNewScreen(
              context,
              StackAreaLineChartView(title: 'Stack Area Line'),
            );
          },
        ),
        ListTile(
          title: Text(
            'Histogram  Chart',
            style: TextStyle(fontSize: 16),
          ),
          onTap: () {
            transferToNewScreen(
              context,
              HistogramChartView(title: 'Histogram Chart'),
            );
          },
        ),
        ListTile(
          title: Text(
            'Scatle  Chart',
            style: TextStyle(fontSize: 16),
          ),
          onTap: () {
            transferToNewScreen(
              context,
              ScatleChartView(title: 'Scatle Chart'),
            );
          },
        ),
      ],
    ));
  }
}
