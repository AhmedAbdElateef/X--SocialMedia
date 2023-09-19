import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:social_x/core/helpers/extensions/localization_helper.dart';
import 'package:social_x/core/helpers/extensions/sailor.dart';
import 'package:social_x/core/helpers/functions/time_ago_util.dart';
import 'package:social_x/core/ui/components/images/cached_network_image.dart';
import 'package:social_x/core/ui/components/layouts/home_wrapper.dart';
import 'package:social_x/core/ui/routes.dart';
import 'package:social_x/modules/posts/helpers/firebase_image_url.dart';
import 'package:social_x/modules/posts/helpers/post_options.dart';
import 'package:social_x/modules/posts/models/post.dart';
import 'package:social_x/modules/posts/view_models/post_controller.dart';
import 'package:social_x/modules/profile/view_models/single_user_provider.dart';
//-------------------------------------

class PostItemHeader extends StatelessWidget {
  final Post post;
  final bool isSavedPost;

  const PostItemHeader({
    super.key,
    required this.isSavedPost,
    required this.post,
  });

  void navigateToUserProfile() {
    final loggedInUser = FirebaseAuth.instance.currentUser!;
    if (post.userId == loggedInUser.uid) {
      pageController.jumpToPage(4);
      tabController.animateTo(4);
    } else {
      Sailor.toNamed(AppRoutes.userProfile, routeArgs: post.userId);
    }
  }

  @override
  Widget build(BuildContext context) {
    final controller = PostController();
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 14.0,
        vertical: 10.0,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              GestureDetector(
                onTap: navigateToUserProfile,
                child: ClipOval(
                  child: getCachedImage(
                    getUserImageUrl(post.userId!),
                    fallbackImageName: "default.png",
                    height: 45,
                    width: 45,
                  ),
                ),
              ),
              const SizedBox(width: 10.0),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Consumer(
                    builder: (_, ref, __) {
                      var r = ref.watch(singleUserProvider(post.userId!));
                      return r.when(
                        loading: () => const CircularProgressIndicator(),
                        error: (_, __) => const Text(""),
                        data: (data) {
                          return GestureDetector(
                            onTap: navigateToUserProfile,
                            child: Text(
                              data.name.toString(),
                              style: const TextStyle(fontSize: 16),
                            ),
                          );
                        },
                      );
                    },
                  ),
                  Text(
                    TimeAgoUtil().formatTime(
                      post.lastUpdated!,
                      context.langCode,
                    ),
                    style: TextStyle(
                      fontSize: 14,
                      color: Theme.of(context).colorScheme.secondary,
                    ),
                  ),
                ],
              ),
            ],
          ),
          PopupMenuButton(
            color: Theme.of(context).primaryColor.withOpacity(0.70),
            padding: EdgeInsets.zero,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            icon: const Icon(Icons.more_horiz),
            itemBuilder: (_) {
              return resolvePostOptions(
                postOwnerId: post.userId!,
                postId: post.id!,
              ).map((option) {
                return PopupMenuItem<String>(
                  value: option.id,
                  child: Text(
                    context.localizations.postOptions(option.id),
                    style: const TextStyle(color: Colors.white),
                  ),
                );
              }).toList();
            },
            onSelected: (String optionId) {
              controller.handelOnPostOption(
                context: context,
                post: post,
                optionId: optionId,
              );
            },
          )
        ],
      ),
    );
  }
}
