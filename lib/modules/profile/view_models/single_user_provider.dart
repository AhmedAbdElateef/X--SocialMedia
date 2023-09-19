import 'package:flutter_riverpod/flutter_riverpod.dart';
//------------------------------------------------------
import 'package:social_x/modules/auth/models/user.dart';
import 'package:social_x/modules/profile/services/single_user_client.dart';
//-------------------------------------------------------------------------

final singleUserProvider =
    FutureProvider.family<SocialXUser, String>((_, userId) {
  return SingleUserClient().fetchUserData(userId);
});
