import 'package:mobilesurvey/component/new_setup/new_setup.dart';
import 'package:mobx/mobx.dart';

part 'new_setup.g.dart';

// ignore: public_member_api_docs
class NewSetupBase = _NewSetupLogic with _$NewSetupBase;

abstract class _NewSetupLogic with Store {
  @observable
  Status status = Status.loading;

  @action
  // ignore: avoid_setters_without_getters
  set changeStatus(Status newStatus) {
    status = newStatus;
  }
}
