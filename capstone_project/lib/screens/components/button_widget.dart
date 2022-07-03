import 'package:capstone_project/themes/nomizo_theme.dart';
import 'package:flutter/material.dart';

/// Elevatedbutton (82, 28)
Widget elevatedBtn28(
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

/// Elevatedbutton (150, 42)
Widget elevatedBtn42(
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

/// Long Elevatedbutton (screen width, 42)
Widget elevatedBtnLong42(
  BuildContext context,
  void Function()? function,
  String text,
) {
  double width = MediaQuery.of(context).size.width;
  return ElevatedButton(
    onPressed: function,
    style: Theme.of(context).elevatedButtonTheme.style?.copyWith(
          fixedSize: MaterialStateProperty.all(Size(width, 42)),
        ),
    child: Text(text),
  );
}

/// Outlinedbutton (82, 28)
Widget outlinedBtn28(
  BuildContext context,
  void Function()? function,
  String text,
) {
  return OutlinedButton(
    onPressed: function,
    style: Theme.of(context).outlinedButtonTheme.style?.copyWith(
          side: MaterialStateProperty.all(
              BorderSide(width: 1, color: NomizoTheme.nomizoTosca.shade600)),
          fixedSize: MaterialStateProperty.all(const Size(82, 28)),
          textStyle: MaterialStateProperty.all(
            Theme.of(context).textTheme.bodySmall?.copyWith(
                  fontWeight: FontWeight.w500,
                ),
          ),
        ),
    child: Text(text),
  );
}

/// Outlinedbutton (150, 42)
Widget outlinedBtn42(
  BuildContext context,
  void Function()? function,
  String text,
) {
  return OutlinedButton(
    onPressed: function,
    style: Theme.of(context).outlinedButtonTheme.style?.copyWith(
          side: MaterialStateProperty.all(
              BorderSide(width: 1, color: NomizoTheme.nomizoTosca.shade600)),
          fixedSize: MaterialStateProperty.all(const Size(150, 42)),
        ),
    child: Text(text),
  );
}
