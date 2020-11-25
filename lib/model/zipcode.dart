import 'package:mobilesurvey/utilities/parse_utils.dart';

class ZipCodeModel {
  final String kota;
  final String kecamatan;
  final String kelurahan;
  final String kodePos;

  ZipCodeModel({this.kota, this.kecamatan, this.kelurahan, this.kodePos});

  factory ZipCodeModel.fromJson(Map<String, dynamic> json) {
    return ZipCodeModel(
        kota: json.containsKey('Kota')
            ? ParseUtils.castString(json['Kota'])
            : null,
        kecamatan: json.containsKey('Kecamatan')
            ? ParseUtils.castString(json['Kecamatan'])
            : null,
        kelurahan: json.containsKey('Kelurahan')
            ? ParseUtils.castString(json['Kelurahan'])
            : null,
        kodePos: json.containsKey('KodePos')
            ? ParseUtils.castString(json['KodePos'])
            : null);
  }
}
