import 'dart:async';

import 'package:flutter/material.dart';
import 'package:mobilesurvey/logic/translation_app.dart';
import 'package:provider/provider.dart';

typedef Future<void> Fetcher();
typedef Future<void> OnInit(BuildContext context);

enum Status { failed, success, processing, showDialog }

typedef Widget UiBuilder(
    BuildContext context, double processing, String description, Status type);

class Setup extends StatefulWidget {
  final List<NavigatorObserver> observer;
  final ThemeData theme;
  final Iterable<LocalizationsDelegate<dynamic>> localizationsDelegates;
  final Fetcher fetcher;
  final SetupController controller;
  final UiBuilder uiBuilder;
  final int totalApiRequest;

  const Setup(
      {this.observer = const [],
      this.theme,
      this.localizationsDelegates,
      this.fetcher,
      @required this.uiBuilder,
      @required this.totalApiRequest,
      SetupController controller})
      : assert(controller != null),
        this.controller = controller;

  @override
  _SetupState createState() => _SetupState();
}

class _SetupState extends State<Setup> with WidgetsBindingObserver {
  Status statusNow;
  String minVer;
  bool isDataFetched = false;
  bool isRetrieveDynamicLink = false;

  @override
  void initState() {
    widget.controller.addListener(_update);
    widget.controller.setupState = this;
    widget.controller._totalApiRequest = widget.totalApiRequest;

    WidgetsBinding.instance.addPostFrameCallback((_) {
      _getData();
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<TranslationApp>(
      create: (_) => TranslationApp(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        navigatorObservers: widget.observer,
        localizationsDelegates: widget.localizationsDelegates,
        supportedLocales: [
          const Locale('en', 'US'), // English
          const Locale('id', 'ID'), // Hebrew
        ],
        theme: widget.theme,
        home: Builder(builder: (context) {
          Widget uiBuilder;
          uiBuilder = widget.uiBuilder(context, widget.controller.progress,
              widget.controller.description, statusNow);

          return Consumer<TranslationApp>(
            builder: (_, model, child) {
              model.setOnLocaleChange();
              return NHome(uiBuilder);
            },
          );
        }),
      ),
    );
  }

  void _getData() async {
    if (!isDataFetched) {
      isDataFetched = true;
      statusNow = Status.processing;
      await widget.fetcher();
    }
  }

  void _retry() {
    setState(() {
      if (statusNow == Status.failed) {
        isDataFetched = false;
        _getData();
      }

      statusNow = Status.processing;
    });
  }

  void _update() {
    if (widget.controller.progress == 1.0) {
      if (widget.controller.checkDataIsNotValid()) {
        setState(() {
          statusNow = Status.failed;
        });
      } else {
        setState(() {
          statusNow = Status.success;
        });
      }
    } else {
      if (statusNow != Status.processing)
        setState(() {
          statusNow = Status.processing;
        });
    }
  }
}

class NHome extends StatefulWidget {
  final Widget child;

  NHome(this.child);

  @override
  _NHomeState createState() => _NHomeState();
}

class _NHomeState extends State<NHome> {
//  Timer _timerLink;

  @override
  Widget build(BuildContext context) {
    return widget.child;
  }
}

class SetupController extends ValueNotifier<SetupEditingValue> {
  double get progress => value.progress;

  String get description => value.description;

  bool get isError => value.isError;

  List<bool> get apiResultList => _apiResult;

  _SetupState setupState;

  int _totalApiRequest;

  List<bool> _apiResult = [];

  void retry() {
    _apiResult.clear();
    setupState._retry();
  }

  void showDialog() {
    setupState.setState(() => setupState.statusNow = Status.showDialog);
  }

  void updateProgress(String description, bool isGetDataSuccess) {
    _apiResult.add(isGetDataSuccess);
    double progress = _apiResult.length / _totalApiRequest;
    value = value.copyWith(
        description: description,
        progress: progress,
        isError: !isGetDataSuccess);
  }

  bool checkDataIsNotValid() {
    return _apiResult.contains(false);
  }

  SetupController({double progress, String description, bool isError})
      : super(progress == null && description == null && isError == null
            ? SetupEditingValue.empty
            : new SetupEditingValue(
                progress: progress,
                description: description,
                isError: isError));

  SetupController.fromValue(SetupEditingValue value)
      : super(value ?? SetupEditingValue.empty);

  void clear() {
    value = SetupEditingValue.empty;
  }
}

@immutable
class SetupEditingValue {
  const SetupEditingValue(
      {this.progress = 0.0,
      this.description = "",
      this.isError = false,
      this.setupState});

  final double progress;
  final String description;
  final bool isError;
  final _SetupState setupState;

  static const SetupEditingValue empty = const SetupEditingValue();

  SetupEditingValue copyWith(
      {double progress,
      String description,
      bool isError,
      _SetupState setupState,
      List<bool> apiResultList}) {
    return new SetupEditingValue(
        progress: progress,
        description: description,
        isError: isError,
        setupState: setupState);
  }

  SetupEditingValue.fromValue(SetupEditingValue copy)
      : this.progress = copy.progress,
        this.description = copy.description,
        this.isError = copy.isError,
        this.setupState = copy.setupState;

  @override
  String toString() =>
      '$runtimeType(progress: \u2524$progress\u251C, description: \u2524$description\u251C, isError: \u2524$isError\u251C)';

  @override
  bool operator ==(dynamic other) {
    if (identical(this, other)) return true;
    if (other is! SetupEditingValue) return false;
    final SetupEditingValue typedOther = other;
    return typedOther.progress == progress &&
        typedOther.description == description &&
        typedOther.isError == isError;
  }

  @override
  int get hashCode =>
      hashValues(progress.hashCode, description.hashCode, isError.hashCode);
}
