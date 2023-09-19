import 'package:cloud_firestore/cloud_firestore.dart';
//----------------------------------------------------
import 'package:social_x/core/constants/errors.dart';
import 'package:social_x/core/models/http_client_result.dart';
import 'package:social_x/core/helpers/extensions/firestore_objects_converter.dart';
//-------------------------------------------------------------------
import 'package:social_x/modules/posts/models/post.dart';
//-------------------------------------------------------

class PostClient {
  CollectionReference get _posts {
    return FirebaseFirestore.instance.collection("posts").adaptivePosts();
  }

  Future<HttpClientResult> createNewPost(Post post) async {
    try {
      await _posts.add(post);
      return SuccessfulRequest();
    } catch (_) {
      return FailedRequest(AppErrors.networkError);
    }
  }

  Future<HttpClientResult> updatePost({
    required String postId,
    required Post updatedPost,
  }) async {
    try {
      await _posts.doc(postId).update(updatedPost.toJson());
      return SuccessfulRequest();
    } catch (_) {
      return FailedRequest(AppErrors.networkError);
    }
  }

  Future<HttpClientResult> deletePost(String postId) async {
    try {
      final postDoc = _posts.doc(postId);
      await postDoc.delete();
      final commentsQuery = await postDoc.collection("comments").get();
      for (var doc in commentsQuery.docs) {
        await doc.reference.delete();
      }
      return SuccessfulRequest();
    } catch (_) {
      return FailedRequest(AppErrors.networkError);
    }
  }

  Future<HttpClientResult> likeOrUnLike(String postId) async {
    try {
      final postDoc = _posts.doc(postId);
      await postDoc.delete();
      final commentsQuery = await postDoc.collection("comments").get();
      for (var doc in commentsQuery.docs) {
        await doc.reference.delete();
      }
      return SuccessfulRequest();
    } catch (_) {
      return FailedRequest(AppErrors.networkError);
    }
  }
}
