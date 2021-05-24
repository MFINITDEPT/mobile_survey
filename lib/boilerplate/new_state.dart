import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../component/loading_widget.dart';
import '../logic/loading.dart';
import '../logic/translation_app.dart';
import '../utilities/palette.dart';

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
