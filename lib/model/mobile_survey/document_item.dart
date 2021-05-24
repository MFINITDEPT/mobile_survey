import 'package:hive/hive.dart';

part 'document_item.g.dart';

@HiveType(typeId: 3)
class DocumentItem {
  @HiveField(0)
  String path;
  @HiveField(1)
  DateTime dateTime;
  @HiveField(2)
  String formId;

  DocumentItem({this.path, this.dateTime, this.formId});
}
