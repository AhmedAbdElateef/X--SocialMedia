import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:social_x/core/models/http_client_result.dart';
import 'package:social_x/core/ui/components/layouts/home_wrapper.dart';
import 'package:social_x/core/ui/components/loaders/loading_popup.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:social_x/core/helpers/extensions/localization_helper.dart';
import 'package:social_x/core/helpers/extensions/sailor.dart';
import 'package:social_x/core/helpers/functions/clients_error_handler.dart';
import 'package:social_x/core/ui/routes.dart';
import 'package:social_x/modules/posts/models/post.dart';
import 'package:social_x/modules/posts/services/post_client.dart';
import 'package:social_x/modules/posts/services/post_media_client.dart';
//------------------------------------------------------

final postFormProvider = ChangeNotifierProvider.autoDispose
    .family<PostFormNotifier, Post?>((_, oldPostData) {
  return PostFormNotifier(oldPostData);
});

class PostFormNotifier extends ChangeNotifier {
  bool isLoading = false;

  Map<String, dynamic> media = {};

  final Post? oldPostData;

  PostFormNotifier(this.oldPostData) {
    if (oldPostData != null) {
      textController.text = oldPostData!.text!;
      media = {
        if (oldPostData?.imageUrl != null) "image_url": oldPostData!.imageUrl,
        if (oldPostData?.videoUrl != null) "video_url": oldPostData!.videoUrl,
      };
    }
  }

  final _postClient = PostClient();
  final _postMediaClient = PostMediaClient();
  final textController = TextEditingController();
  final _loggedInUser = FirebaseAuth.instance.currentUser!;

  String get _postText => textController.text;

  Future<void> createOrUpdatePost(BuildContext context) async {
    if (_postText.isEmpty && media.isEmpty) {
      Fluttertoast.showToast(msg: context.localizations.emptyPost);
      return;
    }

    _changeLoadingState(true);

    late HttpClientResult result;

    final postData = Post.fromUserForm({
      "text": textController.text,
      "user_id": _loggedInUser.uid,
      "image_url": media["image_url"],
      "video_url": media["video_url"],
    });

    if (oldPostData != null) {
      result = await _postClient.updatePost(
        postId: oldPostData!.id!,
        updatedPost: postData,
      );
    } else {
      result = await _postClient.createNewPost(postData);
    }

    if (result is SuccessfulRequest) {
      pageController.jumpToPage(0);
      Sailor.startOverFromRoute(AppRoutes.home);

      // ignore: use_build_context_synchronously
      Fluttertoast.showToast(msg: context.localizations.postSaved);
    } else if (result is FailedRequest) {
      // ignore: use_build_context_synchronously
      handleHttpClientError(context, result.errorCode);
    }

    _changeLoadingState(false);
  }

  Future<void> addMedia(BuildContext context) async {
    showLoadingPopup(
      description: context.localizations.uploading,
      context: context,
    );
    final result = await _postMediaClient.pickAndUploadMedia();
    Sailor.back();

    if (result is SuccessfulRequest) {
      final mediaInfo = result.retrievedData["picker_result"];
      final mediaUrl = result.retrievedData["media_url"];
      media["${mediaInfo.fileType}_url"] = mediaUrl;
      notifyListeners();
    } else if (result is FailedRequest) {
      // ignore: use_build_context_synchronously
      handleHttpClientError(context, result.errorCode);
    }
  }

  void removeMedia() {
    media.clear();
    notifyListeners();
  }

  void _changeLoadingState(bool newLoadingState) {
    isLoading = newLoadingState;
    notifyListeners();
  }

  @override
  void dispose() {
    textController.dispose();
    super.dispose();
  }
}
