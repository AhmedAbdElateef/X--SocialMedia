import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:social_x/core/constants/hive_boxes.dart';
import 'package:social_x/core/ui/components/loaders/loading_overlay.dart';
//-------------------------------------
import 'package:social_x/core/ui/styles.dart';
import 'package:social_x/core/ui/components/input/x_text_field.dart';
import 'package:social_x/core/ui/components/buttons/action_button.dart';
import 'package:social_x/core/helpers/extensions/localization_helper.dart';
import 'package:social_x/core/ui/components/images/cached_network_image.dart';
import 'package:social_x/modules/auth/models/user.dart';
import 'package:social_x/modules/posts/models/post.dart';
import 'package:social_x/modules/posts/view_models/post_form_notifier.dart';
//---------------------------------------------------------------------
import 'package:social_x/modules/posts/views/widgets/media_picker.dart';
//----------------------------------------------------------------------

class PostFormScreen extends ConsumerWidget {
  final Post? oldPostData;

  const PostFormScreen({
    super.key,
    this.oldPostData,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final notifier = ref.read(postFormProvider(oldPostData));
    final watcher = ref.watch(postFormProvider(oldPostData));
    SocialXUser userData = HiveBoxes.prefsBox.get(HiveBoxes.userCredentialsKey);
    return LoadingOverlay(
      loading: watcher.isLoading,
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: AppStyles.screensHorizontalPadding,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const SizedBox(height: 20),
            Row(
              children: [
                Flexible(
                  child: Row(
                    children: [
                      ClipOval(
                        child: getCachedImage(
                          userData.imageUrl.toString(),
                          height: 45.0,
                          width: 45.0,
                          fallbackImageName: "default.png",
                        ),
                      ),
                      const SizedBox(width: 14),
                      Flexible(
                        child: Text(
                          userData.name.toString(),
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                ActionButton(
                  wrapParent: true,
                  elevation: 0,
                  buttonHeight: 40,
                  text: notifier.oldPostData == null
                      ? context.localizations.post
                      : context.localizations.update,
                  onAction: () {
                    notifier.createOrUpdatePost(context);
                  },
                )
              ],
            ),
            const SizedBox(height: 40),
            Flexible(
              child: XTextField(
                textArea: true,
                fillColor: Colors.transparent,
                borderRadius: 7,
                controller: notifier.textController,
                hintText: context.localizations.whatsInYourMind,
              ),
            ),
            MediaPickerButton(
              media: watcher.media,
              onMediaSelect: () {
                notifier.addMedia(context);
              },
              onSelectedMediaDelete: () {
                notifier.removeMedia();
              },
            ),
            const SizedBox(height: 30),
          ],
        ),
      ),
    );
  }
}
