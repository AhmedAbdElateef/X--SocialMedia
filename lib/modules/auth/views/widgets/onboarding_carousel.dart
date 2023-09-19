import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:carousel_slider/carousel_slider.dart';
//----------------------------------------------------
import 'package:social_x/core/helpers/extensions/localization_helper.dart';
//--------------------------------------------------------------

class OnboardingCarousel extends StatelessWidget {
  final int numberOfItems;

  final CarouselController controller;

  final ValueChanged<int> onIndicatorChanged;

  const OnboardingCarousel({
    super.key,
    required this.numberOfItems,
    required this.controller,
    required this.onIndicatorChanged,
  });

  @override
  Widget build(BuildContext context) {
    return CarouselSlider(
      items: List.generate(
        numberOfItems,
        (i) => Column(
          children: [
            Text(
              context.localizations.onBoardingTitle(i.toString()),
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 35,
                fontWeight: FontWeight.w600,
                color: Theme.of(context).primaryColor,
              ),
            ),
            const SizedBox(height: 20),
            Expanded(
              child: SvgPicture.asset(
                "assets/images/onboarding_${i + 1}.svg",
              ),
            ),
            const SizedBox(height: 20),
            Text(
              context.localizations.onBoardingDescription(i.toString()),
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w600,
                color: Theme.of(context).primaryColor,
              ),
            ),
          ],
        ),
      ),
      options: CarouselOptions(
        enableInfiniteScroll: false,
        height: double.infinity,
        viewportFraction: 1,
        onPageChanged: (i, _) => onIndicatorChanged(i),
      ),
      carouselController: controller,
    );
  }
}
