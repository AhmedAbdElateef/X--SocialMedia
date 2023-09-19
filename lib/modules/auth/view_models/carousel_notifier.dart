import 'package:flutter/foundation.dart';
import 'package:carousel_slider/carousel_slider.dart';
//----------------------------------------------------
import 'package:social_x/core/ui/routes.dart';
import 'package:social_x/core/helpers/extensions/sailor.dart';
//-------------------------------------------------

class CarouselNotifier extends ValueNotifier<int> {
  CarouselNotifier(super.value);

  final carouselController = CarouselController();

  void handleOnFabPressed() {
    if (value < 2) {
      value++;
      carouselController.animateToPage(value);
    } else {
      Sailor.toNamed(AppRoutes.login);
    }
  }

  void changeCarouselIndicatorState(int newIndex) {
    value = newIndex;
  }
}
