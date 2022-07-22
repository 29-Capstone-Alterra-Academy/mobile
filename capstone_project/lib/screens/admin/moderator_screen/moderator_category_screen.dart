import 'package:capstone_project/model/category_model/category_model.dart';
import 'package:capstone_project/model/user_model/user_model.dart';
import 'package:capstone_project/screens/components/card_widget.dart';
import 'package:capstone_project/themes/nomizo_theme.dart';
import 'package:capstone_project/utils/finite_state.dart';
import 'package:capstone_project/viewmodel/admin_viewmodel/admin_moderator_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ModeratorCategoryScreen extends StatefulWidget {
  final CategoryModel categoryModel;
  const ModeratorCategoryScreen({Key? key, required this.categoryModel})
      : super(key: key);

  @override
  State<ModeratorCategoryScreen> createState() =>
      _ModeratorCategoryScreenState();
}

class _ModeratorCategoryScreenState extends State<ModeratorCategoryScreen> {
  late final CategoryModel categoryModel;

  @override
  void initState() {
    categoryModel = widget.categoryModel;
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      Provider.of<AdminModeratorProvider>(context, listen: false)
          .getModerator(categoryModel.id!);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: const Icon(
            Icons.keyboard_arrow_left,
          ),
        ),
        title: Text('Moderator di ${categoryModel.name}'),
      ),
      body: Consumer<AdminModeratorProvider>(
        builder: (context, value, _) {
          if (value.state == FiniteState.loading) {
            return Center(
              child: CircularProgressIndicator(
                color: NomizoTheme.nomizoTosca.shade600,
              ),
            );
          } else {
            if (value.moderators.isEmpty) {
              return const Center(
                child: Text('Tidak ada moderator'),
              );
            } else {
              return ListView.builder(
                itemCount: value.moderators.length,
                padding: const EdgeInsets.only(top: 12),
                itemBuilder: (context, index) {
                  return moderatorItem(
                    userModel: UserModel(
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

  // Moderator item
  Widget moderatorItem({required UserModel userModel}) {
    return Container(
      width: MediaQuery.of(context).size.width,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      child: Row(
        children: [
          // Profile Picture
          circlePic(52, userModel.profileImage ?? ''),
          const SizedBox(width: 12),
          // Profile Detail
          Text(
            '@${userModel.username}',
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  fontWeight: FontWeight.w500,
                ),
          ),
        ],
      ),
    );
  }
}
