import 'package:hive/hive.dart';

part 'document_item.g.dart';

@HiveType(typeId: 3)
class DocumentItem {
  @HiveField(0)
  String path;
  @HiveField(1)
  DateTime dateTime;
  @HiveField(2)
  String idFormDetail;
  @HiveField(3)
  String formName;

  DocumentItem({this.path, this.dateTime, this.idFormDetail, this.formName});
}
