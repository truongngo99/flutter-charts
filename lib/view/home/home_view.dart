import 'package:flutter/material.dart';
import 'package:flutter_chart_exam/data/list_chart.dart';

class HomeView extends StatefulWidget {
  HomeView({Key? key}) : super(key: key);

  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  ListChart listChart = ListChart();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Chart Flutter'),
      ),
      body: Container(
        padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
        child: ListView.builder(
            itemCount: listChart.data.length,
            itemBuilder: (context, index) {
              return Container(
                decoration: BoxDecoration(
                    border: Border.all(width: 0.5, color: Color(0xff999999)),
                    boxShadow: [
                      BoxShadow(
                        color: Color.fromARGB(128, 158, 158, 158),
                        spreadRadius: 1,
                        blurRadius: 3,
                        offset: Offset(0, 1),
                      ),
                    ],
                    borderRadius: BorderRadius.all(Radius.circular(10))),
                margin: EdgeInsets.only(top: 15),
                child: ListTile(
                  trailing: Icon(Icons.arrow_right_alt),
                  title:
                      Text('Ex ${index + 1}: ${listChart.data[index]['name']}'),
                  onTap: () {
                    Navigator.pushNamed(
                        context, listChart.data[index]['route']);
                  },
                ),
              );
            }),
      ),
    );
  }
}
