import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mobilesurvey/utilities/translation.dart';

class UIUtils {
  static Future<int> browseFile(BuildContext context) async {
    var result = await showCupertinoModalPopup(
      context: context,
      builder: (BuildContext context) => CupertinoActionSheet(
        cancelButton: CupertinoActionSheetAction(
            child: Text(translation.getText('cancel'),
                style: TextStyle(fontSize: 12.0)),
            isDefaultAction: true,
            isDestructiveAction: true,
            onPressed: () => Navigator.pop(context)),
        actions: <Widget>[
          CupertinoActionSheetAction(
              child: Text(translation.getText('camera'),
                  style: TextStyle(fontSize: 12.0)),
              onPressed: () => Navigator.pop(context, 1)),
          CupertinoActionSheetAction(
              child: Text(translation.getText('gallery'),
                  style: TextStyle(fontSize: 12.0)),
              onPressed: () => Navigator.pop(context, 2)),
          CupertinoActionSheetAction(
              child: Text(translation.getText('file_manager'),
                  style: TextStyle(fontSize: 12.0)),
              onPressed: () => Navigator.pop(context, 3))
        ],
      ),
    );
    return result;
  }
}
