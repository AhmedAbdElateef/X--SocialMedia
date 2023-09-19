import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:social_x/core/helpers/functions/clients_error_handler.dart';
import 'package:social_x/core/models/http_client_result.dart';
import 'package:social_x/modules/auth/models/user.dart';
import 'package:social_x/modules/posts/services/users_client.dart';

final usersSearchProvider = StateProvider<List<SocialXUser>>((ref) {
  var watcher = ref.watch(usersProvider);
  List<SocialXUser> users = watcher.users;
  String searchKeyword = watcher.searchKeyword;

  return users.where((user) {
    return user.name!.toLowerCase().contains(searchKeyword);
  }).toList();
});

final usersProvider = ChangeNotifierProvider((_) {
  return UsersNotifier();
});

class UsersNotifier extends ChangeNotifier {
  static bool initialized = false;

  bool isLoading = false;

  String searchKeyword = "";

  List<SocialXUser> users = [];

  Future<void> getAllUsers(BuildContext context) async {
    _changeLoadingState(true);

    var result = await UsersClient().fetchAllUsers(initialized);

    if (result is SuccessfulRequest) {
      users = result.retrievedData as List<SocialXUser>;
      initialized = true;
    } else if (result is FailedRequest) {
      // ignore: use_build_context_synchronously
      handleHttpClientError(context, result.errorCode);
    }

    _changeLoadingState(false);
  }

  void changeSearchKeywordState(String newValue) {
    searchKeyword = newValue.toLowerCase();
    notifyListeners();
  }

  void _changeLoadingState(bool newState) {
    isLoading = newState;
    notifyListeners();
  }
}
