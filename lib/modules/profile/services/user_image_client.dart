import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:social_x/core/constants/errors.dart';
import 'package:social_x/core/helpers/functions/media_picker_tool.dart';
import 'package:social_x/core/models/http_client_result.dart';
import 'package:social_x/core/models/media_picker_result.dart';
import 'package:social_x/modules/posts/helpers/firebase_image_url.dart';
//------------------------------------------------------

class UserImagesClient {
  final _loggedInUser = FirebaseAuth.instance.currentUser!;

  Reference get _userImagesRef {
    return FirebaseStorage.instance.ref("/users_image/");
  }

  Future<HttpClientResult?> pickAndUploadImage() async {
    final pickerResult = await MediaPickerTool().pick(
      fileType: FileType.image,
    );
    if (pickerResult is MediaPickedSuccessfully) {
      final mediaUrl = await _uploadUserImage(pickerResult.mediaFile);
      if (mediaUrl != null) {
        return SuccessfulRequest({"media_url": mediaUrl});
      } else {
        FailedRequest(AppErrors.fileUploadFailed);
      }
    } else if (pickerResult is ErrorWhilePickingMedia) {
      return FailedRequest(AppErrors.unsupportedFile);
    }

    return null;
  }

  Future<String?> _uploadUserImage(File image) async {
    try {
      final mediaRef = _userImagesRef.child("${_loggedInUser.uid}.jpg");
      final uploadTask = mediaRef.putFile(image);
      await uploadTask.whenComplete(() {});
      await CachedNetworkImage.evictFromCache(
        getUserImageUrl(_loggedInUser.uid),
      );

      return await mediaRef.getDownloadURL();
    } catch (_) {
      return null;
    }
  }
}
