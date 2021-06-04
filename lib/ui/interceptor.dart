import 'package:flutter/material.dart';
import 'package:mobilesurvey/component/new_setup/new_setup.dart';
import 'package:mobilesurvey/utilities/api_request.dart';

enum AppType { survey, collection, dashboard, approval }

class InterceptorPageUI extends StatefulWidget {
  final AppType appType;

  InterceptorPageUI({@required this.appType});

  @override
  _InterceptorPageUIState createState() => _InterceptorPageUIState();
}

class _InterceptorPageUIState extends State<InterceptorPageUI> {
  final NewSetupController _controller = NewSetupController();
  var _config;
  var _apiRequest = [];

  @override
  void initState() {
    setUpFetcher();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return NewSetup(
        newSetupController: _controller,
        config: _config,
        fetchData: _apiRequest,
        appType: widget.appType);
  }

  void setUpFetcher() {
    APIRequest.appType = widget.appType;
    switch (widget.appType) {
      case AppType.survey:
        _config = APIRequest.checkUpdate;
//        _apiRequest.add(APIRequest.getZipCode);
        _apiRequest.add(APIRequest.getQuisioner);
        _apiRequest.add(APIRequest.getFormUpload);
        break;
      case AppType.collection:
        _config = APIRequest.checkUpdate;
//        _apiRequest.add(APIRequest.masterQuisioner);
//        _apiRequest.add(APIRequest.masterQuisioner);
//        _apiRequest.add(APIRequest.masterQuisioner);
        break;
      case AppType.dashboard:
        break;
      case AppType.approval:
        _config = APIRequest.checkUpdate;
//        _apiRequest.add(APIRequest.masterQuisioner);
//        _apiRequest.add(APIRequest.masterQuisioner);
//        _apiRequest.add(APIRequest.masterQuisioner);
        break;
    }
  }
}
