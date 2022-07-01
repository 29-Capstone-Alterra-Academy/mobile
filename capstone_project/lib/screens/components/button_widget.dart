import 'package:flutter/material.dart';

Widget buttonSmall28(
  BuildContext context,
  void Function()? function,
  String text,
) {
  return SizedBox(
    height: 28,
    child: ElevatedButton(
      onPressed: function,
      style: Theme.of(context).elevatedButtonTheme.style?.copyWith(
            fixedSize: MaterialStateProperty.all(const Size(82, 28)),
            textStyle: MaterialStateProperty.all(
              Theme.of(context).textTheme.bodySmall?.copyWith(
                    fontWeight: FontWeight.w500,
                  ),
            ),
          ),
      child: Text(text),
    ),
  );
}

/// Button (150, 42)
Widget buttonMedium42(
  BuildContext context,
  void Function()? function,
  String text,
) {
  return ElevatedButton(
    onPressed: function,
    style: Theme.of(context).elevatedButtonTheme.style?.copyWith(
          fixedSize: MaterialStateProperty.all(const Size(150, 42)),
        ),
    child: Text(text),
  );
}
