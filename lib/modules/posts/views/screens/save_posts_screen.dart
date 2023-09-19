import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:social_x/core/constants/hive_boxes.dart';
import 'package:social_x/core/helpers/extensions/localization_helper.dart';
import 'package:social_x/core/helpers/extensions/themes_helper.dart';
import 'package:social_x/core/ui/colors.dart';
import 'package:social_x/core/ui/components/layouts/screen_header.dart';
import 'package:social_x/core/ui/styles.dart';
import 'package:social_x/modules/posts/views/widgets/post_item.dart';

class SavePostsScreen extends StatelessWidget {
  const SavePostsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: ScreenHeader(title: context.localizations.savedPosts),
        body: Container(
            color:
                context.darkMoodEnabled ? AppColors.bgBlack : AppColors.grey25,
            child: ValueListenableBuilder(
              builder: (_, savedPostsBox, __) {
                final savedPosts = savedPostsBox.values.toList();
                return ListView.separated(
                  itemBuilder: (_, index) => PostItem(
                    isSavedPost: true,
                    post: savedPosts[index],
                  ),
                  separatorBuilder: (_, __) => AppStyles.listViewDivider,
                  itemCount: savedPosts.length,
                );
              },
              valueListenable: HiveBoxes.savedPostsBox.listenable(),
            )),
      ),
    );
  }
}
