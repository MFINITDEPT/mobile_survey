import 'dart:io';

import 'package:dio/adapter.dart';
import 'package:dio/dio.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:mobilesurvey/model/mobile_dashboard/branch.dart';
import 'package:mobilesurvey/model/mobile_dashboard/collection.dart';
import 'package:mobilesurvey/model/mobile_dashboard/login_response.dart';
import 'package:mobilesurvey/model/mobile_dashboard/marketing.dart';
import 'package:mobilesurvey/model/mobile_dashboard/report_chart.dart';
import 'package:mobilesurvey/ui/interceptor.dart';
import 'package:mobilesurvey/utilities/date_utils.dart';
import '../model/ao.dart';
import '../model/configuration.dart';
import '../model/photo_form.dart';
import '../model/quisioner.dart';
import '../model/zipcode.dart';
import '../repositories/master.dart';
import '../utilities/string_utils.dart';

import 'enum.dart';

// ignore: avoid_classes_with_only_static_members, public_member_api_docs
class APIRequest {
  static AppType appType;
  static String _url = "https://ver-itrack.mncfinance.net/";
  static final String _surveyUrlDev = "https://10.1.80.83:45455/api/master/";
  static final String _dashboardUrlProd =
      "https://api-collplay.mncfinance.net/";

  static String _collplay = "CollPlay/";
  static String _marketing = "Marketing/";

  static Dio config(AppType appType) {
    var _newDio = Dio();
    switch (appType) {
      case AppType.survey:
        _newDio.options.baseUrl = _surveyUrlDev;
        break;
      case AppType.collection:
        _newDio.options.baseUrl = _surveyUrlDev;
        break;
      case AppType.dashboard:
        _newDio.options.baseUrl = _dashboardUrlProd;
        break;
      case AppType.approval:
        _newDio.options.baseUrl = _surveyUrlDev;
        break;
    }

    print(_newDio.options.baseUrl);

    (_newDio.httpClientAdapter as DefaultHttpClientAdapter).onHttpClientCreate =
        (HttpClient client) {
      client.badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
    };

    return _newDio;
  }

  static Future<Options> _getDioOptions({contentType contentType}) async {
    return Options(
        headers: await _createHeaderWithToken(),
        contentType: StringUtils.getContentType(contentType),
        validateStatus: (statusCode) => statusCode == 200);
  }

  static Future<Map<String, String>> _createHeaderWithToken() async {
    var token = await _getBearerToken(appType);
    return {"Authorization": 'Bearer $token'};
  }

  static Future<String> _getBearerToken(AppType appType) async {
    var _dio = Dio();
    var options = Options();

    var param = <String, dynamic>{
      'grant_type': 'client_credentials',
      'scope': '*'
    };

    switch (appType) {
      case AppType.survey:
        param.putIfAbsent('client_id', () => 4);
        param.putIfAbsent(
            'client_secret', () => 'OaKIwQydNdp5VSqvMGsK5tlLCQrqx5UArdae8NX0');
        break;
      case AppType.collection:
        param.putIfAbsent('client_id', () => 4);
        param.putIfAbsent(
            'client_secret', () => 'OaKIwQydNdp5VSqvMGsK5tlLCQrqx5UArdae8NX0');
        break;
      case AppType.dashboard:
        param.putIfAbsent('client_id', () => 4);
        param.putIfAbsent(
            'client_secret', () => 'OaKIwQydNdp5VSqvMGsK5tlLCQrqx5UArdae8NX0');
        break;
      case AppType.approval:
        param.putIfAbsent('client_id', () => 4);
        param.putIfAbsent(
            'client_secret', () => 'OaKIwQydNdp5VSqvMGsK5tlLCQrqx5UArdae8NX0');
        break;
    }

    var url = "http://202.147.193.199:8989/o2svr/public/oauth/token";
    options..contentType = StringUtils.getContentType(contentType.urlEncoded);

    var result = await _dio
        .post<dynamic>(url, data: param, options: options)
        .catchError((error) {
      return null;
    });

    return result == null
        ? _getBearerToken(appType)
        : result?.data["access_token"];
  }

  static Future<List<QuisionerModel>> masterQuisioner() async {
    var options = await _getDioOptions(contentType: contentType.json);

    var url = "Quisioner";

    var result = await config(appType)
        .get<dynamic>(url, options: options)
        .catchError((error) {
      print("$url Error");
      return null;
    });

    var res = <QuisionerModel>[];
    if (result.data != null) {
      var list = List.from(result.data);
      // ignore: avoid_function_literals_in_foreach_calls
      list.forEach((element) => res.add(QuisionerModel.fromJson(element)));
    }

    return res;
  }

