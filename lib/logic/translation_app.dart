import 'package:flutter/foundation.dart';
import '../utilities/translation.dart';

// ignore: public_member_api_docs
class TranslationApp with ChangeNotifier {
  // ignore: public_member_api_docs
  void onLocaleChange() {
    notifyListeners();
  }

  // ignore: public_member_api_docs
  void setOnLocaleChange() {
    if (translation.onLocalChanged == null) {
      translation.onLocalChangedCallback = onLocaleChange;
    }
  }
}
