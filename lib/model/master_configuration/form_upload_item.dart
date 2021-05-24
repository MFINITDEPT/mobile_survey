import 'package:hive/hive.dart';

part 'form_upload_item.g.dart';

@HiveType(typeId: 0)
class FormUploadItem {
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
  final String formName;
  @HiveField(6)
  final int count;
  @HiveField(7)
  final String creDate;
  @HiveField(8)
  final String creBy;
  @HiveField(9)
  final String modDate;
  @HiveField(10)
  final String modBy;

  FormUploadItem(
      {this.id,
      this.idForm,
      this.kode,
      this.kelengkapan,
      this.type,
      this.formName,
      this.count,
      this.creDate,
      this.creBy,
      this.modDate,
      this.modBy});

  factory FormUploadItem.fromJson(Map<String, dynamic> json) {
    return FormUploadItem(
        id: json.containsKey('id') ? json['id'] : null,
        idForm: json.containsKey('idform') ? json['idform'] : null,
        kode: json.containsKey('kode') ? json['kode'] : null,
        kelengkapan:
            json.containsKey('kelengkapan') ? json['kelengkapan'] : null,
        type: json.containsKey('type') ? json['type'] : null,
        formName: json.containsKey('formname') ? json['formname'] : null,
        count: json.containsKey('count') ? json['count'] : null,
        creDate: json.containsKey('credate') ? json['credate'] : null,
        creBy: json.containsKey('creby') ? json['creby'] : null,
        modDate: json.containsKey('moddate') ? json['moddate'] : null,
        modBy: json.containsKey('modby') ? json['modby'] : null);
  }
}
