import 'package:flutter/material.dart';
import 'package:flutter_chart_exam/data/list_chart.dart';
import 'package:flutter_chart_exam/view/widget/call_view.dart';
import 'package:flutter_chart_exam/view/widget/web_view.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

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
        ListTile(
          leading: Icon(
            Icons.phone,
            color: Colors.red,
          ),
          title: Text(
            'Urgent call',
            style: TextStyle(fontSize: 16),
          ),
          onTap: () {
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => CallView()));
          },
        ),
        ListTile(
          leading: Icon(
            FontAwesomeIcons.pencilAlt,
            size: 20,
            color: Colors.blue,
          ),
          title: Text(
            'Health declaration',
            style: TextStyle(fontSize: 16),
          ),
          onTap: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => WebViewScreen()));
          },
        ),
        Divider(
          thickness: 1,
        ),
        Expanded(
          child: ListView.builder(
              itemCount: listChart.data.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(
                    '${listChart.data[index]['name']}',
                    style: TextStyle(fontSize: 16),
                  ),
                  onTap: () {
                    Navigator.pushNamed(
                        context, listChart.data[index]['route']);
                  },
                );
              }),
        ),
      ],
    ));
  }
}
