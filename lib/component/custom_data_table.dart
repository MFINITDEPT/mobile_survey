import 'package:basic_components/components/adv_column.dart';
import 'package:basic_components/components/adv_row.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:mobilesurvey/utilities/palette.dart';

// ignore: public_member_api_docs
class CustomTable extends StatefulWidget {
  final List<dynamic> headerColoumn;
  final List<CellProperty> leftContent;
  final CellProperty headerLeftContent;
  final List<TableRow> cell;
  final List<List<CellProperty>> cells;
  final double textSize;
  final double cellWidth;
  final double cellHeight;
  final bool centerHeader;
  final Color headerColor;
  final Alignment alignment;
  final bool isParentSliver;
  final double leftHeaderAndLeftContentScale;

  // ignore: public_member_api_docs
  const CustomTable(
      {Key key,
      this.headerColoumn,
      this.cell,
      this.cellWidth = 100.0,
      this.centerHeader,
      this.headerColor,
      this.cellHeight = 60.0,
      this.leftContent,
      this.headerLeftContent,
      this.cells,
      this.alignment,
      this.isParentSliver,
      this.leftHeaderAndLeftContentScale,
      this.textSize})
      : super(key: key);

  @override
  _customTableState createState() => _customTableState();
}

// ignore: camel_case_types
class _customTableState extends State<CustomTable> {
  List<TableRow> _tableCell = [];
  int _maxLength = 0;
  bool _centerHeader;
  final _columnController = ScrollController();
  final _subTableYController = ScrollController();

  Widget _row;
  double _cellwidth;
  double _cellheight;
  double _leftHeaderAndLeftContentScale = 0.75;
  double _textSize = 14.0;
  bool _containsColumn = false;
  bool _isSliverParent;

  CellProperty _headerLeftContent;
  List<TableRow> _leftContent = [];

  //* DataTable states
  List<int> _fixedCellIndexList = [];
  List<DataColumn> _mainHeaderDateList = [];
  List<DataColumn> _mainHeaderList = [];

  @override
  void initState() {
    if (widget.leftHeaderAndLeftContentScale != null)
      _leftHeaderAndLeftContentScale = widget.leftHeaderAndLeftContentScale;
    if (widget.textSize != null) _textSize = widget.textSize;
    _cellwidth = widget.cellWidth;
    _cellheight = widget.cellHeight;
    _headerLeftContent = widget.headerLeftContent;
    _centerHeader = widget.centerHeader ?? false;
    _isSliverParent = widget.isParentSliver ?? false;
    List<Widget> _finalChildren = [];
    assert(widget.headerColoumn != null || widget.headerColoumn.length != 0);
    widget.headerColoumn.forEach((i) {
      assert(i is ColumnTable || i is CellProperty);
      List<Widget> _columnChildren = [];
      if (i is ColumnTable) {
        _containsColumn = true;
        int divider = 0;
        i.children.forEach((x) {
          assert(x is RowTable || x is CellProperty);
          List<Widget> _children = [];
          if (x is RowTable) {
            x.children.forEach((y) {
              assert(y is CellProperty);
              divider++;
              _maxLength++;
              var _y = _centerHeader
                  ? Center(
                      child: Text(y.text,
                          textAlign: TextAlign.center,
                          style: TextStyle(fontSize: _textSize)))
                  : Text(y.text, style: TextStyle(fontSize: _textSize));
              _children.add(Container(
                width: _cellwidth - 1,
                height: _cellheight,
                child: _y,
                /*color: y.color*/
              ));
            });
            _columnChildren.add(IntrinsicHeight(
                child: AdvRow(
                    divider: VerticalDivider(
                        width: 1, thickness: 1, color: Colors.black),
                    children: _children)));
          } else if (x is CellProperty) {
            _columnChildren.add(Container(
              child: Center(
                  child: Text(x.text,
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: _textSize))),
              height: _cellheight,
              width: _cellwidth * i.children.length,
              /*color: x.color*/
            ));
          }
        });
        _finalChildren.add(AdvColumn(
            children: _columnChildren,
            divider: Container(
                color: Colors.black,
                width: (divider * _cellwidth),
                height: 1)));
      } else {
        _maxLength++;
        var _i = _centerHeader
            ? Center(child: Text(i.text, style: TextStyle(fontSize: _textSize)))
            : Text(i.text, style: TextStyle(fontSize: _textSize));
        _finalChildren.add(Container(
          width: _cellwidth - 1,
          height: _containsColumn ? (_cellheight * 2) : _cellheight,
          child: _i,
          /*color: i.color*/
        ));
      }
      _row = Container(
          color: widget.headerColor,
          child: IntrinsicHeight(
              child: AdvRow(
                  divider: VerticalDivider(
                      width: 1, thickness: 1, color: Colors.black),
                  children: _finalChildren)));
    });

