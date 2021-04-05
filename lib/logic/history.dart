import 'package:mobx/mobx.dart';

part 'history.g.dart';

class HistoryBase = _HistoryLogic with _$HistoryBase;

abstract class _HistoryLogic with Store {
  @action
  void onSelectedItem() {
    print("selected Item");
  }

  @action
  void onMapPress() {
    print("map pressed ");
  }
}
