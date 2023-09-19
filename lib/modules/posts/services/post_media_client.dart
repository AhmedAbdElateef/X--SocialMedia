import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:path/path.dart';
import 'package:social_x/core/constants/errors.dart';
import 'package:social_x/core/helpers/functions/media_picker_tool.dart';
import 'package:social_x/core/models/http_client_result.dart';
import 'package:social_x/core/models/media_picker_result.dart';
//------------------------------------------------------

class PostMediaClient {
  Reference get _postsMediaRef {
    return FirebaseStorage.instance.ref("/posts/media/");
  }

  Future<HttpClientResult?> pickAndUploadMedia() async {
    final pickerResult = await MediaPickerTool().pick();
    if (pickerResult is MediaPickedSuccessfully) {
      final mediaUrl = await _uploadPostMedia(pickerResult.mediaFile);
      if (mediaUrl != null) {
        return SuccessfulRequest({
          "media_url": mediaUrl,
          "picker_result": pickerResult,
        });
      } else {
        FailedRequest(AppErrors.fileUploadFailed);
      }
    } else if (pickerResult is ErrorWhilePickingMedia) {
      return FailedRequest(AppErrors.unsupportedFile);
    }

    return null;
  }

  Future<String?> _uploadPostMedia(File media) async {
    try {
      final mediaName = basename(media.path);
      final mediaRef = _postsMediaRef.child(mediaName);
      final uploadTask = mediaRef.putFile(media);
      await uploadTask.whenComplete(() {});

      return await mediaRef.getDownloadURL();
    } catch (_) {
      return null;
    }
  }
}
