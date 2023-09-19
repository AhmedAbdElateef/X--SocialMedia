import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:mime/mime.dart';
//--------------------------------------------
import 'package:social_x/core/models/media_picker_result.dart';
//-------------------------------------------------------------

class MediaPickerTool {
  final _filePicker = FilePicker.platform;

  Future<MediaPickerResult> pick({
    FileType fileType = FileType.media,
  }) async {
    try {
      final pickerResult = await _filePicker.pickFiles(
        allowMultiple: false,
        type: fileType,
      );
      if (pickerResult?.files.isNotEmpty ?? false) {
        final pickedFile = pickerResult!.files.first;
        final filePath = pickedFile.path!;
        final fileType = lookupMimeType(filePath)!;
        return MediaPickedSuccessfully(
          mediaFile: File(filePath),
          fileType: fileType.split("/").first,
        );
      } else {
        return MediaPickerCanceled();
      }
    } catch (_) {
      return ErrorWhilePickingMedia();
    }
  }
}
