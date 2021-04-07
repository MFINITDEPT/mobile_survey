import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mobilesurvey/component/adv_column.dart';
import 'package:mobilesurvey/component/adv_row.dart';
import 'package:mobilesurvey/model/document_item.dart';
import 'package:mobilesurvey/utilities/assets.dart';
import 'package:mobilesurvey/utilities/file_utils.dart';
import 'package:mobilesurvey/utilities/palette.dart';
import 'package:mobilesurvey/utilities/translation.dart';

import 'mime_utils.dart';

class UIUtils {
  /// static function to return actionBottomSheet
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

  /// static function to return popup Menu
  static Future<int> popupMenu(BuildContext context) async {
    var result = await showDialog(
        context: context,
        builder: (_) => Dialog(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: AdvColumn(
                  divider: ColumnDivider(16.0),
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      translation.getText('upload_photo'),
                      style: TextStyle(fontSize: 16.0, color: Palette.navy),
                    ),
                    Card(
                      color: Palette.grey,
                      child: InkWell(
                        onTap: () => Navigator.pop(context, 1),
                        child: AdvRow(
                          padding: EdgeInsets.all(16.0),
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(translation.getText('take_picture')),
                            Image.asset(Assets.camera, height: 24, width: 24)
                          ],
                        ),
                      ),
                    ),
                    Card(
                      color: Palette.grey,
                      child: InkWell(
                        onTap: () => Navigator.pop(context, 3),
                        child: AdvRow(
                          padding: EdgeInsets.all(16.0),
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(translation.getText('select_file')),
                            Image.asset(Assets.file, height: 24, width: 24)
                          ],
                        ),
                      ),
                    ),
                    Card(
                      color: Palette.grey,
                      child: InkWell(
                        onTap: () => Navigator.pop(context, 2),
                        child: AdvRow(
                          padding: EdgeInsets.all(16.0),
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(translation.getText('take_gallery')),
                            Image.asset(Assets.gallery, height: 24, width: 24)
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ));

    return result;
  }

  /// static function to return Widget Asset document or camera
  static Widget assetsIcon({bool isDocument = false}) {
    return Image.asset(isDocument ? Assets.file : Assets.camera,
        height: 24, width: 24);
  }

  static Widget documentIcon(DocumentItem item, {bool isDocument = false}) {
    return InkWell(
      onTap: item?.path != null ? () => FileUtils.openFile(item.path) : null,
      child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: item != null
              ? (MimeUtils.isImage(item.path)
                  ? Image.file(File(item.path),
                      height: 40, width: 40, fit: BoxFit.cover)
                  : Icon(Icons.insert_drive_file, size: 40))
              : Container(height: 40, width: 40, color: Palette.navy)),
    );
  }
}
