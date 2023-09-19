import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:social_x/core/helpers/extensions/themes_helper.dart';
//--------------------------------------------
import 'package:social_x/core/ui/colors.dart';
import 'package:social_x/core/helpers/extensions/localization_helper.dart';
import 'package:social_x/core/ui/components/images/cached_network_image.dart';
import 'package:social_x/modules/posts/views/widgets/post_item_widgets/post_video.dart';
//--------------------------------------------------------------

class MediaPickerButton extends StatelessWidget {
  final Map media;

  final VoidCallback onMediaSelect;
  final VoidCallback onSelectedMediaDelete;

  const MediaPickerButton({
    super.key,
    required this.media,
    required this.onMediaSelect,
    required this.onSelectedMediaDelete,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 180,
      width: double.infinity,
      decoration: BoxDecoration(
        color: context.darkMoodEnabled ? AppColors.bgBlack : AppColors.grey40,
        borderRadius: BorderRadius.circular(12.0),
      ),
      child: Stack(
        alignment: Alignment.center,
        fit: StackFit.expand,
        children: [
          if (media.isEmpty)
            Material(
              color: Colors.transparent,
              child: InkWell(
                onTap: onMediaSelect,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: 50.0,
                      width: 50.0,
                      child: SvgPicture.asset("assets/icons/camera.svg"),
                    ),
                    const SizedBox(height: 16.0),
                    Text(
                      context.localizations.addImageOrVideo,
                      style: const TextStyle(
                        fontSize: 18.0,
                        color: AppColors.grey70,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          if (media["image_url"] != null) getCachedImage(media["image_url"]),
          if (media["video_url"] != null)
            PostVideo(videoUrl: media["video_url"]),
          if (media.isNotEmpty)
            Positioned.directional(
              textDirection: TextDirection.ltr,
              start: 3,
              top: 3,
              child: Material(
                color: Colors.transparent,
                child: InkWell(
                  onTap: onSelectedMediaDelete,
                  child: Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: SvgPicture.asset(
                      "assets/icons/delete_cross.svg",
                      height: 16.0,
                      width: 16.0,
                      colorFilter: const ColorFilter.mode(
                        Colors.white,
                        BlendMode.srcIn,
                      ),
                    ),
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
