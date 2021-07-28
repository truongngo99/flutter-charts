import 'package:flutter_chart_exam/data/post/api.dart';
import 'package:flutter_chart_exam/data/respose/covid/covid.dart';
import 'package:teq_flutter_core/teq_flutter_core.dart';

class ApiImpl extends BaseAPI with Api {
  @override
  Future<CovidModel> getDataCovid() async {
    return CovidModel.fromJson(await sendApiRequest(getData));
  }

  @override
  Future<CovidModel> getDeathsCampuchia() async {
    return CovidModel.fromJson(await sendApiRequest(getDeathCampuchia));
  }

  @override
  Future<CovidModel> getDataCountry(String country) async {
    return CovidModel.fromJson(
        await sendApiRequest(getCountry, queryParameters: {
      'country': country,
    }));
  }

  @override
  Future<CovidModel> getDataCountryCode(String code) async {
    return CovidModel.fromJson(
        await sendApiRequest(getCountryAB, queryParameters: {
      'ab': code,
    }));
  }

  @override
  Future<CovidModel> getDetailCountry(String code, String status) async {
    return CovidModel.fromJson(
        await sendApiRequest(getDetail, queryParameters: {
      'ab': code,
      'status': status,
    }));
  }
}
