import 'package:capstone_project/model/category_model.dart';
import 'package:capstone_project/model/user_model.dart';
import 'package:capstone_project/screens/components/card_widget.dart';
import 'package:capstone_project/themes/nomizo_theme.dart';
import 'package:flutter/material.dart';

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
      body: ListView.builder(
        itemCount: 2,
        padding: const EdgeInsets.only(top: 12),
        itemBuilder: (context, index) {
          return moderatorItem(
            userModel: UserModel(
                iD: 9,
                profileImage: '',
                username: 'Map95'),
          );
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
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // username
              Text(
                '@${userModel.username}',
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      fontWeight: FontWeight.w500,
                    ),
              ),
              // fullname
              Text(
                'Rowmapto',
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: NomizoTheme.nomizoDark.shade500,
                    ),
              ),
              // followers
              Text(
                '877 Ribu Pengikut',
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      color: NomizoTheme.nomizoDark.shade500,
                    ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
