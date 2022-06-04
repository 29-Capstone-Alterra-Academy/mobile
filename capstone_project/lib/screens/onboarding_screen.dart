import 'dart:developer';

import 'package:capstone_project/provider/onboarding_provider.dart';
import 'package:flutter/material.dart';
import 'package:page_indicator/page_indicator.dart';
import 'package:provider/provider.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({Key? key}) : super(key: key);

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController controller = PageController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Consumer<OnboardingProvider>(builder: (context, value, _) {
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(height: 20),
              // SKip button
              Row(
                children: [
                  const Expanded(child: SizedBox(height: 10)),
                  Consumer<OnboardingProvider>(builder: (context, value, _) {
                    return IgnorePointer(
                      ignoring: !value.isSkip,
                      child: Opacity(
                        opacity: value.isSkip ? 1.0 : 0.0,
                        child: TextButton(
                          style: TextButton.styleFrom(
                            fixedSize: const Size(50, 20),
                          ),
                          onPressed: () {
                            controller.animateToPage(
                              value.items.length - 1,
                              duration: const Duration(milliseconds: 200),
                              curve: Curves.linear,
                            );
                          },
                          child: const Text('Skip'),
                        ),
                      ),
                    );
                  }),
                  const SizedBox(width: 10),
                ],
              ),

              /// Pageview
              Expanded(
                child: PageIndicatorContainer(
                  length: value.items.length,
                  indicatorSpace: 5.0,
                  padding: const EdgeInsets.all(5.0),
                  indicatorColor: Colors.blue.shade100,
                  indicatorSelectorColor: Colors.blue,
                  shape: IndicatorShape.circle(size: 8),
                  child: PageView.builder(
                    itemCount: value.items.length,
                    controller: controller,
                    onPageChanged: (index) => value.changePage(index),
                    itemBuilder: (BuildContext context, int index) {
                      return value.items[index];
                    },
                  ),
                ),
              ),
              const SizedBox(height: 15),

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
                  const SizedBox(width: 10),
                  // Next Button
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      fixedSize: const Size(140, 42),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(21),
                      ),
                    ),
                    onPressed: () {
                      controller.nextPage(
                        duration: const Duration(milliseconds: 300),
                        curve: Curves.linear,
                      );
                    },
                    child: value.isSkip
                        ? const Text('Berikutnya')
                        : const Text('Masuk'),
                  ),
                ],
              ),
              const SizedBox(height: 20)
            ],
          );
        }),
      ),
    );
  }
}

// List<Widget> onboarding_items = [
//   Column(

//   )
// ];
