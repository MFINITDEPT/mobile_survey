import 'package:mobx/mobx.dart';

part 'loading.g.dart';

class Loading = _Loading with _$Loading;

abstract class _Loading with Store {
  @observable
  bool isLoading = false;

  @action
  Future<bool> canPopLoading() async {
    return !isLoading;
  }

  @action
  Future<void> process(Function f) async {
    _setLoading = true;
    await f();
    _setLoading = false;
  }

  set _setLoading(bool newFlag) => isLoading = newFlag;
}
