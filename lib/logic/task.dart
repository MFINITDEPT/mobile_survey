import 'package:mobx/mobx.dart';

import '../repositories/master.dart';

part 'task.g.dart';

// ignore: public_member_api_docs
class TaskBase = _TaskLogic with _$TaskBase;

abstract class _TaskLogic with Store {
  final _dispose = autorun((_) {
    MasterRepositories.getAssetsPhoto();
    MasterRepositories.getDocumentPhoto();
  });

}
