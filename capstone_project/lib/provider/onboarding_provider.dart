import 'package:flutter/material.dart';

class OnboardingProvider extends ChangeNotifier {
  final List<Widget> items = [
    Column(
      children: const [
        SizedBox(height: 20),
        // image
        FlutterLogo(
          size: 200,
        ),
        SizedBox(height: 45),
        // title
        Text(
          'Title 1',
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: 10),
        // subtitle
        Text(
          'Subtitle 1',
          style: TextStyle(color: Color(0XFF7C7C7C)),
        ),
      ],
    ),
    Column(
      children: const [
        SizedBox(height: 20),
        // image
        FlutterLogo(
          size: 200,
        ),
        SizedBox(height: 45),
        // title
        Text(
          'Title 2',
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: 10),
        // subtitle
        Text(
          'Subtitle 2',
          style: TextStyle(color: Color(0XFF7C7C7C)),
        ),
      ],
    ),
    Column(
      children: const [
        SizedBox(height: 20),
        // image
        FlutterLogo(
          size: 200,
        ),
        SizedBox(height: 45),
        // title
        Text(
          'Title 3',
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: 10),
        // subtitle
        Text(
          'Subtitle 3',
          style: TextStyle(color: Color(0XFF7C7C7C)),
        ),
      ],
    )
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
