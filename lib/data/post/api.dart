import 'package:flutter_chart_exam/data/respose/covid/covid.dart';
import 'package:teq_flutter_core/teq_flutter_core.dart';

abstract class Api {
  Method get getData => GET('history?country=Vietnam&status=deaths');
  Future<CovidModel> getDataCovid();

  Method get getDeathCampuchia => GET('history?country=Cambodia&status=deaths');
  Future<CovidModel> getDeathsCampuchia();

  Method get getCountry => GET('cases?');
  Future<CovidModel> getDataCountry(String country);

  Method get getCountryAB => GET('cases?');
  Future<CovidModel> getDataCountryCode(String code);

  Method get getDetail => GET('history?');
  Future<CovidModel> getDetailCountry(String code, String status);
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
