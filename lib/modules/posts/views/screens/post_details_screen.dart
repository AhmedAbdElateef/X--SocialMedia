import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_ui_firestore/firebase_ui_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
//-------------------------------------
import 'package:social_x/core/helpers/extensions/sailor.dart';
import 'package:social_x/core/helpers/extensions/themes_helper.dart';
import 'package:social_x/core/ui/components/images/cached_network_image.dart';
import 'package:social_x/core/ui/components/input/x_text_field.dart';
import 'package:social_x/core/helpers/extensions/localization_helper.dart';
import 'package:social_x/core/ui/components/loaders/circular_loading_indicator.dart';
import 'package:social_x/modules/posts/helpers/firebase_image_url.dart';
import 'package:social_x/modules/posts/models/comment.dart';
import 'package:social_x/modules/posts/models/post.dart';
import 'package:social_x/modules/posts/view_models/comments_controller.dart';
//--------------------------------------------------------------
import 'package:social_x/modules/posts/views/widgets/comment_card.dart';
import 'package:social_x/modules/posts/views/widgets/post_item.dart';
//----------------------------------------------------------------------

class PostDetailsScreen extends StatelessWidget {
  const PostDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final post = ModalRoute.of(context)!.settings.arguments as Post;
    final loggedInUser = FirebaseAuth.instance.currentUser!;
    final commentController = CommentsController(post.id!);
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(bottom: 12.0),
                child: InkWell(
                  onTap: () => Sailor.back(),
                  child: const Icon(Icons.arrow_back_ios_new),
                ),
              ),
              Expanded(
                child: ListView(
                  physics: const BouncingScrollPhysics(),
                  children: [
                    PostItem(
                      isSavedPost: false,
                      post: post,
                      showCommentIcon: false,
                    ),
                    const SizedBox(height: 10),
                    FirestoreListView(
                      shrinkWrap: true,
                      query: commentController.clientQuery,
                      pageSize: 20,
                      loadingBuilder: (_) => const CircularLoadingIndicator(),
                      physics: const NeverScrollableScrollPhysics(),
                      itemBuilder: (context, commentDoc) {
                        return CommentCard(
                          onDelete: () {
                            commentController.delete(
                              context: context,
                              commentId: commentDoc.id,
                            );
                          },
                          comment: commentDoc.data() as Comment,
                        );
                      },
                    ),
                    const SizedBox(height: 30),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16.0,
                  vertical: 12.0,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    ClipOval(
                      child: getCachedImage(
                        getUserImageUrl(loggedInUser.uid),
                        height: 40.0,
                        width: 40.0,
                        fallbackImageName: "default.png",
                      ),
                    ),
                    const SizedBox(width: 16.0),
                    Expanded(
                      child: XTextField(
                        hintText: context.localizations.addComment,
                        controller: commentController.textController,
                        focusNode: commentController.focusNode,
                      ),
                    ),
                    IconButton(
                      onPressed: () {
                        commentController.addComment(context);
                      },
                      icon: SvgPicture.asset(
                        "assets/icons/send.svg",
                        width: 20,
                        height: 20,
                        colorFilter: ColorFilter.mode(
                          context.darkMoodEnabled
                              ? Colors.white
                              : Theme.of(context).primaryColor,
                          BlendMode.srcIn,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
