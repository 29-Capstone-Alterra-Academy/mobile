import 'package:flutter/material.dart';

class OnboardingProvider extends ChangeNotifier {
  final List<Map<String, dynamic>> items = [
    {
      'image': 'assets/img/onboarding/onboarding1.png',
      'title': 'Free speech platform',
      'subtitle':
          'Nomizo memberikan kesempatan bagi anda untuk\nberpendapat secara bebas selama tanpa ada\nunsur ujaran kebencian',
    },
    {
      'image': 'assets/img/onboarding/onboarding2.png',
      'title': 'Saving your time',
      'subtitle':
          'Nomizo membantu anda untuk menghemat waktu\nyang anda butuhkan saat anda berdiskusi',
    },
    {
      'image': 'assets/img/onboarding/onboarding3.png',
      'title': 'Find ideas',
      'subtitle':
          'Nomizo memudahkan anda dalam mencari\nsebuah ide yang anda butuhkan',
    },
  ];

  int currentPage = 0;
  bool isSkip = true;
  bool isPrev = false;

  void changePage(int index) {
    currentPage = index;
    if (index == 0) {
      isPrev = false;
      isSkip = true;
    } else if (index == items.length - 1) {
      isPrev = true;
      isSkip = false;
    } else {
      isPrev = true;
      isSkip = true;
    }
    notifyListeners();
  }
}
