import 'package:flutter/material.dart';
import 'package:mobilesurvey/model/mobile_dashboard/branch.dart';
import 'package:mobilesurvey/utilities/palette.dart';

class CollPlayChooserPage extends StatefulWidget {
  final List<BranchModel> data;
  final String title;

  const CollPlayChooserPage(@required this.data, @required this.title,
      {Key key})
      : super(key: key);

  @override
  _collPlayChooserPageState createState() => _collPlayChooserPageState();
}

class _collPlayChooserPageState extends State<CollPlayChooserPage> {
  TextEditingController _searchController;
  List<BranchModel> _allData = [];
  List<BranchModel> _filteredData = [];

  @override
  void initState() {
    _allData = widget.data;
    _filteredData = _allData;
    _searchController = TextEditingController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            title: Text(
          widget.title,
          style: TextStyle(color: Palette.mnc),
        )),
        body: Column(
          children: <Widget>[
            Container(
                margin: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                padding: EdgeInsets.symmetric(horizontal: 8.0),
                decoration: BoxDecoration(border: Border.all()),
                child: TextField(
                    controller: _searchController,
                    onChanged: (onchange) {
                      _filterData();
                    },
                    decoration: InputDecoration(
                        hintText: 'Pencarian...', border: InputBorder.none))),
            Expanded(child: _buildCabangListView())
          ],
        ));
  }

  Widget _buildCabangListView() {
    Widget child;
    if (_filteredData == null) {
      child = Container();
    } else {
      child = ListView.separated(
          itemBuilder: (BuildContext context, int index) {
            return ListTile(
              title: Text(
                _filteredData[index].cName.toLowerCase() == "all"
                    ? "Nasional".toUpperCase()
                    : _filteredData[index].cName.toUpperCase(),
                style: TextStyle(color: Palette.mnc),
              ),
              contentPadding:
                  EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
              onTap: () {
                Navigator.pop(context, _filteredData[index]);
              },
            );
          },
          separatorBuilder: (BuildContext context, int i) {
            return Container(
                height: 1.0,
                margin: EdgeInsets.symmetric(horizontal: 16.0),
                color: Colors.deepOrange);
          },
          itemCount: _filteredData.length);
    }
    return child;
  }

  void _filterData() {
    String search = _searchController.text.toLowerCase() ?? ''.toLowerCase();
    setState(() {
      _filteredData = _allData.where((BranchModel result) {
        return result.cName.toLowerCase().contains(search);
      }).toList();
    });
  }
}
