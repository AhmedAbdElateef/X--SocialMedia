import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:social_x/core/constants/errors.dart';
import 'package:social_x/core/models/http_client_result.dart';

class LikesClient {
  final String postId;

  LikesClient(this.postId);

  final _loggedInUser = FirebaseAuth.instance.currentUser!;

  DocumentReference get _postDoc {
    return FirebaseFirestore.instance.collection("posts").doc(postId);
  }

  Future<HttpClientResult> likeOrDislike({
    bool dislikeRequest = false,
  }) async {
    try {
      await _postDoc.update({
        "likes": dislikeRequest
            ? FieldValue.arrayRemove([_loggedInUser.uid])
            : FieldValue.arrayUnion([_loggedInUser.uid]),
      });
      return SuccessfulRequest();
    } catch (_) {
      return FailedRequest(AppErrors.networkError);
    }
  }
}
