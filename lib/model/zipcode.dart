import 'package:mobilesurvey/utilities/parse_utils.dart';
import 'package:hive/hive.dart';

part 'zipcode.g.dart';

@HiveType(typeId: 2)
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
        kota: json.containsKey('kota')
            ? ParseUtils.castString(json['kota'])
            : null,
        kecamatan: json.containsKey('kecamatan')
            ? ParseUtils.castString(json['kecamatan'])
            : null,
        kelurahan: json.containsKey('kelurahan')
            ? ParseUtils.castString(json['kelurahan'])
            : null,
        kodePos: json.containsKey('kodePos')
            ? ParseUtils.castString(json['kodePos'])
            : null);
  }

  Map<String, dynamic> toJson() {
    return {
      "kota": this.kota,
      "kecamatan": this.kecamatan,
      "kelurahan": this.kelurahan,
      "kodePos": this.kodePos
    };
  }
}
