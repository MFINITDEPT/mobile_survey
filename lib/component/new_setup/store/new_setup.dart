import 'package:mobilesurvey/component/new_setup/new_setup.dart';
import 'package:mobx/mobx.dart';

part 'new_setup.g.dart';

class NewSetupBase = _NewSetupLogic with _$NewSetupBase;

abstract class _NewSetupLogic with Store {
  @observable
  Status status = Status.loading;

  @action
  Status changeStatus(Status newStatus) => status = newStatus;
}
