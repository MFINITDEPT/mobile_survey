import 'package:hive/hive.dart';

part 'zipcode_item.g.dart';

@HiveType(typeId: 2)
class ZipCodeItem {
  @HiveField(0)
  final int sysZipId;
  @HiveField(1)
  final String kota;
  @HiveField(2)
  final String kecamatan;
  @HiveField(3)
  final String kelurahan;
  @HiveField(4)
  final String kodePos;
  @HiveField(5)
  final String areaTagih;

  ZipCodeItem(
      {this.sysZipId,
      this.kota,
      this.kecamatan,
      this.kelurahan,
      this.kodePos,
      this.areaTagih});

  factory ZipCodeItem.fromJson(Map<String, dynamic> json) {
    return ZipCodeItem(
        sysZipId: json.containsKey('sysZipid') ? json['sysZipid'] : null,
        kota: json.containsKey('kota') ? json['kota'] : null,
        kecamatan: json.containsKey('kecamatan') ? json['kecamatan'] : null,
        kelurahan: json.containsKey('kelurahan') ? json['kelurahan'] : null,
        kodePos: json.containsKey('kodepos') ? json['kodepos'] : null,
        areaTagih: json.containsKey('areatagih') ? json['areatagih'] : null);
  }
}
