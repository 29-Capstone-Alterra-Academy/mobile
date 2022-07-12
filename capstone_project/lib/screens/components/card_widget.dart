// import package
import 'package:capstone_project/modelview/upload_provider.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

// import model
import 'package:capstone_project/model/user_model.dart';
import 'package:capstone_project/model/category_model.dart';

// import theme & component
import 'package:capstone_project/themes/nomizo_theme.dart';
import 'package:capstone_project/screens/components/button_widget.dart';

// import provider
import 'package:provider/provider.dart';
import 'package:capstone_project/modelview/user_provider.dart';
import 'package:capstone_project/modelview/category_provider.dart';

// import screen
import 'package:capstone_project/screens/search_screen/detail_user/detail_user_screen.dart';
import 'package:capstone_project/screens/search_screen/detail_category/detail_category_screen.dart';

/// CIRCLE PICTURE
Widget circlePic(double size, String img) {
  return Container(
    width: size,
    height: size,
    decoration: BoxDecoration(
      shape: BoxShape.circle,
      color: NomizoTheme.nomizoDark.shade50,
      border: Border.all(width: 1, color: NomizoTheme.nomizoDark.shade100),
    ),
    clipBehavior: Clip.antiAlias,
    child: Image.network(
      img,
      errorBuilder: (context, error, stackTrace) => Padding(
        padding: const EdgeInsets.fromLTRB(8, 8, 4, 8),
        child: Image.asset('assets/img/app_logo.png', fit: BoxFit.contain),
      ),
      fit: BoxFit.cover,
    ),
  );
}

/// SELECT CATEGORY CARD
Widget selectCategory(
  BuildContext context,
  CategoryModel categoryModel,
  UploadProvider uploadProvider,
) {
  final provider = Provider.of<CategoryProvider>(context, listen: false);
  return InkWell(
    onTap: () {
      uploadProvider.selectCategory(categoryModel);
      Navigator.pop(context);
    },
    child: Container(
      height: 60,
      padding: const EdgeInsets.all(4),
      child: Row(
        children: [
          // image
          circlePic(52, categoryModel.profileImage!),
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
          const SizedBox(width: 8),
          // button
          Consumer<CategoryProvider>(builder: (context, value, _) {
            if (value.isSub) {
              return outlinedBtn28(context, () async {
                buildLoading(context);
                await provider
                    .unsubscribeCategory(value.currentCategory.id ?? 9)
                    .then((value) => Navigator.pop(context));
              }, 'Mengikuti');
            }
            return elevatedBtn28(context, () async {
              buildLoading(context);
              provider
                  .subscribeCategory(value.currentCategory.id ?? 9)
                  .then((value) => Navigator.pop(context));
            }, 'Ikuti');
          }),
        ],
      ),
    ),
  );
}

/// CATEGORY CARD
Widget categoryCard(BuildContext context, CategoryModel categoryModel) {
  final provider = Provider.of<CategoryProvider>(context, listen: false);
  return InkWell(
    onTap: () {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (_) => DetailCategoryScreen(
            idCategory: categoryModel.id ?? 1,
          ),
        ),
      );
    },
    child: Container(
      height: 60,
      padding: const EdgeInsets.all(4),
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
          const SizedBox(width: 8),
          // button
          Consumer<CategoryProvider>(builder: (context, value, _) {
            if (value.isSub) {
              return outlinedBtn28(context, () async {
                buildLoading(context);
                await provider
                    .unsubscribeCategory(value.currentCategory.id ?? 9)
                    .then((value) => Navigator.pop(context));
              }, 'Mengikuti');
            }
            return elevatedBtn28(context, () async {
              buildLoading(context);
              provider
                  .subscribeCategory(value.currentCategory.id ?? 9)
                  .then((value) => Navigator.pop(context));
            }, 'Ikuti');
          }),
        ],
      ),
    ),
  );
}

/// USER CARD
Widget userCard(BuildContext context, UserModel userModel) {
  final provider = Provider.of<UserProvider>(context, listen: false);
  return InkWell(
    onTap: () {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (_) => DetailUserScreen(
            idUser: userModel.id ?? 1,
          ),
        ),
      );
    },
    child: Container(
      height: 65,
      padding: const EdgeInsets.all(4),
      child: Row(
        children: [
          // image
          circlePic(52, userModel.profileImage ?? ''),
          const SizedBox(width: 8),
          // content
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // title
                Text(
                  '@${userModel.username!}',
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        fontWeight: FontWeight.w500,
                      ),
                ),
                const SizedBox(height: 2),
                // subtitle
                Text(
                  'Nama Moderator',
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: NomizoTheme.nomizoDark.shade500,
                      ),
                ),
                const SizedBox(height: 2),
                // subtitle2
                Text(
                  'Jumlah Folower',
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: NomizoTheme.nomizoDark.shade500,
                      ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 8),
          // button
          Consumer<UserProvider>(builder: (context, value, _) {
            if (value.isSub) {
              return outlinedBtn28(context, () async {
                buildLoading(context);
                await provider
                    .unfollowUser(value.selectedUser!.id ?? 9)
                    .then((value) => Navigator.pop(context));
              }, 'Mengikuti');
            }
            return elevatedBtn28(context, () async {
              buildLoading(context);
              provider
                  .followUser(value.selectedUser!.id ?? 9)
                  .then((value) => Navigator.pop(context));
            }, 'Ikuti');
          }),
        ],
      ),
    ),
  );
}

/// HORIZONTAL DIVIDER
Widget buildDivider() {
  return Divider(
    height: 1,
    thickness: 1,
    color: NomizoTheme.nomizoDark.shade100,
  );
}

/// DOT DIVIDER
Widget buildDotDivider() {
  return Container(
    width: 2,
    height: 2,
    margin: const EdgeInsets.symmetric(horizontal: 4),
    decoration: BoxDecoration(
      shape: BoxShape.circle,
      color: NomizoTheme.nomizoDark.shade500,
    ),
  );
}

/// SHOW BOTTOM SHEET FOR MORE MENU
void showMoreMenu(BuildContext context, Widget widget) {
  showModalBottomSheet(
    isScrollControlled: true,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(
        top: Radius.circular(16),
      ),
    ),
    context: context,
    builder: (context) {
      return widget;
    },
  );
}

/// SHOW LOADING INDICATOR
void buildLoading(BuildContext context) {
  showDialog(
    context: context,
    builder: (context) => const Center(
      child: CircularProgressIndicator(),
    ),
  );
}

/// SEARCH NOT FOUND
Widget notFound(BuildContext context) {
  return Center(
      child: Column(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      Image.asset('assets/img/not_found.png'),
      const SizedBox(height: 18),
      Text(
        'Oops, Maaf !',
        style: Theme.of(context).textTheme.titleMedium?.copyWith(
              color: NomizoTheme.nomizoRed.shade600,
              fontWeight: FontWeight.w600,
            ),
      ),
      Text(
        'Pencarian tidak ditemukan',
        style: Theme.of(context).textTheme.bodyMedium,
      ),
    ],
  ));
}

/// BUILD TOAST MESSAGE
void buildToast(String message) {
  Fluttertoast.showToast(
    msg: message,
    toastLength: Toast.LENGTH_SHORT,
    gravity: ToastGravity.BOTTOM,
    timeInSecForIosWeb: 1,
    backgroundColor: NomizoTheme.nomizoDark.shade700,
    textColor: Colors.white,
    fontSize: 12,
  );
}
