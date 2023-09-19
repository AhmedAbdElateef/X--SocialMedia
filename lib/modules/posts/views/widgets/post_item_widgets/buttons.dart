import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:social_x/core/helpers/extensions/sailor.dart';
import 'package:social_x/core/helpers/extensions/themes_helper.dart';
import 'package:social_x/core/ui/components/buttons/action_button.dart';
import 'package:social_x/core/ui/routes.dart';
import 'package:social_x/modules/posts/models/post.dart';
import 'package:social_x/modules/posts/view_models/post_controller.dart';
//-------------------------------------

class PostItemButtons extends StatelessWidget {
  final bool showCommentButton;
  final bool areButtonsActivated;
  final bool shareable;
  final Post post;

  const PostItemButtons({
    super.key,
    required this.areButtonsActivated,
    required this.showCommentButton,
    required this.shareable,
    required this.post,
  });

  @override
  Widget build(BuildContext context) {
    final loggedInUser = FirebaseAuth.instance.currentUser!;
    bool userLikedThisPost = post.likes!.contains(loggedInUser.uid);
    final controller = PostController();
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 3),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: ActionButton(
              activeIcon: userLikedThisPost,
              overlayColor: Theme.of(context).primaryColor.withOpacity(0.25),
              elevation: 0,
              textColor: context.darkMoodEnabled ? Colors.white : Colors.black,
              wrapParent: true,
              buttonColor:
                  context.darkMoodEnabled ? Colors.black : Colors.white,
              text: "${post.likes!.length}",
              iconName: "heart",
              onAction: areButtonsActivated
                  ? () {
                      controller.toggleLikeButton(
                        postId: post.id!,
                        dislike: userLikedThisPost,
                      );
                    }
                  : null,
            ),
          ),
          if (showCommentButton)
            Expanded(
              child: ActionButton(
                overlayColor: Theme.of(context).primaryColor.withOpacity(0.25),
                elevation: 0,
                textColor:
                    context.darkMoodEnabled ? Colors.white : Colors.black,
                wrapParent: true,
                buttonColor:
                    context.darkMoodEnabled ? Colors.black : Colors.white,
                text: "${post.commentsCount ?? 0}",
                iconName: "comment",
                onAction: areButtonsActivated
                    ? () {
                        Sailor.toNamed(
                          AppRoutes.postDetails,
                          routeArgs: post,
                        );
                      }
                    : null,
              ),
            ),
          Expanded(
            child: ActionButton(
              overlayColor: Theme.of(context).primaryColor.withOpacity(0.25),
              elevation: 0,
              textColor: context.darkMoodEnabled ? Colors.white : Colors.black,
              wrapParent: true,
              buttonColor:
                  context.darkMoodEnabled ? Colors.black : Colors.white,
              text: "${post.shares?.length ?? 0}",
              iconName: "share",
              onAction: areButtonsActivated && shareable
                  ? () => controller.sharePost(context: context, post: post)
                  : null,
            ),
          ),
        ],
      ),
    );
  }
}
