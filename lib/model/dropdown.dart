import 'package:hive/hive.dart';
import 'package:mobilesurvey/utilities/parse_utils.dart';

part 'dropdown.g.dart';

@HiveType(typeId: 4)
class SearchModel {
  @HiveField(0)
  final String title;
  @HiveField(1)
  final List<String> itemList;
  @HiveField(2)
  String value;

  SearchModel({this.title, this.itemList, this.value,});

  factory SearchModel.fromJson(Map json) {
    return SearchModel(
        title: ParseUtils.castString(json["title"]),
        itemList: ParseUtils.castList(json["itemList"]),
        value: ParseUtils.castString(json["value"])
    );
  }

  @override
  String toString() {
    return "$runtimeType\n"
        "title: $title, "
        "itemList: $itemList, "
        "value: $value";
  }

  Map<String, dynamic> toMap() {
    return {
      "title": title,
      "itemList": itemList,
      "value": value,
    };
  }
}