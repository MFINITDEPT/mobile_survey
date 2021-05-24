import 'package:mobilesurvey/repositories/master.dart';
import 'package:mobx/mobx.dart';

part 'task.g.dart';

class TaskBase = _TaskLogic with _$TaskBase;

abstract class _TaskLogic with Store {
  final _dispose = autorun((_) {
    MasterRepositories.getAssetsPhoto();
    MasterRepositories.getDocumentPhoto();
  });

}
