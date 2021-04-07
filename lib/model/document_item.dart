import 'package:hive/hive.dart';

part 'document_item.g.dart';

// ignore: public_member_api_docs
@HiveType(typeId: 5)
class DocumentItem {
  @HiveField(0)
  String path;
  @HiveField(1)
  DateTime dateTime;

  DocumentItem({this.path, this.dateTime});
}
