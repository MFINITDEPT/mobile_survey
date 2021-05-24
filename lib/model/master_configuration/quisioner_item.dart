import 'package:hive/hive.dart';

part 'quisioner_item.g.dart';

@HiveType(typeId: 1)
class QuisionerItem {
  @HiveField(0)
  final String id;
  @HiveField(1)
  final String idQuisioner;
  @HiveField(2)
  final String idPertanyaan;
  @HiveField(3)
  final String pertanyaan;
  @HiveField(4)
  final int questionTypeFlag;
  @HiveField(5)
  final String creDate;
  @HiveField(6)
  final String creBy;
  @HiveField(7)
  final String modDate;
  @HiveField(8)
  final String modBy;


  QuisionerItem(
      {this.id,
      this.idQuisioner,
      this.idPertanyaan,
      this.pertanyaan,
      this.questionTypeFlag,
      this.creDate,
      this.creBy,
      this.modDate,
      this.modBy});

  factory QuisionerItem.fromJson(Map<String, dynamic> json) {
    return QuisionerItem(
        id: json.containsKey('id') ? json['id'] : null,
        idQuisioner:
            json.containsKey('idquisioner') ? json['idquisioner'] : null,
        idPertanyaan:
            json.containsKey('idpertanyaan') ? json['idpertanyaan'] : null,
        pertanyaan: json.containsKey('pertanyaan')
            ? json['pertanyaan']
            : null,
        questionTypeFlag: json.containsKey('questionTypeFlag')
            ? json['questionTypeFlag']
            : null,
        creDate: json.containsKey('credate') ? json['credate'] : null,
        creBy: json.containsKey('creby') ? json['creby'] : null,
        modDate: json.containsKey('moddate') ? json['moddate'] : null,
        modBy: json.containsKey('modby') ? json['modby'] : null);
  }
}
