import 'package:flutter/material.dart';
//-------------------------------------
import 'package:social_x/core/ui/styles.dart';
import 'package:social_x/core/ui/components/carousel_indicator.dart';
//-------------------------------------------------------------------
import 'package:social_x/modules/auth/view_models//carousel_notifier.dart';
import 'package:social_x/modules/auth/views/widgets/onboarding_carousel.dart';
//----------------------------------------------------------------------------

class OnBoardingScreen extends StatefulWidget {
  const OnBoardingScreen({super.key});

  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  final notifier = CarouselNotifier(0);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        floatingActionButton: FloatingActionButton(
          backgroundColor: Theme.of(context).primaryColor,
          onPressed: () => notifier.handleOnFabPressed(),
          child: const Icon(Icons.arrow_forward_ios_outlined),
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 24,
            vertical: 40,
          ),
          child: Column(
            children: [
              Expanded(
                child: OnboardingCarousel(
                  numberOfItems: 3,
                  controller: notifier.carouselController,
                  onIndicatorChanged: (int i) {
                    notifier.changeCarouselIndicatorState(i);
                  },
                ),
              ),
              const SizedBox(height: 24),
              ValueListenableBuilder<int>(
                valueListenable: notifier,
                builder: (_, currentIndex, __) {
                  return PaginationIndex(
                    numberOfItems: 3,
                    activeIndex: currentIndex,
                  );
                },
              ),
              AppStyles.screenBottomSpace,
            ],
          ),
        ),
      ),
    );
  }
}
