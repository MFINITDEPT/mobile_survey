import 'package:mobilesurvey/utilities/api_request.dart';
import 'package:mobx/mobx.dart';
import 'package:url_launcher/url_launcher.dart';

part 'history.g.dart';

class HistoryBase = _HistoryLogic with _$HistoryBase;

abstract class _HistoryLogic with Store {
  @action
  void onSelectedItem() {
    APIRequest.testMultipart().then((value) => print(value));
    print("selected Item");
  }

  @action
  Future<void> onMapPress() async {
    final url =
        'https://www.google.com/maps/search/?api=1&query=-6.173110,106.829361';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }
}
