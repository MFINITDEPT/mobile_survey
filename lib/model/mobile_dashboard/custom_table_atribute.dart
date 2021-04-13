// ignore: public_member_api_docs
import 'package:mobilesurvey/component/custom_data_table.dart';

// ignore: public_member_api_docs
class CustomTableAttribut {
  final List<dynamic> headerColoumn;
  final List<List<CellProperty>> cells;
  final List<CellProperty> leftContent;
  final CellProperty headerLeftContent;
  final String branchName;

  // ignore: public_member_api_docs
  CustomTableAttribut(
      {this.headerColoumn,
        this.cells,
        this.leftContent,
        this.branchName,
        this.headerLeftContent});
}