    for (CellProperty cell in widget.leftContent) {
      _leftContent.add(TableRow(children: <Widget>[
        _singleCell(cell.text, color: cell.color, isBold: cell.isBold ?? false)
      ]));
    }

    assert(widget.leftContent.length == widget.cells.length);
    for (var a in widget.cells) {
      assert(_maxLength == a.length);
      List<Widget> _rowCell = [];
      a.forEach((item) {
        _rowCell.add(_singleCell(item.text,
            color: item.color,
            alignment: widget.alignment,
            isBold: item.isBold ?? false));
      });
      _tableCell.add(TableRow(children: _rowCell));
    }

    //* initState for DataTable
    _fixedCellIndexList =
        Iterable<int>.generate(widget.leftContent.length).toList();
    widget.headerColoumn.forEach((header) {
      if (header.runtimeType != CellProperty) {
        _mainHeaderDateList.add(DataColumn(
          label: Expanded(
            child: Align(
              alignment: Alignment.center,
              child: Text(
                header.children[0].text,
                style: TextStyle(
                  fontSize: 15,
                ),
              ),
            ),
          ),
        ));
        header.children[1].children.forEach((item) {
          _mainHeaderList.add(DataColumn(
            label: Expanded(
              child: Align(
                alignment: Alignment.center,
                child: Text(
                  item.text,
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ));
        });
      } else {
        _mainHeaderList.add(DataColumn(
          label: Expanded(
            child: Align(
              alignment: Alignment.center,
              child: Text(
                header.text,
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ));
      }
    });

    _subTableYController.addListener(() {
      _columnController.jumpTo(_subTableYController.position.pixels);
    });
    super.initState();
  }

  Widget _singleCell(String text,
      {Color color, Alignment alignment, bool isBold}) {
    return TableCell(
        child: Container(
            padding: EdgeInsets.all(4.0),
            alignment: alignment,
            child: Text(text,
                overflow: TextOverflow.ellipsis,
                maxLines: 2,
                style: TextStyle(
                    fontSize: _textSize,
                    fontWeight: isBold ? FontWeight.bold : null)),
            color: color,
            width: _cellwidth,
            height: _cellheight));
  }

  @override
  void dispose() {
    _subTableYController.dispose();
    _columnController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    //# choose either Table of DataTable manually
    if (_isSliverParent) {
      //* return DataTable builder
      return _buildSliverDataTable();

      //* returns Table builder
//      return _sliverParent();
    } else {
      //* returns DataTable builder
      return _buildDataTable();

      //* returns Table builder
//      return _notSliverParent();
    }
  }

  // DataTable widget builders
  Widget _buildDataTable() {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(18)),
        border: Border.all(color: Palette.mnc),
      ),
      padding: EdgeInsets.all(6),
      margin: EdgeInsets.symmetric(
        horizontal: 16,
      ),
      height: MediaQuery.of(context).size.height * 0.7,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Expanded(
            flex: 1,
            child: Column(
              children: <Widget>[
                Flexible(
                  fit: FlexFit.loose,
                  flex: 2,
                  child: DataTable(
                    headingRowHeight: MediaQuery.of(context).size.height * 0.19,
                    dataRowHeight: 0,
                    dividerThickness: 0,
                    columns: [
                      DataColumn(
                        label: Expanded(
                          child: Align(
                            alignment: Alignment.center,
                            child: Text(
                              widget.headerLeftContent.text,
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                    rows: [
                      DataRow(
                        cells: [
                          DataCell.empty,
                        ],
                      ),
                    ],
                  ),
                ),
                Expanded(
                  flex: 4,
                  child: SingleChildScrollView(
                    physics: NeverScrollableScrollPhysics(),
                    controller: _columnController,
                    child: DataTable(
                      headingRowHeight: 0,
                      columns: [
                        DataColumn(
                          label: Container(),
                        ),
                      ],
                      rows: _fixedCellIndexList.map((index) {
                        return DataRow(
                          cells: [
                            DataCell(
                              Text(
                                widget.leftContent[index].text,
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ],
                        );
                      }).toList(),
                    ),
                  ),
                )
              ],
            ),
          ),
          Expanded(
            flex: 3,
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Flexible(
                    fit: FlexFit.loose,
                    flex: 2,
                    child: SingleChildScrollView(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          DataTable(
                            dataRowHeight: 0,
                            dividerThickness: 0,
                            headingRowHeight:
                                MediaQuery.of(context).size.height * 0.08,
                            columns: _mainHeaderDateList,
                            rows: [
                              DataRow(
                                cells: List<DataCell>.generate(
                                    _mainHeaderDateList.length, (index) {
                                  return DataCell(Container(
                                    width: MediaQuery.of(context).size.width *
                                        0.584,
                                  ));
                                }),
                              ),
                            ],
                          ),
                          DataTable(
                            dataRowHeight: 0,
                            dividerThickness: 0,
                            headingRowHeight:
                                MediaQuery.of(context).size.height * 0.08,
                            columnSpacing:
                                MediaQuery.of(context).size.width * 0.08,
                            columns: _mainHeaderList,
                            rows: [
                              DataRow(
                                cells: _mainHeaderList.map((_) {
                                  return DataCell(
                                    Container(
                                      width: MediaQuery.of(context).size.width *
                                          0.14,
                                    ),
                                  );
                                }).toList(),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 4,
                    child: SingleChildScrollView(
                      controller: _subTableYController,
                      scrollDirection: Axis.vertical,
                      child: DataTable(
                        headingRowHeight: 0,
                        columnSpacing: MediaQuery.of(context).size.width * 0.08,
                        columns: _mainHeaderList.map((header) {
                          return DataColumn(
                            label: Container(),
                          );
                        }).toList(),
                        rows: _fixedCellIndexList.map((index) {
                          return DataRow(
                            cells: widget.cells[index].map((cell) {
                              return DataCell(
                                Container(
                                  alignment: Alignment.center,
                                  width:
                                      MediaQuery.of(context).size.width * 0.14,
                                  height: MediaQuery.of(context).size.height *
                                      0.082,
                                  padding: EdgeInsets.all(3),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(9),
                                    color: cell.color ?? Palette.dataCellChip,
                                  ),
                                  child: Text(
                                    cell.text,
                                    textAlign: TextAlign.center,
                                    overflow: TextOverflow.fade,
                                    softWrap: true,
                                  ),
                                ),
                              );
                            }).toList(),
                          );
                        }).toList(),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSliverDataTable() {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(18)),
        border: Border.all(color: Palette.mnc),
      ),
      padding: EdgeInsets.symmetric(
        horizontal: 18,
      ),
      margin: EdgeInsets.symmetric(horizontal: 16, vertical: 9),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Expanded(
                  flex: 2,
                  child:
                      Column(mainAxisSize: MainAxisSize.min, children: <Widget>[
                    Flexible(
                      fit: FlexFit.loose,
                      flex: 2,
                      child: DataTable(
                          dataRowHeight: 0,
                          dividerThickness: 0,
                          columns: [
                            DataColumn(
                              label: Expanded(
                                child: Align(
                                  alignment: Alignment.center,
                                  child: Text(
                                    _headerLeftContent.text,
                                    style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                          rows: [
                            DataRow(
                              cells: [
                                DataCell.empty,
                              ],
                            )
                          ]),
                    ),
                    Expanded(
                      flex: 4,
                      child: SingleChildScrollView(
                        physics: NeverScrollableScrollPhysics(),
                        controller: _columnController,
                        child: DataTable(
                          headingRowHeight: 0,
                          columns: [
                            DataColumn(
                              label: Container(),
                            ),
                          ],
                          rows: _fixedCellIndexList.map((index) {
                            return DataRow(
                              cells: [
                                DataCell(
                                  Text(
                                    widget.leftContent[index].text,
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ],
                            );
                          }).toList(),
                        ),
                      ),
                    ),
                  ]),
                ),
                Expanded(
                  flex: 4,
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Column(
                      children: <Widget>[
                        Flexible(
                          fit: FlexFit.loose,
                          flex: 2,
                          child: widget.leftContent.length > 4
                              ? DataTable(
                                  dataRowHeight: 0,
                                  dividerThickness: 0,
                                  headingRowHeight:
                                      MediaQuery.of(context).size.height * 0.18,
                                  columns: _mainHeaderList,
                                  rows: [
                                      DataRow(
                                        cells: widget.cells[0].map((cell) {
                                          return DataCell(
                                            Container(
                                              width: _cellwidth + 4,
                                            ),
                                          );
                                        }).toList(),
                                      ),
                                    ])
                              : DataTable(
                                  dataRowHeight: 0,
                                  dividerThickness: 0,
                                  columns: _mainHeaderList,
                                  rows: [
                                      DataRow(
                                        cells: widget.cells[0].map((cell) {
                                          return DataCell(
                                            Container(
                                              width: _cellwidth + 4,
                                            ),
                                          );
                                        }).toList(),
                                      ),
                                    ]),
                        ),
                        Expanded(
                          flex: 4,
                          child: SingleChildScrollView(
                            controller: _subTableYController,
                            scrollDirection: Axis.vertical,
                            child: DataTable(
                              headingRowHeight: 0,
                              columns: _mainHeaderList.map((_) {
                                return DataColumn(
                                  label: Container(),
                                );
                              }).toList(),
                              rows: _fixedCellIndexList.map((index) {
                                return DataRow(
                                  cells: widget.cells[index].map((cell) {
                                    return DataCell(
                                      Container(
                                        alignment: Alignment.center,
                                        width: _cellwidth + 4,
                                        height: _cellheight,
                                        padding: EdgeInsets.all(3),
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(9),
                                          color: cell.color ??
                                              Palette.dataCellChip,
                                        ),
                                        child: Text(
                                          cell.text,
                                          style: TextStyle(fontSize: _textSize),
                                          textAlign: TextAlign.center,
                                          overflow: TextOverflow.fade,
                                          softWrap: true,
                                        ),
                                      ),
                                    );
                                  }).toList(),
                                );
                              }).toList(),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // Table widget builders
  Widget _notSliverParent() {
    return Container(
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Container(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Container(
                      color: widget.headerColor,
                      height:
                          _containsColumn ? (_cellheight * 2) + 1 : _cellheight,
                      child:
                          Center(child: Text(_headerLeftContent?.text ?? ""))),
                  Container(height: 1, color: Colors.black),
                  Flexible(
                    child: SingleChildScrollView(
                        child: Table(
                          children: _leftContent,
                          border: TableBorder.symmetric(inside: BorderSide()),
                          defaultColumnWidth: FixedColumnWidth(
                              _cellwidth * _leftHeaderAndLeftContentScale),
                        ),
                        physics: NeverScrollableScrollPhysics(),
                        controller: _columnController),
                  )
                ],
              ),
              width: _cellwidth * _leftHeaderAndLeftContentScale,
              decoration: BoxDecoration(border: Border(right: BorderSide())),
            ),
            Expanded(
                child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  _row ??
                      Container(
                        child: Text(""),
                      ),
                  Container(
                      height: 1,
                      width: (_maxLength * _cellwidth),
                      color: Colors.black),
                  Flexible(
                    child: SingleChildScrollView(
                        child: Table(
                          children: _tableCell,
                          border: TableBorder.symmetric(inside: BorderSide()),
                          defaultColumnWidth: FixedColumnWidth(_cellwidth),
                        ),
                        controller: _subTableYController,
                        scrollDirection: Axis.vertical),
                  )
                ],
              ),
              scrollDirection: Axis.horizontal,
            ))
          ],
        ),
        decoration: BoxDecoration(
          border: Border.all(),
          color: Colors.cyan,
        ));
  }

  Widget _sliverParent() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Expanded(
            child: Container(
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Container(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          Container(
                              color: widget.headerColor,
                              height: _containsColumn
                                  ? (_cellheight * 2) + 1
                                  : _cellheight,
                              child: Center(
                                  child: Text(_headerLeftContent?.text ?? "",
                                      style: TextStyle(fontSize: _textSize)))),
                          Container(height: 1, color: Colors.black),
                          Flexible(
                            child: SingleChildScrollView(
                                child: Table(
                                  children: _leftContent,
                                  border: TableBorder.symmetric(
                                      inside: BorderSide()),
                                  defaultColumnWidth: FixedColumnWidth(
                                      _cellwidth *
                                          _leftHeaderAndLeftContentScale),
                                ),
                                physics: NeverScrollableScrollPhysics(),
                                controller: _columnController),
                          )
                        ],
                      ),
                      width: _cellwidth * _leftHeaderAndLeftContentScale,
                      decoration:
                          BoxDecoration(border: Border(right: BorderSide())),
                    ),
                    Expanded(
                        child: SingleChildScrollView(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          _row ??
                              Container(
                                child: Text(""),
                              ),
                          Container(
                              height: 1,
                              width: (_maxLength * _cellwidth),
                              color: Colors.black),
                          Flexible(
                            child: SingleChildScrollView(
                                child: Table(
                                  children: _tableCell,
                                  border: TableBorder.symmetric(
                                      inside: BorderSide()),
                                  defaultColumnWidth:
                                      FixedColumnWidth(_cellwidth),
                                ),
                                controller: _subTableYController,
                                scrollDirection: Axis.vertical),
                          )
                        ],
                      ),
                      scrollDirection: Axis.horizontal,
                    ))
                  ],
                ),
                decoration:
                    BoxDecoration(border: Border.all(), color: Colors.cyan))),
      ],
    );
  }
}

class CellProperty implements CustomTableChildren {
  final String text;
  final Color color;
  final bool isBold;

  CellProperty(this.text, {this.color, this.isBold});
}

class ColumnTable implements CustomTableChildren {
  final List<CustomTableChildren> children;

  ColumnTable({this.children});
}

class RowTable implements CustomTableChildren {
  final List<CellProperty> children;

  RowTable({this.children});
}

abstract class CustomTableChildren {}
