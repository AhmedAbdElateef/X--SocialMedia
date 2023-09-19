import 'package:flutter/widgets.dart';
import 'package:firebase_auth/firebase_auth.dart';
//------------------------------------------------
import 'package:social_x/modules/auth/views/screens/login_screen.dart';
import 'package:social_x/modules/auth/views/screens/signup_screen.dart';
import 'package:social_x/modules/auth/views/screens/onboarding_screen.dart';
import 'package:social_x/modules/auth/views/screens/email_verification.dart';
//---------------------------------------------------------------------------
import 'package:social_x/modules/posts/views/screens/post_details_screen.dart';
//-----------------------------------------------------------------------------
import 'package:social_x/modules/chat/views/screens/chat_rooms_screen.dart';
import 'package:social_x/modules/chat/views/screens/private_room_screen.dart';
import 'package:social_x/modules/posts/views/screens/post_edit_screen.dart';
import 'package:social_x/modules/posts/views/screens/users_screen.dart';
//----------------------------------------------------------------------------
import 'package:social_x/modules/profile/views/screens/profile_edit_screen.dart';
//-------------------------------------------------------------------------------
import 'package:social_x/core/ui/components/layouts/home_wrapper.dart';
import 'package:social_x/modules/profile/views/screens/user_profile.dart';
import 'package:social_x/modules/settings/views/screens/privacy_policy_screen.dart';
import 'package:social_x/modules/posts/views/screens/save_posts_screen.dart';
//-------------------------------------------------------------

class AppRoutes {
  // intro route
  static const String intro = "intro/";

  // auth routes
  static const String login = "auth/login/";
  static const String signup = "auth/signup/";
  static const String resetPassword = "auth/reset_password";

  // posts routes
  static const String home = "posts/home/";
  static const String savedPosts = "posts/saved";
  static const String postDetails = "posts/post_details/";
  static const String postForm = "posts/form/";
  static const String users = "posts/users/";

  // notifications routes
  static const String notifications = "notifications/";

  // profile routes
  static const String profileEdit = "profile/edit";
  static const String userProfile = "profile/user";

  // chat routes
  static const String chatRooms = "chat/rooms/";
  static const String privateRoom = "chat/private-room";

  // settings routes
  static const settingsPrivacyPolicy = "settings/privacy-policy";

  String get initialRoute {
    User? loggedInUser = FirebaseAuth.instance.currentUser;
    return loggedInUser == null ? intro : home;
  }

  static final Map<String, WidgetBuilder> routes = {
    // auth module
    login: (_) => const LoginScreen(),
    signup: (_) => const SignupScreen(),
    intro: (_) => const OnBoardingScreen(),
    resetPassword: (_) => const ResetPasswordScreen(),

    // posts module
    users: (_) => const UsersScreen(),
    home: (_) => const HomeWrapper(),
    postForm: (_) => const PostEditScreen(),
    savedPosts: (_) => const SavePostsScreen(),
    postDetails: (_) => const PostDetailsScreen(),

    // chat module
    chatRooms: (_) => const ChatRoomsScreen(),
    privateRoom: (_) => const PrivateChatRoomScreen(),

    // profile module
    profileEdit: (_) => const ProfileEditScreen(),
    userProfile: (_) => const UserProfileScreen(),
    //setting module
    settingsPrivacyPolicy: (_) => const PrivacyPolicyScreen(),
  };
}
