import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:social_x/core/helpers/functions/clients_error_handler.dart';
import 'package:social_x/core/models/http_client_result.dart';
import 'package:social_x/modules/profile/services/followers_client.dart';

final isFollowingProvider = ChangeNotifierProvider((_) {
  return FollowersNotifier();
});

class FollowersNotifier extends ChangeNotifier {
  bool isLoading = false;

  final _loggedInUser = FirebaseAuth.instance.currentUser!;

  Future<bool> getIsFollowing() async {
    return false;
  }

  Future<void> toggleFollowState({
    required bool unFollow,
    required String peerId,
    required BuildContext context,
  }) async {
    _changeLoadingState(true);

    final client = FollowersClient(_loggedInUser.uid);
    final result = await client.followOrUnfollow(
      peerId,
      isUnfollowRequest: unFollow,
    );

    if (result is FailedRequest) {
      // ignore: use_build_context_synchronously
      handleHttpClientError(context, result.errorCode);
    }

    _changeLoadingState(false);
  }

  void _changeLoadingState(bool newState) {
    isLoading = newState;
    notifyListeners();
  }
}
