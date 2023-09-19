import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
//--------------------------------------------------------------
import 'package:social_x/core/ui/components/loaders/circular_loading_indicator.dart';
//-----------------------------------------------------------------------------------

Widget getCachedImage(
  String imageUrl, {
  double? height,
  double? width,
  String? fallbackImageName,
  BoxFit fit = BoxFit.contain,
}) {
  return CachedNetworkImage(
    imageUrl: imageUrl,
    height: height,
    width: width,
    fit: fit,
    filterQuality: FilterQuality.high,
    fadeInDuration: const Duration(seconds: 1),
    progressIndicatorBuilder: (_, __, downloadProgress) {
      return CircularLoadingIndicator(
        loadingValue: downloadProgress.progress,
      );
    },
    errorWidget: (_, __, ___) {
      return fallbackImageName != null
          ? Image.asset(
              "assets/images/$fallbackImageName",
              width: width,
              height: height,
            )
          : const SizedBox();
    },
  );
}
