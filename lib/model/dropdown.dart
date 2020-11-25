import 'package:mobilesurvey/utilities/parse_utils.dart';

class SearchModel {
  final String title;
  final List<String> itemList;
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