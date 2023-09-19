import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:social_x/core/constants/hive_boxes.dart';
import 'package:social_x/core/helpers/extensions/localization_helper.dart';
import 'package:social_x/core/helpers/extensions/sailor.dart';
import 'package:social_x/core/helpers/functions/clients_error_handler.dart';
import 'package:social_x/core/models/http_client_result.dart';
import 'package:social_x/core/ui/components/loaders/loading_popup.dart';
import 'package:social_x/core/ui/routes.dart';
import 'package:social_x/modules/posts/models/post.dart';
import 'package:social_x/modules/posts/services/likes_client.dart';
import 'package:social_x/modules/posts/services/post_client.dart';

class PostController {
  final _client = PostClient();

  final _savedPostsBox = HiveBoxes.savedPostsBox;
  final _loggedInUser = FirebaseAuth.instance.currentUser!;

  Future<void> handelOnPostOption({
    required String optionId,
    required Post post,
    required BuildContext context,
  }) async {
    if (optionId == "save") {
      _savedPostsBox.add(post);
    } else if (optionId == "unsave") {
      _savedPostsBox.delete(post.key);
    } else if (optionId == "edit") {
      Sailor.toNamed(AppRoutes.postForm, routeArgs: post);
    } else if (optionId == "delete") {
      showLoadingPopup(
        context: context,
        description: context.localizations.deletingPost,
      );
      final result = await _client.deletePost(post.id!);
      Sailor.back();
      if (result is FailedRequest) {
        // ignore: use_build_context_synchronously
        handleHttpClientError(context, result.errorCode);
      }
    }
  }

  Future<void> toggleLikeButton({
    required String postId,
    required bool dislike,
  }) async {
    final likesClient = LikesClient(postId);
    await likesClient.likeOrDislike(dislikeRequest: dislike);
  }

  Future<void> sharePost({
    required BuildContext context,
    required Post post,
  }) async {
    if (post.shares != null) {
      post.shares!.add(_loggedInUser.uid);
    } else {
      post.shares = [_loggedInUser.uid];
    }

    showLoadingPopup(
      context: context,
      description: context.localizations.sharingPost,
    );
    final result = await _client.updatePost(
      postId: post.id!,
      updatedPost: post,
    );
    Sailor.back();
    if (result is FailedRequest) {
      // ignore: use_build_context_synchronously
      handleHttpClientError(context, result.errorCode);
    }
  }
}
