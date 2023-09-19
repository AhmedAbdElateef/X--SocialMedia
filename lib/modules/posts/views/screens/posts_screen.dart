import 'package:firebase_ui_firestore/firebase_ui_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
//------------------------------------------------------------
import 'package:social_x/core/ui/colors.dart';
import 'package:social_x/core/ui/routes.dart';
import 'package:social_x/core/ui/styles.dart';
import 'package:social_x/core/helpers/extensions//sailor.dart';
import 'package:social_x/core/helpers/extensions/themes_helper.dart';
//---------------------------------------------------------------------------
import 'package:social_x/modules/posts/models/post.dart';
import 'package:social_x/modules/posts/views/widgets/floating_search_bar.dart';
import 'package:social_x/modules/posts/views/widgets/post_item.dart';
import 'package:social_x/modules/posts/views/widgets/posts_tab_bar.dart';
import 'package:social_x/modules/posts/view_models/posts_tab_notifier.dart';
import 'package:social_x/modules/posts/views/widgets/posts_shimmer_loading.dart';
//-------------------------------------------------------------------------------

class PostsScreen extends ConsumerWidget {
  const PostsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var notifier = ref.read(postsTabProvider);
    var watcher = ref.watch(postsTabProvider);
    return Stack(
      fit: StackFit.expand,
      children: [
        Column(
          children: [
            const SizedBox(height: 65),
            PostsTabBar(
              selectedQuery: watcher.selectedPostsQuery,
              onTabChanged: (newQuery) {
                notifier.changePostsTab(newQuery);
              },
            ),
            const SizedBox(height: 10),
            Expanded(
              child: Container(
                color: context.darkMoodEnabled
                    ? AppColors.bgBlack
                    : AppColors.grey25,
                child: FirestoreListView(
                  pageSize: 10,
                  query: notifier.clientQuery,
                  padding: EdgeInsets.only(
                    bottom: AppStyles.screenBottomSpace.height!,
                  ),
                  physics: const BouncingScrollPhysics(),
                  loadingBuilder: (_) => const PostsShimmerLoading(),
                  itemBuilder: (_, postDoc) {
                    return PostItem(
                      isSavedPost: false,
                      post: postDoc.data() as Post,
                      onTap: () => Sailor.toNamed(AppRoutes.postDetails),
                    );
                  },
                ),
              ),
            ),
          ],
        ),
        const FloatingSearchBarWidget(),

        // const PostsHeader(),
      ],
    );
  }
}