  static Future<List<ZipCodeModel>> masterZipCode() async {
    var options = await _getDioOptions(contentType: contentType.json);

    var url = "zipcode";

    var result = await config(appType)
        .get<dynamic>(url, options: options)
        .catchError((error) {
      Fluttertoast.showToast(
          msg: error.toString(),
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          fontSize: 16.0);
      print("$url Error");
      return null;
    });

    var res = <ZipCodeModel>[];
    if (result.data != null) {
      var list = List.from(result.data);
      // ignore: avoid_function_literals_in_foreach_calls
      list.forEach((element) => res.add(ZipCodeModel.fromJson(element)));
    }

    return result.data != null ? res : null;
  }

  static Future<ConfigurationModel> getConfiguration() async {
    var options = await _getDioOptions(contentType: contentType.json);

    var url = "configuration";

    var result = await config(appType)
        .get<dynamic>(url, options: options)
        .catchError((error) {
      print("$url Error");
      return null;
    });

    var res = result != null ? ConfigurationModel.fromJson(result.data) : null;

    return res;
  }

  static Future<List<AoModel>> masterAo() async {
    var options = await _getDioOptions(contentType: contentType.json);

    var url = "ao";

    var result = await config(appType)
        .get<dynamic>(url, options: options)
        .catchError((error) {
      print("$url Error");
      return null;
    });

    var res = <AoModel>[];
    if (result.data != null) {
      var list = List.from(result.data);
      // ignore: avoid_function_literals_in_foreach_calls
      list.forEach((element) => res.add(AoModel.fromJson(element)));
    }
    return res;
  }

  static Future<List<PhotoForm>> getFotoForm(int id) async {
    var options = await _getDioOptions(contentType: contentType.json);

    var url = 'getFotoForm';
    var params = <String, int>{}..putIfAbsent("id", () => id);
    var result = await config(appType)
        .get<dynamic>(url, options: options, queryParameters: params)
        .catchError((error) {
      print("$url Error");
      return null;
    });

    var res = <PhotoForm>[];
    if (result.data != null) {
      var list = List.from(result.data);
      // ignore: avoid_function_literals_in_foreach_calls
      list.forEach((element) => res.add(PhotoForm.fromJson(element)));
    }

    return res;
  }

  static Future<dynamic> checkDuplicateName(String name) async {
    var options = await _getDioOptions(contentType: contentType.json);

//    String url = "https://ver-itrack.mncfinance.net/api/validate/" + "checkNameExisting";
    var url =
        "https://ver-itrack.mncfinance.net/api/validate/checkNameExisting";

    var param = <String, dynamic>{'Name': name};

    var result = await config(appType)
        .post<dynamic>(url, options: options, data: param)
        .catchError((error) {
      return null;
    });

    return result.data;
  }

  static Future<dynamic> insertIntoMsix(
      {String prefixSalute,
      String name,
      String suffixSalute,
      String identityNo,
      DateTime validOf,
      DateTime expiredOf,
      String identityCity,
      String ao,
      String birthLocation,
      DateTime birthDate,
      String address1,
      String address2,
      String address3,
      String motherName,
      String rt,
      String rw,
      String zipcode,
      String village,
      String district,
      String handphoneNo,
      String phoneArea,
      String phoneNo,
      String fax}) async {
    var options = await _getDioOptions(contentType: contentType.json);

    var url =
        "https://ver-itrack.mncfinance.net/api/process/insertclientintomsix";

    var param = <String, dynamic>{}
      ..putIfAbsent("c_code", () => "050")
      ..putIfAbsent("name", () => name)
      ..putIfAbsent("real_name", () => name)
      ..putIfAbsent("salute1", () => prefixSalute)
      ..putIfAbsent("salute1p", () => prefixSalute)
      ..putIfAbsent("salute2p", () => suffixSalute)
      ..putIfAbsent("status", () => 1)
      ..putIfAbsent("address1", () => address1)
      ..putIfAbsent("address2", () => address2)
      ..putIfAbsent("address3", () => address3)
      ..putIfAbsent("kecamatan", () => village)
      ..putIfAbsent("kelurahan", () => district)
      ..putIfAbsent("area_code", () => zipcode)
      ..putIfAbsent("phone", () => phoneNo)
      ..putIfAbsent("fax", () => fax == '' ? null : fax)
      ..putIfAbsent(
          "ao",
          () => MasterRepositories.ao
              .firstWhere((element) => element.descs == ao)
              .code)
      ..putIfAbsent("wlist", () => "0")
      ..putIfAbsent("collateral", () => "0")
      ..putIfAbsent("cre_date", () => DateTime.now().toString())
      ..putIfAbsent("cre_by", () => "1911806")
      ..putIfAbsent("cre_ip_address", () => "172.31.9.3")
      ..putIfAbsent("mod_date", () => DateTime.now().toString())
      ..putIfAbsent("mod_by", () => "1911806")
      ..putIfAbsent("mod_ip_address", () => "172.31.9.3")
      ..putIfAbsent("kota", () => identityCity)
      ..putIfAbsent("npwp", () => null)
      ..putIfAbsent("area_codes", () => phoneArea)
      ..putIfAbsent("inborndt", () => birthDate.toString())
      ..putIfAbsent("inbornplc", () => birthLocation)
      ..putIfAbsent("ibukandung", () => motherName)
      ..putIfAbsent("inmailtelp", () => handphoneNo)
      ..putIfAbsent("inktp", () => identityNo)
      ..putIfAbsent("ineffktp", () => validOf.toString())
      ..putIfAbsent("inexpktp", () => expiredOf.toString())
      ..putIfAbsent("kota_terbit_ktp", () => identityCity)
      ..putIfAbsent("rt", () => rt)
      ..putIfAbsent("rw", () => rw);

    var result = await config(appType)
        .post<dynamic>(url, options: options, data: param)
        .catchError((error) {
      return null;
    });

    return result.data;
  }

