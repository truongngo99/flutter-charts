import 'package:flutter_chart_exam/data/respose/covid/covid.dart';
import 'package:teq_flutter_core/teq_flutter_core.dart';

abstract class Api {
  Method get getData => GET('history?country=Vietnam&status=deaths');
  Future<CovidModel> getDataCovid();
}

class ApiUrl extends BaseUrl {
  @override
  String dev() => 'https://covid-api.mmediagroup.fr/v1/';

  @override
  String prod() {
    // TODO: implement prod
    throw UnimplementedError();
  }

  @override
  String stg() {
    // TODO: implement stg
    throw UnimplementedError();
  }
}
