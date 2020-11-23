import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mobilesurvey/component/loading_widget.dart';
import 'package:mobilesurvey/logic/loading.dart';
import 'package:mobilesurvey/logic/translation_app.dart';
import 'package:mobilesurvey/utilities/palette.dart';
import 'package:provider/provider.dart';

abstract class NewState<T extends StatefulWidget> extends State<T> {
  final Loading _loading = Loading();

  @override
  Widget build(BuildContext context) {
    return Consumer<TranslationApp>(
      builder: (_, model, child) {
        return LoadingWidget(
          loading: _loading,
          child: buildView(context),
          loadingWidget:
              CircularProgressIndicator(backgroundColor: Palette.red),
        );
      },
    );
  }

  Widget buildView(BuildContext context);

  void process(Function f) {
    _loading.process(f);
  }
}
