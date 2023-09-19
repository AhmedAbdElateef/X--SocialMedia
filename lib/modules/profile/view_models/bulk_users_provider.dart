import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
//------------------------------------------------------
import 'package:social_x/modules/auth/models/user.dart';
import 'package:social_x/modules/profile/services/bulk_users_client.dart';
import 'package:social_x/modules/profile/services/followers_client.dart';
//------------------------------------------------------------------------

final bulkUsersProvider =
    FutureProvider.family<List<SocialXUser>, List>((_, userIds) {
  return BulkUsersClient().fetchUsers(userIds);
});

final followingProvider =
    FutureProvider.autoDispose.family<List, String>((_, userId) {
  return FollowersClient(userId).getFollowingIds();
});

final followersProvider =
    FutureProvider.autoDispose.family<List, String>((_, userId) {
  return FollowersClient(userId).getFollowersIds();
});

