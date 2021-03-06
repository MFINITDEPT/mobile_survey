import 'dart:async';
import 'dart:convert';

import 'package:dio/adapter.dart';
import 'package:dio/dio.dart';
import 'package:location/location.dart';
import 'package:mobilesurvey/model/client_controllers.dart';
import 'package:mobilesurvey/model/master_configuration/configuration.dart';
import 'package:mobilesurvey/model/master_configuration/form_upload_item.dart';
import 'package:mobilesurvey/model/master_configuration/form_upload_response.dart';
import 'package:mobilesurvey/model/master_configuration/quisioner_item.dart';
import 'package:mobilesurvey/model/master_configuration/quisioner_response.dart';
import 'package:mobilesurvey/model/master_configuration/zipcode_item.dart';
import 'package:mobilesurvey/model/master_configuration/zipcode_response.dart';
import 'package:mobilesurvey/model/mobile_dashboard/branch.dart';
import 'package:mobilesurvey/model/mobile_dashboard/collection.dart';
import 'package:mobilesurvey/model/mobile_dashboard/login_response.dart';
import 'package:mobilesurvey/model/mobile_dashboard/marketing.dart';
import 'package:mobilesurvey/model/mobile_dashboard/report_chart.dart';
import 'package:mobilesurvey/model/mobile_survey/document_item.dart';
import 'package:mobilesurvey/model/mobile_survey/login_response.dart';
import 'package:mobilesurvey/model/mobile_survey/photo_result.dart';
import 'package:mobilesurvey/model/mobile_survey/quisioner_answer.dart';
import 'package:mobilesurvey/model/response.dart';
import 'package:mobilesurvey/repositories/master.dart';
import 'package:mobilesurvey/ui/interceptor.dart';
import 'package:mobilesurvey/utilities/date_utils.dart';
import 'package:mobilesurvey/utilities/dummy.dart';
import 'package:mobx/mobx.dart';

import '../utilities/string_utils.dart';
import 'enum.dart';

class APIRequest {
  static AppType appType;
  static String _url = "https://ver-itrack.mncfinance.net/";

//  static final String _surveyUrlDev = "https://10.1.80.220:45456/";

  static final String _surveyUrlDev = "http://10.1.80.220:8071/";
  static final String _dashboardUrlProd =
      "https://api-collplay.mncfinance.net/";

  //  static final String _surveyUrlDev = "https://10.1.80.83:45456/api/";

  static String _collplay = "CollPlay/";
  static String _marketing = "Marketing/";

