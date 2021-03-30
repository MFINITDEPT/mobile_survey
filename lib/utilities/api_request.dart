import 'dart:convert';
import 'dart:io';

import 'package:dio/adapter.dart';
import 'package:dio/dio.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:mobilesurvey/model/ao.dart';
import 'package:mobilesurvey/model/configuration.dart';
import 'package:mobilesurvey/model/nik_data.dart';
import 'package:mobilesurvey/model/photo_form.dart';
import 'package:mobilesurvey/model/quisioner.dart';
import 'package:mobilesurvey/model/zipcode.dart';
import 'package:mobilesurvey/repositories/master.dart';
import 'package:mobilesurvey/utilities/string_utils.dart';
import 'package:ridjnaelcrypt/ridjnaelcrypt.dart';

import 'enum.dart';

class APIRequest {
  static Dio _dio = config();
  static String _url = "https://ver-itrack.mncfinance.net/";
//  static String _urldev = "https://ver-itrack.mncfinance.net/api/master/";
 // static String _urldev = "https://10.1.80.83:45456/api/master/";
 // static String _urldev = "https://siapi.mncfinance.net/";
  static String _urldev = "https://10.1.80.83:45456/api/master/";
//  static String _urldev = "http://172.31.9.104:9993/api/master/";

  static Dio config() {
    Dio _newDio = new Dio();
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
    String token = await _getBearerToken();
    return {"Authorization": 'Bearer $token'};
  }

  static Future<String> _getBearerToken() async {
    Options options = Options();

   /* Map<String, dynamic> param = {
      'grant_type': 'client_credentials',
      'client_id': 4,
      'client_secret': 'OaKIwQydNdp5VSqvMGsK5tlLCQrqx5UArdae8NX0',
      'scope': '*'
    };*/

    Map<String, dynamic> param = {
      'grant_type': 'client_credentials',
      'client_id': 7,
      'client_secret': 'nYB9WGbL93ziYKiCT8cq4Wk2FlmAFya1KzxR5fdK',
      'scope': '*'
    };

    String url = "http://202.147.193.199:8989/o2svr/public/oauth/token";
    options..contentType = StringUtils.getContentType(contentType.urlEncoded);

    var result = await _dio
        .post<dynamic>(url, data: param, options: options)
        .catchError((error) {
      return null;
    });

    return result == null ? _getBearerToken() : result?.data["access_token"];
  }

/*  static Future<dynamic> testPlat() async {
    Options options = await _getDioOptions(contentType: contentType.html);

   // var param = Ridjnael.computeEncrypt('{"nik":"$nik"}');

    String url = _urldev + "master/plat";

    var result = await _dio
        .get<dynamic>(url, options: options)
        .catchError((error) {
      return null;
    });

    Ridjnael.setKey = "V;PpdgX!3i57C%~xix32NAJr`cltV#<Q-A%ORIWzr6/EK8.tg<H}t6/cTB0RxRn";
    Ridjnael.setIv = "*%Tz.4y/<p@tT^?qG@jItEi<;8yrMf50_d,!+K:C:!rS*DX?SdqRUI6EsJo!wW;";

    var we = Ridjnael.computeDecrypt(result.data);
    print(we);
    var res = result != null ? NikDataModel.fromJson(result.data['ct']) : null;
    return we;
  }*/

  static Future<NikDataModel> getNikEncrypt(String nik) async {
    Options options = await _getDioOptions(contentType: contentType.html);

    var param = Ridjnael.computeEncrypt('{"nik":"$nik"}');

    String url = "https://api-itrack.mncfinance.net/StagingToDukcapil/Index";

    var result = await _dio
        .post<dynamic>(url, data: param, options: options)
        .catchError((error) {
      return null;
    });

    var res = result != null ? NikDataModel.fromJson(result.data['ct']) : null;
    return res;
  }

  static Future<List<QuisionerModel>> masterQuisioner() async {
    Options options = await _getDioOptions(contentType: contentType.json);

    String url = _urldev + "Quisioner";

    var result =
        await _dio.get<dynamic>(url, options: options).catchError((error) {
      print("$url Error");
      return null;
    });

    List<QuisionerModel> res = [];
    if (result.data != null) {
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
      Fluttertoast.showToast(
          msg: error.toString(),
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          fontSize: 16.0);
      print("$url Error");
      return null;
    });

    List<ZipCodeModel> res = [];
    if (result.data != null) {
      var list = List.from(result.data);
      list.forEach((element) => res.add(ZipCodeModel.fromJson(element)));
    }

