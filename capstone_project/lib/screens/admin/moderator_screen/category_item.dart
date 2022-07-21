import 'package:capstone_project/model/category_model/category_model.dart';
import 'package:capstone_project/screens/admin/moderator_screen/moderator_category_screen.dart';
import 'package:capstone_project/screens/components/card_widget.dart';
import 'package:capstone_project/themes/nomizo_theme.dart';
import 'package:flutter/material.dart';

class CategoryItem extends StatefulWidget {
  final CategoryModel categoryModel;
  const CategoryItem({
    Key? key,
    required this.categoryModel,
  }) : super(key: key);

  @override
  State<CategoryItem> createState() => _CategoryItemState();
}

class _CategoryItemState extends State<CategoryItem> {
  late final CategoryModel categoryModel;
  @override
  void initState() {
    categoryModel = widget.categoryModel;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) =>
                ModeratorCategoryScreen(categoryModel: categoryModel),
          ),
        );
      },
      child: Container(
        color: NomizoTheme.nomizoDark.shade50,
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
        child: Row(
          children: [
            // image
            circlePic(52, categoryModel.profileImage ?? ''),
            const SizedBox(width: 8),
            // content
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // title
                  Text(
                    categoryModel.name ?? '',
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          fontWeight: FontWeight.w500,
                        ),
                  ),
                  const SizedBox(height: 2),
                  // subtitle
                  Text(
                    '${categoryModel.activityCount} Postingan',
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: NomizoTheme.nomizoDark.shade500,
                        ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