  static String _master = "master/";
  static String _user = "user/";

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
        //    _newDio.options.baseUrl = "http://10.1.80.220:8071/";
        _newDio.options.baseUrl = _surveyUrlDev;
        break;
    }

    print(_newDio.options.baseUrl);

    (_newDio.httpClientAdapter as DefaultHttpClientAdapter).onHttpClientCreate =
        (client) {
      client.badCertificateCallback = (cert, host, port) => true;
    };

    return _newDio;
  }

  static Future<Options> _getDioOptions({contentType contentType}) async {
    return Options(
        headers: await _createHeaderWithToken(),
        contentType: StringUtils.getContentType(contentType),
        validateStatus: (statusCode) => statusCode == 200 || statusCode == 500);
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

//  static Future<List<QuisionerModel>> masterQuisioner() async {
//    var options = await _getDioOptions(contentType: contentType.json);
//
//    var url = "${_master}Quisioner";
//
//    var result = await config(appType)
//        .get<dynamic>(url, options: options)
//        .catchError((error) {
//      print("$url Error");
//      return null;
//    });
//
//    var res = <QuisionerModel>[];
//    if (result.data != null) {
//      var list = List.from(result.data);
//      // ignore: avoid_function_literals_in_foreach_calls
//      list.forEach((element) => res.add(QuisionerModel.fromJson(element)));
//    }
//
//    return res;
//  }

//  static Future<List<ZipCodeModel>> masterZipCode() async {
//    var options = await _getDioOptions(contentType: contentType.json);
//
//    var url = "${_master}zipcode";
//
//    var result = await config(appType)
//        .get<dynamic>(url, options: options)
//        .catchError((error) {
//      Fluttertoast.showToast(
//          msg: error.toString(),
//          toastLength: Toast.LENGTH_SHORT,
//          gravity: ToastGravity.CENTER,
//          timeInSecForIosWeb: 1,
//          fontSize: 16.0);
//      print("$url Error");
//      return null;
//    });
//
//    var res = <ZipCodeModel>[];
//    if (result.data != null) {
//      var list = List.from(result.data);
//      // ignore: avoid_function_literals_in_foreach_calls
//      list.forEach((element) => res.add(ZipCodeModel.fromJson(element)));
//    }
//
//    return result.data != null ? res : null;
//  }

//  static Future<ConfigurationModel> getConfiguration() async {
//    var options = await _getDioOptions(contentType: contentType.json);
//
//    var url = "${_master}configuration";
//
//    var result = await config(appType)
//        .get<dynamic>(url, options: options)
//        .catchError((error) {
//      print("$url Error");
//      return null;
//    });
//
//    var res = result != null ? ConfigurationModel.fromJson(result.data) : null;
//
//    return res;
//  }

//  static Future<List<AoModel>> masterAo() async {
//    var options = await _getDioOptions(contentType: contentType.json);
//
//    var url = "${_master}ao";
//
//    var result = await config(appType)
//        .get<dynamic>(url, options: options)
//        .catchError((error) {
//      print("$url Error");
//      return null;
//    });
//
//    var res = <AoModel>[];
//    if (result.data != null) {
//      var list = List.from(result.data);
//      // ignore: avoid_function_literals_in_foreach_calls
//      list.forEach((element) => res.add(AoModel.fromJson(element)));
//    }
//    return res;
//  }

//  static Future<List<PhotoForm>> getFotoForm(int id) async {
//    var options = await _getDioOptions(contentType: contentType.json);
//
//    var url = '${_master}getFotoForm';
//    var params = <String, int>{}..putIfAbsent("id", () => id);
//    var result = await config(appType)
//        .get<dynamic>(url, options: options, queryParameters: params)
//        .catchError((error) {
//      print("$url Error");
//      return null;
//    });
//
//    var res = <PhotoForm>[];
//    if (result.data != null) {
//      var list = List.from(result.data);
//      // ignore: avoid_function_literals_in_foreach_calls
//      list.forEach((element) => res.add(PhotoForm.fromJson(element)));
//    }
//
//    return res;
//  }

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

/*  static Future<dynamic> insertIntoMsix(
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
  }*/

  static Future<LoginSurveyResponse> loginSurvey(
      String userId, String password, String token) async {
    var param = <String, dynamic>{
      'nik': userId,
      'password': password,
      'token': token
    };

    var url = "${_user}login";
    var options = await _getDioOptions(contentType: contentType.json);

/*    var result = await config(appType)
        .post<dynamic>(url, data: param, options: options)
        .catchError((error) => null);*/

    var result = <String, dynamic>{}
      ..putIfAbsent('nik', () => '123456')
      ..putIfAbsent('name', () => 'Yudis');

    var finalresult =
        result != null ? LoginSurveyResponse.fromJson(result) : null;

    return finalresult;
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
      'date': DateUtilities.convertDateTimeToString(date, format: 'yyyy-MM-dd'),
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
      'date': DateUtilities.convertDateTimeToString(date, format: 'yyyy-MM-dd'),
      'lastDate':
          DateUtilities.convertDateTimeToString(lastDate, format: 'yyyy-MM-dd'),
      'branch': branch == "" ? null : branch,
      'isKPR': isKPR
    };

    var url = "${_collplay}GetDataForDisplay";
    var options = await _getDioOptions(contentType: contentType.json);

    var result = await config(appType)
        .post<dynamic>(url, data: param, options: options)
        .catchError((error) {});

    var finalResult =
        result != null ? CollectionModel.fromJson(result.data) : null;

    return finalResult;
  }

  static Future<List<MarketingReportModel>> getMarketingData(
      DateTime date, String branch) async {
    var param = <String, dynamic>{
      'tahun': int.tryParse(
          DateUtilities.convertDateTimeToString(date, format: "yyyy")),
      'bulan': int.tryParse(
          DateUtilities.convertDateTimeToString(date, format: "MM")),
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

  static Future<dynamic> testMultipart() async {
    /// get => https://10.1.80.220:45455/API/formupload
    /// get => https://10.1.80.220:45455/API/zipcode
    /// https://localhost:44377/Api/FormUpload
    /// https://localhost:44377/Api/ZipCode
    /// https://localhost:44377/Api/Quisioner
    /// https://localhost:44377/Api/CheckUpadate

    var url = 'Api/Survey';
    var options = await _getDioOptions(contentType: contentType.multipart);

    var client = {}
      ..putIfAbsent('GELAR_DEPAN', () => 'MR')
      ..putIfAbsent('NAMA', () => 'Testing')
      ..putIfAbsent('GELAR_BELAKANG', () => 'S.Kom')
      ..putIfAbsent('NAMA_KTP', () => 'Testing juga')
      ..putIfAbsent('NO_KTP', () => '1234567891234567')
      ..putIfAbsent('KTP_EXPIRE_FROM', () => '2021-08-27')
      ..putIfAbsent('KTP_EXPIRE_TO', () => '2021-09-10')
      ..putIfAbsent('AO', () => 'TEsting')
      ..putIfAbsent('TGLLAHIR', () => '2021-07-10')
      ..putIfAbsent('TEMPATLAHIR', () => 'Bogor')
      ..putIfAbsent('NAMAIBU', () => 'Ibu')
      ..putIfAbsent('ALAMAT', () => 'MNC FInance')
      ..putIfAbsent('RT', () => '004')
      ..putIfAbsent('RW', () => '009')
      ..putIfAbsent('KODEPOS', () => '178264')
      ..putIfAbsent('KELURAHAN', () => 'Manggarai')
      ..putIfAbsent('KECAMATAN', () => 'Kebon Sirih')
      ..putIfAbsent('HPNO', () => '0851478264526')
      ..putIfAbsent('TELPNO', () => '021-8903562')
      ..putIfAbsent('FAXNO', () => '021351')
      ..putIfAbsent('NOPOL', () => 'B 1235 FFA')
      ..putIfAbsent('LAT', () => "106.368525")
      ..putIfAbsent('LNG', () => '0.654252')
      ..putIfAbsent('TASKID', () => '');
//    var file = await MultipartFile.fromFile(
//        '/data/user/0/finance.mnc.mobilesurvey/app_flutter/app_name/files/fotokonsumensedangttdkontrakmncf_1621223055860.jpg',
//        filename: 'FOTO_KONSUMEN_SEDANG_TTD_KONTRAK_MNCF.jpg');
//    var file1 = await MultipartFile.fromFile(
//        '/data/user/0/finance.mnc.mobilesurvey/app_flutter/app_name/files/fotokonsumensedangttdkontrakmncf_1621223055860.jpg',
//        filename: 'FOTO_KONSUMEN_SEDANG_TTD_KONTRAK_MNCF.jpg');
    var file2 = await MultipartFile.fromFile(
        '/data/user/0/finance.mnc.mobilesurvey/app_flutter/app_name/files/fotokonsumensedangttdkontrakmncf_1621498097417.jpg',
        filename: 'test2.jpg');
    var file3 = await MultipartFile.fromFile(
        '/data/user/0/finance.mnc.mobilesurvey/app_flutter/app_name/files/fotokonsumensedangttdkontrakmncf_1621498326550.jpg',
        filename: 'test2.jpg');
    var file4 = await MultipartFile.fromFile(
        '/data/user/0/finance.mnc.mobilesurvey/app_flutter/app_name/files/fotodalamrumah_1621498374603.jpg',
        filename: 'test2.jpg');
    var file5 = await MultipartFile.fromFile(
        '/data/user/0/finance.mnc.mobilesurvey/app_flutter/app_name/files/fotorumahtampaksampingkanan_1621498452019.jpg',
        filename: 'test2.jpg');
    var file6 = await MultipartFile.fromFile(
        '/data/user/0/finance.mnc.mobilesurvey/app_flutter/app_name/files/fotorumahtampaksampingkanan_1621498496317.jpg',
        filename: 'test2.jpg');

//    var param = FormData.fromMap({
//      'BODYJSON' : '"${jsonEncode(client)}"',
//      'IDQUISIONERDETAIL' : null,
//      'JAWABAN' : null,
//      'IDFORMDETAIL' : null,
//      'FILENAME' : null,
//      'PATH' : 'PATH',
//      'FOTO_KONSUMEN_SEDANG_TTD_KONTRAK_MNCF' : file,
//      'FOTO_PASANGAN_SEDANG_TTD_KONTRAK_MNCF' : file1,
//      'FOTO_PENJAMIN_SEDANG_TTD_KONTRAK_MNCF' : null,
//      'FOTO_RUMAH_TAMPAK_DEPAN' : file2
//    });

    var param = FormData.fromMap({
      'BODYJSON': jsonEncode(client),
      'IDQUISIONERDETAIL': null,
      'JAWABAN': null,
      'IDFORMDETAIL': [
        '3b9e47e3-b0ee-49f5-b605-57cd54932265',
        '3b9e47e3-b0ee-49f5-b605-57cd54932265',
        '3b9e47e3-b0ee-49f5-b605-57cd54932265',
        '3b9e47e3-b0ee-49f5-b605-57cd54932265',
        '3b9e47e3-b0ee-49f5-b605-57cd54932265'
      ],
      'FILENAME': null,
      'PATH': 'PATH',
      'FOTO_KONSUMEN_SEDANG_TTD_KONTRAK_MNCF': [
        file2,
        file3,
        file4,
        file5,
        file6,
      ]
    });

    param.fields.forEach((element) {
      print("ini element : $element");
    });

    param.files.forEach((element) {
      print("ini element : $element");
    });

    var result = await config(AppType.survey).post(url,
        data: param, options: options, onSendProgress: (send, total) {
      print("send data :$send of $total");
    }).onError((error, stackTrace) {
      print('ini error :$error');
      return null;
    });

    print(result.data);
    print("hello ");
  }

  static Future<dynamic> proccessSurvey(
      {List<ClientControllerModel> clients,
      List<PhotoResult> assets,
      List<PhotoResult> document,
      List<QuisionerAnswerModel> quisioner,
      LocationData location}) async {
    var url = 'Api/Survey';
    var options = await _getDioOptions(contentType: contentType.multipart);

    var client = {}
      ..putIfAbsent('GELAR_DEPAN', () => 'MR')
      ..putIfAbsent(
          'NAMA',
          () => clients
              .firstWhere((element) => element.controllerName == 'name')
              .controller
              .text)
      ..putIfAbsent('GELAR_BELAKANG', () => 'S.Kom')
      ..putIfAbsent(
          'NAMA_KTP',
          () => clients
              .firstWhere((element) => element.controllerName == 'name')
              .controller
              .text)
      ..putIfAbsent(
          'NO_KTP',
          () => clients
              .firstWhere((element) => element.controllerName == 'identity_no')
              .controller
              .text)
      ..putIfAbsent('KTP_EXPIRE_FROM', () => '2021-08-27')
      ..putIfAbsent('KTP_EXPIRE_TO', () => '2021-09-10')
      ..putIfAbsent('AO', () => "Test Dulu")
      ..putIfAbsent('TGLLAHIR', () => '2021-07-10')
      ..putIfAbsent(
          'TEMPATLAHIR',
          () => clients
              .firstWhere((element) => element.controllerName == 'birth_date')
              .controller
              .text)
      ..putIfAbsent(
          'NAMAIBU',
          () => clients
              .firstWhere((element) => element.controllerName == 'mother_name')
              .controller
              .text)
      ..putIfAbsent(
          'ALAMAT',
          () => clients
              .firstWhere((element) => element.controllerName == 'address')
              .controller
              .text)
      ..putIfAbsent(
          'RT',
          () => clients
              .firstWhere((element) => element.controllerName == 'rt')
              .controller
              .text)
      ..putIfAbsent(
          'RW',
          () => clients
              .firstWhere((element) => element.controllerName == 'rw')
              .controller
              .text)
      ..putIfAbsent(
          'KODEPOS',
          () => clients
              .firstWhere((element) => element.controllerName == 'zipcode')
              .controller
              .text)
      ..putIfAbsent(
          'KELURAHAN',
          () => clients
              .firstWhere((element) => element.controllerName == 'village')
              .controller
              .text)
      ..putIfAbsent(
          'KECAMATAN',
          () => clients
              .firstWhere((element) => element.controllerName == 'district')
              .controller
              .text)
      ..putIfAbsent(
          'HPNO',
          () => clients
              .firstWhere((element) => element.controllerName == 'handphone_no')
              .controller
              .text)
      ..putIfAbsent(
          'TELPNO',
          () => clients
              .firstWhere((element) => element.controllerName == 'phone_no')
              .controller
              .text)
      ..putIfAbsent(
          'FAXNO',
          () => clients
              .firstWhere((element) => element.controllerName == 'fax')
              .controller
              .text)
      ..putIfAbsent('NOPOL', () => 'B 1235 FFA')
      ..putIfAbsent('LAT', () => location.latitude.toString())
      ..putIfAbsent('LNG', () => location.longitude.toString())
      ..putIfAbsent(
          'IDQUESTION', () => MasterRepositories.quisioners[0].idQuisioner)
      ..putIfAbsent('TASKID', () => '049cfde3-0835-40d4-b77d-a6ef761f8043');

    List<String> idFormDetails = [];
    List<String> idQuisionerDetail = [];
    List<String> listJawaban = [];

    var params = {
      'BODYJSON': jsonEncode(client),
      'IDFORMDETAIL': idFormDetails
    };

    for (var item in quisioner) {
      var jawaban = '';
      if (item?.choice != null) {
        jawaban = "${item.choice.value} ";
      }

      if (item?.controller?.text != null && item.controller.text != '') {
        jawaban += "(${item.controller.text})";
      }
      idQuisionerDetail.add(item.id);
      listJawaban.add(jawaban == '' ? "Tidak Terisi" : jawaban);
    }
/*

    for (var item in idQuisionerDetail) {
      print("ini item :$item");
    }

    for (var item in listJawaban) {
      print("ini jwaban :$item");
    }
*/

    params.putIfAbsent('IDQUISIONERDETAIL', () => idQuisionerDetail);
    params.putIfAbsent('JAWABAN', () => listJawaban);

    for (var item in assets) {
      idFormDetails.add(item.form.id);
      List<MultipartFile> files = [];
      var formName = '';
      for (var file in item.result) {
        files.add(MultipartFile.fromFileSync(file.path));
        formName = file.formName;
      }
      params.putIfAbsent(formName, () => files);
    }

    for (var item in document) {
      idFormDetails.add(item.form.id);
      List<MultipartFile> files = [];
      var formName = '';
      for (var file in item.result) {
        files.add(MultipartFile.fromFileSync(file.path));
        formName = file.formName;
      }
      params.putIfAbsent(formName, () => files);
    }

    var param = FormData.fromMap(params);

    var time = Timer.periodic(Duration(seconds: 1), (timer) {});

    var result = await config(AppType.survey).post(url,
        data: param, options: options, onSendProgress: (send, total) {
      print("send data :$send of $total");
    }).onError((error, stackTrace) {
      print('ini error :$error');
      return null;
    });

/*    for (var item in param.fields) {
      print("ini key :${item.key}");
      print("ini value :${item.value}");
    }*/

    if (result.data != null) {
      var finalResult =
          result != null ? APIResponse.fromJson(result.data) : null;
      if (finalResult != null) {
        finalResult.copyWith(processTimeInSecond: time.tick);
        time.cancel();
      }
      return finalResult;
    } else {
      return null;
    }
  }

  static Future<List<QuisionerItem>> getQuisioner() async {
    var url = 'api/quisioner';
    var options = await _getDioOptions(contentType: contentType.json);

    var result = await config(AppType.survey)
        .get(url, options: options)
        .onError((error, stackTrace) => null);

/*    var result =  Dummy.quisioner;
    if (result != null) {
      var finalResult =
      result != null ? QuisionerResponse.fromJson(result) : null;
      print(result);
      return finalResult != null ? finalResult.data : null;
    } else {
      return null;
    }*/

    if (result.data != null) {
      var finalResult =
          result != null ? QuisionerResponse.fromJson(result.data) : null;
      return finalResult != null ? finalResult.data : null;
    } else {
      return null;
    }
  }

  static Future<List<FormUploadItem>> getFormUpload() async {
    var url = 'api/formupload';
    var options = await _getDioOptions(contentType: contentType.json);

    var result = await config(AppType.survey)
        .get(url, options: options)
        .onError((error, stackTrace) => null);

/*    var result =  Dummy.formUpload;
    if (result != null) {
      var finalResult =
      result != null ? FormUploadResponse.fromJson(result) : null;
      print(result);
      return finalResult != null ? finalResult.data : null;
    } else {
      return null;
    }*/

    if (result.data != null) {
      var finalResult =
          result != null ? FormUploadResponse.fromJson(result.data) : null;
      return finalResult != null ? finalResult.data : null;
    } else {
      return null;
    }
  }

  static Future<List<ZipCodeItem>> getZipCode() async {
    var url = 'api/zipcode';
    var options = await _getDioOptions(contentType: contentType.json);

    var result = await config(AppType.survey)
        .get(url, options: options)
        .onError((error, stackTrace) => null);

    /*  var result =  Dummy.zipcode;
    if (result != null) {
      var finalResult =
      result != null ? ZipCodeResponse.fromJson(result) : null;
      print(result);
      return finalResult != null ? finalResult.data : null;
    } else {
      return null;
    }*/

    if (result.data != null) {
      var finalResult =
          result != null ? ZipCodeResponse.fromJson(result.data) : null;
      print("final result ${finalResult.data.length}");
      return finalResult != null ? finalResult.data : null;
    } else {
      return null;
    }
  }

  static Future<ConfigurationModel> checkUpdate() async {
    var url = 'api/pembaruan';
    var options = await _getDioOptions(contentType: contentType.json);

    var result = await config(AppType.survey)
        .get(url, options: options)
        .onError((error, stackTrace) => null);

//    var result = Dummy.config;

    /* if (result != null) {
      var finalResult =
      result != null ? ConfigurationModel.fromJson(result) : null;
      print(result);
      return finalResult;
    } else {
      return null;
    }*/

    if (result != null) {
      var finalResult =
          result != null ? ConfigurationModel.fromJson(result.data) : null;
      return finalResult;
    } else {
      return null;
    }
  }
}
