import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:social_x/core/constants/errors.dart';
import 'package:social_x/core/helpers/extensions/firestore_objects_converter.dart';
import 'package:social_x/core/models/http_client_result.dart';
import 'package:social_x/modules/posts/models/comment.dart';

class CommentsClient {
  final String postId;

  CommentsClient(this.postId);

  DocumentReference get _postDoc {
    return FirebaseFirestore.instance.collection("posts").doc(postId);
  }

  CollectionReference get _postComments {
    return _postDoc.collection("comments").adaptiveComments();
  }

  Query get query {
    return _postComments.orderBy("last_updated", descending: true);
  }

  Future<HttpClientResult> addComment(Comment comment) async {
    try {
      await _postComments.add(comment);
      int? commentsCount = (await _postDoc.get()).get("comments_count");
      await _postDoc.update({"comments_count": (commentsCount ?? 0) + 1});
      return SuccessfulRequest();
    } catch (_) {
      return FailedRequest(AppErrors.networkError);
    }
  }

  Future<HttpClientResult> deleteComment(String commentId) async {
    try {
      await _postComments.doc(commentId).delete();
      int? commentsCount = (await _postDoc.get()).get("comments_count");
      await _postDoc.update({"comments_count": (commentsCount ?? 0) - 1});
      return SuccessfulRequest();
    } catch (_) {
      return FailedRequest(AppErrors.networkError);
    }
  }
}
