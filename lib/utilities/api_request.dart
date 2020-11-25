import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:mobilesurvey/model/nik_data.dart';
import 'package:mobilesurvey/model/quisioner.dart';
import 'package:mobilesurvey/model/zipcode.dart';
import 'package:mobilesurvey/utilities/string_utils.dart';
import 'package:ridjnaelcrypt/ridjnaelcrypt.dart';

import 'enum.dart';

class APIRequest {
  static Dio _dio = Dio();
  static String _url = "https://ver-itrack.mncfinance.net/";
  static String _urldev = "http://172.31.9.104:9993/api/master/";
  static String _baseurl = "${_url}api/ITrack/";
  static String baseImageUrl = "${_url}profile/";

  static Future<Options> _getDioOptions({contentType contentType}) async {
    return Options(
        headers: await _createHeaderWithToken(),
        contentType: StringUtils.getContentType(contentType),
        validateStatus: (statusCode) => statusCode == 200);
  }

  static Future<Map<String, String>> _createHeaderWithToken() async {
    String token = await _getBearerToken();
    return {"Authorization": 'Bearer $token'};
  }

  static Future<String> _getBearerToken() async {
    Options options = Options();

    Map<String, dynamic> param = {
      'grant_type': 'client_credentials',
      'client_id': 4,
      'client_secret': 'OaKIwQydNdp5VSqvMGsK5tlLCQrqx5UArdae8NX0',
      'scope': '*'
    };

    String url = "http://202.147.193.199:8989/o2svr/public/oauth/token";
    options..contentType = StringUtils.getContentType(contentType.urlEncoded);

    var result = await _dio
        .post<dynamic>(url, data: param, options: options)
        .catchError((error) {});

    return result == null ? _getBearerToken() : result?.data["access_token"];
  }

  static Future<NikDataModel> getNikEncrypt(String nik) async {
    Options options = await _getDioOptions(contentType: contentType.html);

    var param = Ridjnael.computeEncrypt('{"nik":"$nik"}');

    String url = "https://api-itrack.mncfinance.net/StagingToDukcapil/Index";

    var result = await _dio
        .post<dynamic>(url, data: param, options: options)
        .catchError((error) {});

    var res = result != null ? NikDataModel.fromJson(result.data['ct']) : null;
    return res;
  }

  static Future<List<QuisionerModel>> masterQuisioner() async {
    Options options = await _getDioOptions(contentType: contentType.json);

    String url = _urldev + "question";

    var result =
        await _dio.get<dynamic>(url, options: options).catchError((error) {
    });

    List<QuisionerModel> res = [];
    if(result.data != null) {
      var list = List.from(result.data);
      list.forEach((element) => res.add(QuisionerModel.fromJson(element)));
    }

    return res;
  }

  static Future<List<ZipCodeModel>> masterZipCode() async {
    Options options = await _getDioOptions(contentType: contentType.json);

    String url = _urldev + "zipcode";

    var result =
    await _dio.get<dynamic>(url, options: options).catchError((error) {
    });

    List<ZipCodeModel> res = [];
    if(result.data != null) {
      var list = List.from(result.data);
      list.forEach((element) => res.add(ZipCodeModel.fromJson(element)));
    }

    return result.data != null ? res : null;
  }
}