  static Future<LoginResponse> login(String userId, String password) async {
    var param = <String, dynamic>{'userid': userId, 'password': password};
    var url = "${_collplay}LoginUserMobileCollplay";
    var options = await _getDioOptions(contentType: contentType.json);

    var result = await config(appType)
        .post<dynamic>(url, data: param, options: options)
        .catchError((error) {});

    var finalresult =
        result != null ? LoginResponse.fromJson(result.data) : null;

    return finalresult;
  }

  static Future<List<BranchModel>> getBranch(String userId) async {
    var param = <String, dynamic>{'userid': userId};
    var url = "${_collplay}getBranchUser";

    var options = await _getDioOptions(contentType: contentType.json);
    var result = await config(appType)
        .post<dynamic>(url, data: param, options: options)
        .catchError((error) {});

    if (result == null) return [];

    var listItem = result.data as List;
    var branches = <BranchModel>[];

    for (var i = 0; i < listItem.length; i++) {
      branches.add(BranchModel.fromJson(listItem[i]));
    }

    var finalResult = branches.isEmpty ? null : branches;

    return finalResult;
  }

  static Future<List<ReportChartDataObject>> getReportChartData(
      DateTime date, bool isEndMonth, String branch, bool isKPR) async {
    var param = <String, dynamic>{
      'date': DateUtils.convertDateTimeToString(date, format: 'yyyy-MM-dd'),
      'isEndMonth': isEndMonth,
      'branch': branch == "" ? null : branch,
      'isKPR': isKPR,
    };

    var url = "${_collplay}getchartdata";
    var options = await _getDioOptions(contentType: contentType.json);

    var result = await config(appType)
        .post<dynamic>(url, data: param, options: options)
        .catchError((error) {});

    var finalResult = <ReportChartDataObject>[];

    if (result != null && result.data.length > 0) {
      for (var i = 0; i < result.data.length; i++) {
        finalResult.add(ReportChartDataObject.fromJSON(result.data[i]));
      }
    }

    return finalResult.isNotEmpty ? finalResult : null;
  }

  static Future<CollectionModel> getDataCollection(
      DateTime date, DateTime lastDate, String branch, bool isKPR) async {
    var param = <String, dynamic>{
      'date': DateUtils.convertDateTimeToString(date, format: 'yyyy-MM-dd'),
      'lastDate':
          DateUtils.convertDateTimeToString(lastDate, format: 'yyyy-MM-dd'),
      'branch': branch == "" ? null : branch,
      'isKPR': isKPR
    };

    var url = "${_collplay}GetDataForDisplay";
    var options = await _getDioOptions(contentType: contentType.json);

    var result = await config(appType)
        .post<dynamic>(url, data: param, options: options)
        .catchError((error) {});

    var finalresult =
        result != null ? CollectionModel.fromJson(result.data) : null;

    return finalresult;
  }

  static Future<List<MarketingReportModel>> getMarketingData(
      DateTime date, String branch) async {
    var param = <String, dynamic>{
      'tahun':
          int.tryParse(DateUtils.convertDateTimeToString(date, format: "yyyy")),
      'bulan':
          int.tryParse(DateUtils.convertDateTimeToString(date, format: "MM")),
      'branch': branch == "" ? null : branch
    };

    var url = "${_marketing}getDataSales";
    var options = await _getDioOptions(contentType: contentType.json);

    var result = await config(appType)
        .post<dynamic>(url, data: param, options: options)
        .catchError((error) {});

    var res =
        result != null ? MarketingReportModel.fromJson(result.data) : null;

    var res2 =
        result != null ? MarketingReportModel.fromJson(result.data) : null;

    var finalResult = result != null ? [res, res2] : null;

    return finalResult;
  }
}
