import 'package:mobilesurvey/utilities/parse_utils.dart';
import 'package:hive/hive.dart';

part 'zipcode.g.dart';

@HiveType()
class ZipCodeModel {
  @HiveField(0)
  final String kota;
  @HiveField(1)
  final String kecamatan;
  @HiveField(2)
  final String kelurahan;
  @HiveField(3)
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

  Map<String, dynamic> toJson() {
    return {
      "Kota": this.kota,
      "Kecamatan": this.kecamatan,
      "Kelurahan": this.kelurahan,
      "KodePos": this.kodePos
    };
  }
}
