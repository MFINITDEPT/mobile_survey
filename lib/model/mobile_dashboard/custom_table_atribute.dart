import 'package:mobilesurvey/component/custom_data_table.dart';

class CustomTableAttribut {
  final List<dynamic> headerColoumn;
  final List<List<CellProperty>> cells;
  final List<CellProperty> leftContent;
  final CellProperty headerLeftContent;
  final String branchName;

  CustomTableAttribut(
      {this.headerColoumn,
        this.cells,
        this.leftContent,
        this.branchName,
        this.headerLeftContent});
}
