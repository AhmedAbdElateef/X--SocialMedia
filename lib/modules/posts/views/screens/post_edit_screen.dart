import 'package:flutter/material.dart';
import 'package:social_x/core/helpers/extensions/localization_helper.dart';
import 'package:social_x/core/ui/components/layouts/screen_header.dart';
import 'package:social_x/modules/posts/models/post.dart';
import 'package:social_x/modules/posts/views/screens/post_form_screen.dart';

class PostEditScreen extends StatelessWidget {
  const PostEditScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final oldPost = ModalRoute.of(context)!.settings.arguments as Post;
    return SafeArea(
      child: Scaffold(
        appBar: ScreenHeader(
          title: context.localizations.editPost,
        ),
        body: PostFormScreen(
          oldPostData: oldPost,
        ),
      ),
    );
  }
}
