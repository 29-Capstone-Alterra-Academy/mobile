import 'package:flutter/material.dart';

class ModeratorScreen extends StatelessWidget {
  const ModeratorScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text('Moderator'),
      ),
    );
  }
}
