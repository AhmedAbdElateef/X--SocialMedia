import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:social_x/core/constants/hive_boxes.dart';
import 'package:social_x/core/helpers/extensions/localization_helper.dart';
import 'package:social_x/core/helpers/extensions/sailor.dart';
import 'package:social_x/core/helpers/functions/clients_error_handler.dart';
import 'package:social_x/core/models/http_client_result.dart';
import 'package:social_x/core/ui/components/loaders/loading_popup.dart';
import 'package:social_x/modules/auth/models/user.dart';
import 'package:social_x/modules/posts/models/comment.dart';
import 'package:social_x/modules/posts/services/comments_client.dart';

class CommentsController {
  final String postId;

  late CommentsClient _client;

  CommentsController(this.postId) {
    _client = CommentsClient(postId);
  }

  final textController = TextEditingController();
  final focusNode = FocusNode();

  final loggedInUser = FirebaseAuth.instance.currentUser!;

  SocialXUser cachedUserData =
      HiveBoxes.prefsBox.get(HiveBoxes.userCredentialsKey)!;

  Query get clientQuery => _client.query;

  Future<void> addComment(BuildContext context) async {
    if (textController.text.isNotEmpty) {
      showLoadingPopup(
        description: context.localizations.addingComment,
        context: context,
      );

      final newComment = Comment.fromUserInput(
        id: loggedInUser.uid,
        name: cachedUserData.name!,
        comment: textController.text,
      );

      final result = await _client.addComment(newComment);
      Sailor.back();

      if (result is FailedRequest) {
        // ignore: use_build_context_synchronously
        handleHttpClientError(context, result.errorCode);
      } else {
        focusNode.dispose();
        textController.clear();
      }
    }
  }

  Future<void> delete({
    required BuildContext context,
    required String commentId,
  }) async {
    final result = await _client.deleteComment(commentId);

    if (result is FailedRequest) {
      // ignore: use_build_context_synchronously
      handleHttpClientError(context, result.errorCode);
    }
  }
}
