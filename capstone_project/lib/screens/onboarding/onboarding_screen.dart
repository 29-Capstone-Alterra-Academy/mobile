import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:capstone_project/provider/onboarding_provider.dart';
import 'package:capstone_project/screens/onboarding/onboarding_item.dart';

class OnboardingScreen extends StatelessWidget {
  const OnboardingScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    PageController controller = PageController();
    return Scaffold(
      body: Center(
        child: Consumer<OnboardingProvider>(builder: (context, value, _) {
          return Column(
            children: [
              const SizedBox(height: 20),

              /// Skip button
              Row(
                children: [
                  const Expanded(child: SizedBox(height: 10)),
                  IgnorePointer(
                    ignoring: !value.isSkip,
                    child: Opacity(
                      opacity: value.isSkip ? 1.0 : 0.0,
                      child: TextButton(
                        style: TextButton.styleFrom(
                          primary: const Color(0XFFF30030),
                          fixedSize: const Size(50, 20),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(25),
                          ),
                        ),
                        onPressed: () {
                          controller.animateToPage(
                            value.items.length - 1,
                            duration: const Duration(milliseconds: 300),
                            curve: Curves.linear,
                          );
                        },
                        child: const Text(
                          'Skip',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),
                ],
              ),

              /// Pageview
              Expanded(
                child: NotificationListener<OverscrollIndicatorNotification>(
                  onNotification: (overscroll) {
                    //Remove OverScroll Glow
                    overscroll.disallowIndicator();
                    return true;
                  },
                  child: PageView.builder(
                    itemCount: value.items.length,
                    controller: controller,
                    onPageChanged: (index) => value.changePage(index),
                    itemBuilder: (BuildContext context, int index) {
                      // load onboarding image, title, and subtitle
                      return OnboardingItem(provider: value, indexPage: index);
                    },
                  ),
                ),
              ),

              /// page indicator
              AnimatedSmoothIndicator(
                activeIndex: value.currentPage,
                count: value.items.length,
                effect: ScaleEffect(
                  dotWidth: 6.0,
                  dotHeight: 6.0,
                  spacing: 4.0,
                  dotColor: Colors.blue.shade100,
                  strokeWidth: 3.0,
                  activeDotColor: Colors.blue,
                ),
              ),
              const SizedBox(height: 10),

              /// Next/Prev Button
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  // Previous Button
                  IgnorePointer(
                    ignoring: !value.isPrev,
                    child: Opacity(
                      opacity: value.isPrev ? 1.0 : 0.0,
                      child: OutlinedButton(
                        style: OutlinedButton.styleFrom(
                          fixedSize: const Size(140, 42),
                          side: BorderSide.none,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(21),
                          ),
                        ),
                        onPressed: () {
                          controller.previousPage(
                            duration: const Duration(milliseconds: 300),
                            curve: Curves.linear,
                          );
                        },
                        child: const Text('Sebelumnya'),
                      ),
                    ),
                  ),
                  const SizedBox(width: 32),
                  // Next Button
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      fixedSize: const Size(140, 42),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(21),
                      ),
                    ),
                    onPressed: () {
                      if (value.currentPage == value.items.length - 1) {
                        log('Navigate to Login');
                      } else {
                        controller.nextPage(
                          duration: const Duration(milliseconds: 300),
                          curve: Curves.linear,
                        );
                      }
                    },
                    child: value.isSkip
                        ? const Text('Berikutnya')
                        : const Text('Masuk'),
                  ),
                ],
              ),
              const SizedBox(height: 32)
            ],
          );
        }),
      ),
    );
  }
}
