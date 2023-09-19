import 'package:hive/hive.dart';
import 'package:social_x/modules/posts/models/post.dart';
//------------------------------

class HiveBoxes {
  // hive boxes names
  static const prefsBoxName = "shared_prefs";
  static const savedPostsBoxName = "saved_posts";

  // hive boxes
  static final prefsBox = Hive.box(prefsBoxName);
  static final savedPostsBox = Hive.box<Post>(savedPostsBoxName);

  //  prefs Box keys
  static const appLangKey = "app_lang";
  static const darkModeKey = "dark_mode_enabled";
  static const userCredentialsKey = "user_credentials";
}
