// import package
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

// import screen file
import 'package:capstone_project/themes/nomizo_theme.dart';
import 'package:capstone_project/screens/onboarding/onboarding_item.dart';
import 'package:capstone_project/viewmodel/onboarding_viewmodel/onboarding_provider.dart';

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
              const SizedBox(height: 40),
              Container(
                width: MediaQuery.of(context).size.width,
                padding: const EdgeInsets.only(right: 10),
                alignment: Alignment.centerRight,
                child: IgnorePointer(
                  ignoring: !value.isSkip,
                  child: Opacity(
                    opacity: value.isSkip ? 1.0 : 0.0,
                    child: TextButton(
                      style: Theme.of(context).textButtonTheme.style?.copyWith(
                            foregroundColor: MaterialStateProperty.all(
                              NomizoTheme.nomizoRed.shade600,
                            ),
                            overlayColor: MaterialStateProperty.all(
                              NomizoTheme.nomizoRed.shade50,
                            ),
                            textStyle: MaterialStateProperty.all(
                              const TextStyle(fontWeight: FontWeight.w700),
                            ),
                          ),
                      onPressed: () {
                        Navigator.pushNamedAndRemoveUntil(
                            context, '/login', (route) => false);
                      },
                      child: const Text('Skip'),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 22),

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
              const SizedBox(height: 22),

              /// page indicator
              AnimatedSmoothIndicator(
                activeIndex: value.currentPage,
                count: value.items.length,
                effect: ScaleEffect(
                  scale: 1.5,
                  dotWidth: 6.0,
                  dotHeight: 6.0,
                  spacing: 4.0,
                  activeDotColor: Theme.of(context).primaryColor,
                  dotColor: NomizoTheme.nomizoTosca.shade50,
                ),
              ),
              const SizedBox(height: 10),

              /// Next/Prev Button
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // Previous Button
                    IgnorePointer(
                      ignoring: !value.isPrev,
                      child: Opacity(
                        opacity: value.isPrev ? 1.0 : 0.0,
                        child: TextButton(
                          style:
                              Theme.of(context).textButtonTheme.style?.copyWith(
                                    fixedSize: MaterialStateProperty.all(
                                      const Size(140, 42),
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
                    const Expanded(child: SizedBox(width: 32)),
                    // Next Button
                    ElevatedButton(
                      style: Theme.of(context)
                          .elevatedButtonTheme
                          .style
                          ?.copyWith(
                            fixedSize:
                                MaterialStateProperty.all(const Size(140, 42)),
                          ),
                      onPressed: () {
                        if (value.currentPage == value.items.length - 1) {
                          Navigator.pushNamedAndRemoveUntil(
                              context, '/login', (route) => false);
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
              ),
              const SizedBox(height: 32),
            ],
          );
        }),
      ),
    );
  }
}
