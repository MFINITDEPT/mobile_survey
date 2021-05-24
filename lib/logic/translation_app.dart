import 'package:flutter/foundation.dart';
import '../utilities/translation.dart';

class TranslationApp with ChangeNotifier {
  void onLocaleChange() {
    notifyListeners();
  }

  void setOnLocaleChange() {
    if (translation.onLocalChanged == null) {
      translation.onLocalChangedCallback = onLocaleChange;
    }
  }
}
