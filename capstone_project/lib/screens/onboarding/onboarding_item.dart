import 'package:flutter/material.dart';
import 'package:capstone_project/provider/onboarding_provider.dart';

class OnboardingItem extends StatefulWidget {
  final OnboardingProvider provider;
  final int indexPage;

  const OnboardingItem({
    Key? key,
    required this.provider,
    required this.indexPage,
  }) : super(key: key);

  @override
  State<OnboardingItem> createState() => _OnboardingItemState();
}

class _OnboardingItemState extends State<OnboardingItem> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const SizedBox(height: 20),
        // image
        Image.asset(
          widget.provider.items[widget.indexPage]['image'],
          width: 200,
          height: 200,
          fit: BoxFit.contain,
        ),
        const SizedBox(height: 42),
        // title
        Text(
          widget.provider.items[widget.indexPage]['title'],
          style: const TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: 18,
          ),
        ),
        const SizedBox(height: 10),
        // subtitle
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 14),
          child: Text(
            widget.provider.items[widget.indexPage]['subtitle'],
            textAlign: TextAlign.center,
            style: const TextStyle(
              color: Color(0XFF7C7C7C),
              fontSize: 14,
            ),
          ),
        ),
      ],
    );
  }
}
