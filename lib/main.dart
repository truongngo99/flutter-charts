import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_chart_exam/change_material_app.dart';
import 'package:flutter_chart_exam/data/post/api.dart';
import 'package:flutter_chart_exam/data/post/api_impl.dart';
import 'package:flutter_chart_exam/route/route.dart';

import 'package:teq_flutter_core/teq_flutter_core.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    currentEnvironment = Environment.DEV;
    TeqNetwork.init(ApiUrl(), httpError: HttpError());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [RepositoryProvider<Api>(create: (context) => ApiImpl())],
      child: MaterialAppChange(
        height: double.infinity,
        width: double.infinity,
        enableConfigView: true,
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.orange,
        ),
        initialRoute: '/',
        routes: Routes().route,
      ),
    );
  }
}
