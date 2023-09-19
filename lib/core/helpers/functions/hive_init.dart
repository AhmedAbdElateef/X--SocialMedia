import 'dart:io';
//---------------
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';
//------------------------------------------------
import 'package:social_x/modules/auth/models/user.dart';
//------------------------------------------------------
import 'package:social_x/core/constants/hive_boxes.dart';
import 'package:social_x/modules/posts/models/post.dart';
//-------------------------------------------------------

Future<void> initHiveDb() async {
  Directory appDocumentDir = await getApplicationDocumentsDirectory();
  Hive.init(appDocumentDir.path);

  Hive.registerAdapter(SocialXUserAdapter());
  Hive.registerAdapter(PostAdapter());

  await Hive.openBox(HiveBoxes.prefsBoxName);
  await Hive.openBox<Post>(HiveBoxes.savedPostsBoxName);
}
