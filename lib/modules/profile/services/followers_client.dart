import 'package:cloud_firestore/cloud_firestore.dart';
//----------------------------------------------------
import 'package:social_x/core/constants/errors.dart';
import 'package:social_x/core/models/http_client_result.dart';
//------------------------------------------------------------

class FollowersClient {
  final String userId;

  FollowersClient(this.userId);

  CollectionReference get _followers {
    return FirebaseFirestore.instance.collection("followers");
  }

  Future<HttpClientResult> followOrUnfollow(
    String peerId, {
    bool isUnfollowRequest = false,
  }) async {
    try {
      final followingUsersDoc = _followers.doc(userId);
      await followingUsersDoc.update({
        "ids": isUnfollowRequest
            ? FieldValue.arrayRemove([peerId])
            : FieldValue.arrayUnion([peerId]),
      });
      return SuccessfulRequest();
    } catch (_) {
      return FailedRequest(AppErrors.networkError);
    }
  }

  Future<bool> isFollowing(String peerId) async {
    final followersDoc = await _followers.doc(userId).get();
    List following = await followersDoc.get("ids");
    return following.contains(peerId);
  }

  Future<List> getFollowingIds() async {
    final followersDoc = await _followers.doc(userId).get();
    if (!followersDoc.exists) return [];

    final following = await followersDoc.get("ids");
    return following;
  }

  Future<List> getFollowersIds() async {
    final queryResult =
        await _followers.where("ids", arrayContains: userId).get();
    final followersIds = queryResult.docs.map((follower) {
      return follower.id;
    }).toList();
    return followersIds;
  }
}
