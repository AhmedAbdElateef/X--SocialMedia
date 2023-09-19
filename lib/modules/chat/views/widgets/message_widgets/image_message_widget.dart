import 'package:flutter/material.dart';
//-------------------------------------
import 'package:social_x/core/ui/colors.dart';
import 'package:social_x/core/ui/components/images/cached_network_image.dart';
import 'package:social_x/core/ui/components/loaders/circular_loading_indicator.dart';
//---------------------------------------------------------------------------

class ImageMessageWidget extends StatelessWidget {
  final String imageUrl;
  final String senderName;

  const ImageMessageWidget(
    this.imageUrl,
    this.senderName, {
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    if (imageUrl == "uploading") {
      return Container(
        width: 150.0,
        height: 150.0,
        decoration: BoxDecoration(
          color: AppColors.grey25,
          borderRadius: BorderRadius.circular(7),
        ),
        child: const CircularLoadingIndicator(),
      );
    }

    return ClipRRect(
      borderRadius: BorderRadius.circular(7),
      child: GestureDetector(
        onTap: () {},
        child: Hero(
          tag: imageUrl,
          child: getCachedImage(
            imageUrl,
            height: 150.0,
            width: 150.0,
          ),
        ),
      ),
    );
  }
}
