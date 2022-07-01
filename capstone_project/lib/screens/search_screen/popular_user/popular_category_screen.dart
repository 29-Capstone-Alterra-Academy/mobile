import 'package:flutter/material.dart';

class PopularUserScreen extends StatelessWidget {
  const PopularUserScreen({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('User Populer'),
      ),
    );
  }
}