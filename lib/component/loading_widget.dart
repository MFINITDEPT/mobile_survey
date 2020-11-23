import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:mobilesurvey/logic/loading.dart';

class LoadingWidget extends StatefulWidget {
  final Widget child;
  final Widget loadingWidget;
  final Loading loading;
  static Widget defaultLoading;

  const LoadingWidget({Key key, this.child, this.loadingWidget, this.loading})
      : super(key: key);

  @override
  _LoadingWidgetState createState() => _LoadingWidgetState();
}

class _LoadingWidgetState extends State<LoadingWidget> {
  Loading _loading;
  Widget _defaultLoadingWidget;

  @override
  void initState() {
    _loading = widget.loading;
    _defaultLoadingWidget =
        LoadingWidget.defaultLoading ?? CircularProgressIndicator();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        child: Observer(
            builder: (_) => _loading.isLoading
                ? Stack(
                    children: [
                      AbsorbPointer(child: widget.child),
                      Positioned.fill(
                          child: Container(
                        child: Center(
                            child: Material(
                                color: Colors.transparent,
                                child: widget.loadingWidget ??
                                    _defaultLoadingWidget)),
                        color: Colors.black.withOpacity(0.3),
                      ))
                    ],
                  )
                : widget.child),
        onWillPop: _loading.canPopLoading);
  }
}
