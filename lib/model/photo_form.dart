import 'package:hive/hive.dart';
import 'package:mobilesurvey/utilities/parse_utils.dart';

part 'photo_form.g.dart';

@HiveType()
class PhotoForm {
  @HiveField(0)
  final String id;
  @HiveField(1)
  final String idForm;
  @HiveField(2)
  final String kode;
  @HiveField(3)
  final String kelengkapan;
  @HiveField(4)
  final String type;
  @HiveField(5)
  final int count;
  @HiveField(6)
  final String createBy;
  @HiveField(7)
  final String createDate;
  @HiveField(8)
  final String modDate;
  @HiveField(9)
  final String modBy;

  PhotoForm(
      {this.id,
      this.idForm,
      this.kode,
      this.kelengkapan,
      this.type,
      this.count,
      this.createBy,
      this.createDate,
      this.modDate,
      this.modBy});

  factory PhotoForm.fromJson(Map json) {
    return PhotoForm(
        id: ParseUtils.castString(json["id"]),
        idForm: ParseUtils.castString(json["idForm"]),
        kode: ParseUtils.castString(json['kode']),
        kelengkapan: ParseUtils.castString(json['kelengkapan']),
        type: ParseUtils.castString(json['type']),
        count: ParseUtils.castInt(json['count']),
        createBy: ParseUtils.castString(json['creby']),
        createDate: ParseUtils.castString(json['credate']),
        modDate: ParseUtils.castString(json['moddate']),
        modBy: ParseUtils.castString(json['modby']));
  }

  @override
  String toString() {
    return "$runtimeType\n"
        "id: $id, "
        "idform: $idForm, "
        "kode: $kode, "
        "kelengkapan : $kelengkapan, "
        "type : $type, "
        "count : $count, "
        "createBy : $createBy,"
        "createDate : $createDate, "
        "modData : $modDate,"
        "modBy : $modBy";
  }

  Map<String, dynamic> toMap() {
    return {
      "id": id,
      "idform": idForm,
      "kode": kode,
      "kelengkapan": kelengkapan,
      "type": type,
      "count": count,
      "credate": createDate,
      "creby": createBy,
      "moddate": modDate,
      "modby": modBy
    };
  }
}