    return result.data != null ? res : null;
  }

  static Future<ConfigurationModel> getConfiguration() async {
    Options options = await _getDioOptions(contentType: contentType.json);

    String url = _urldev + "configuration";

    var result =
        await _dio.get<dynamic>(url, options: options).catchError((error) {
      print("$url Error");
      return null;
    });

    var res = result != null ? ConfigurationModel.fromJson(result.data) : null;

    return res;
  }

  static Future<List<AoModel>> masterAo() async {
    Options options = await _getDioOptions(contentType: contentType.json);

    String url = _urldev + "ao";

    var result =
        await _dio.get<dynamic>(url, options: options).catchError((error) {
      print("$url Error");
      return null;
    });

    List<AoModel> res = [];
    if (result.data != null) {
      var list = List.from(result.data);
      list.forEach((element) => res.add(AoModel.fromJson(element)));
    }
    return res;
  }

  static Future<dynamic> getFotoForm(int id) async {
    Options options = await _getDioOptions(contentType: contentType.json);

    String url = _urldev + 'getFotoForm';
    Map<String, int> params = Map<String, int>()..putIfAbsent("id", () => id);
    var result = await _dio
        .get<dynamic>(url, options: options, queryParameters: params)
        .catchError((error) {
      print("$url Error");
      return null;
    });

    List<PhotoForm> res = [];
    if (result.data != null) {
      var list = List.from(result.data);
      list.forEach((element) => res.add(PhotoForm.fromJson(element)));
    }

    return res;
  }

  static Future<dynamic> checkDuplicateName(String name) async {
    Options options = await _getDioOptions(contentType: contentType.json);

//    String url = "https://ver-itrack.mncfinance.net/api/validate/" + "checkNameExisting";
    String url =
        "https://ver-itrack.mncfinance.net/api/validate/" + "checkNameExisting";

    Map<String, dynamic> param = {'Name': name};

    var result = await _dio
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
    Options options = await _getDioOptions(contentType: contentType.json);

    String url = "https://ver-itrack.mncfinance.net/api/process/" +
        "insertclientintomsix";

    Map<String, dynamic> param = {};
    param.putIfAbsent("c_code", () => "050");
    param.putIfAbsent("name", () => name);
    param.putIfAbsent("real_name", () => name);
    param.putIfAbsent("salute1", () => prefixSalute);
    param.putIfAbsent("salute1p", () => prefixSalute);
    param.putIfAbsent("salute2p", () => suffixSalute);
    param.putIfAbsent("status", () => 1);
    param.putIfAbsent("address1", () => address1);
    param.putIfAbsent("address2", () => address2);
    param.putIfAbsent("address3", () => address3);
    param.putIfAbsent("kecamatan", () => village);
    param.putIfAbsent("kelurahan", () => district);
    param.putIfAbsent("area_code", () => zipcode);
    param.putIfAbsent("phone", () => phoneNo);
    param.putIfAbsent("fax", () => fax == '' ? null : fax);
    param.putIfAbsent(
        "ao",
        () => MasterRepositories.ao
            .firstWhere((element) => element.descs == ao)
            .code);
    param.putIfAbsent("wlist", () => "0");
    param.putIfAbsent("collateral", () => "0");
    param.putIfAbsent("cre_date", () => DateTime.now().toString());
    param.putIfAbsent("cre_by", () => "1911806");
    param.putIfAbsent("cre_ip_address", () => "172.31.9.3");
    param.putIfAbsent("mod_date", () => DateTime.now().toString());
    param.putIfAbsent("mod_by", () => "1911806");
    param.putIfAbsent("mod_ip_address", () => "172.31.9.3");
    param.putIfAbsent("kota", () => identityCity);
    param.putIfAbsent("npwp", () => null);
    param.putIfAbsent("area_codes", () => phoneArea);
    param.putIfAbsent("inborndt", () => birthDate.toString());
    param.putIfAbsent("inbornplc", () => birthLocation);
    param.putIfAbsent("ibukandung", () => motherName);
    param.putIfAbsent("inmailtelp", () => handphoneNo);
    param.putIfAbsent("inktp", () => identityNo);
    param.putIfAbsent("ineffktp", () => validOf.toString());
    param.putIfAbsent("inexpktp", () => expiredOf.toString());
    param.putIfAbsent("kota_terbit_ktp", () => identityCity);
    param.putIfAbsent("rt", () => rt);
    param.putIfAbsent("rw", () => rw);

    var result = await _dio
        .post<dynamic>(url, options: options, data: param)
        .catchError((error) {
      return null;
    });

    return result.data;
  }
}
