import 'package:capstone_project/model/user_model/user_model.dart';
import 'package:capstone_project/screens/components/card_widget.dart';
import 'package:capstone_project/themes/nomizo_theme.dart';
import 'package:capstone_project/utils/finite_state.dart';
import 'package:capstone_project/viewmodel/category_viewmodel/category_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CategoryModeratorScreen extends StatefulWidget {
  const CategoryModeratorScreen({Key? key}) : super(key: key);

  @override
  State<CategoryModeratorScreen> createState() =>
      _CategoryModeratorScreenState();
}

class _CategoryModeratorScreenState extends State<CategoryModeratorScreen> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      Provider.of<CategoryProvider>(context, listen: false).getModerator();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(
            Icons.keyboard_arrow_left,
          ),
        ),
        title: Consumer<CategoryProvider>(
          builder: (context, value, _) {
            return Text('Moderator di ${value.currentCategory.name}');
          },
        ),
      ),
      body: Consumer<CategoryProvider>(
        builder: (context, value, _) {
          if (value.state == FiniteState.loading) {
            return Center(
              child: CircularProgressIndicator(
                color: NomizoTheme.nomizoTosca.shade600,
              ),
            );
          }
          if (value.state == FiniteState.failed) {
            return const Center(
              child: Text('Something Wrong!!!'),
            );
          } else {
            if (value.moderators.isEmpty) {
              return const Center(child: Text('MODERATOR TIDAK ADA'));
            } else {
              return ListView.builder(
                itemCount: value.moderators.length,
                padding: const EdgeInsets.fromLTRB(16, 12, 16, 24),
                itemBuilder: (context, index) {
                  return userCard(
                    context,
                    UserModel(
                      iD: value.moderators[index].id,
                      profileImage: value.moderators[index].profileImage,
                      username: value.moderators[index].username,
                    ),
                  );
                },
              );
            }
          }
        },
      ),
    );
  }
}
