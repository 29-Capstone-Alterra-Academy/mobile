// import package
import 'package:capstone_project/model/search_model/search_history_model.dart';
import 'package:capstone_project/viewmodel/search_viewmodel/search_history_provider.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

// import model
import 'package:capstone_project/model/user_model/user_model.dart';
import 'package:capstone_project/model/category_model/category_model.dart';
import 'package:capstone_project/model/search_model/search_category_model.dart';

// import theme & component
import 'package:capstone_project/themes/nomizo_theme.dart';
import 'package:capstone_project/screens/components/button_widget.dart';

// import provider
import 'package:provider/provider.dart';
import 'package:capstone_project/viewmodel/user_viewmodel/user_provider.dart';
import 'package:capstone_project/viewmodel/thread_viewmodel/upload_provider.dart';
import 'package:capstone_project/viewmodel/category_viewmodel/category_provider.dart';

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
      fit: BoxFit.cover,
      loadingBuilder: (context, child, loadingProgress) {
        if (loadingProgress == null) return child;
        return const Center(
          child: Padding(
            padding: EdgeInsets.all(20.0),
            child: CircularProgressIndicator(),
          ),
        );
      },
      errorBuilder: (context, error, stackTrace) => Padding(
        padding: const EdgeInsets.fromLTRB(8, 8, 4, 8),
        child: Image.asset('assets/img/app_logo.png', fit: BoxFit.contain),
      ),
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
                  '${categoryModel.activityCount ?? 0} Aktivitas',
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
            idUser: userModel.iD ?? 1,
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
                  '@${userModel.username}',
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        fontWeight: FontWeight.w500,
                      ),
                ),
                const SizedBox(height: 2),
                // subtitle
                if (userModel.threadCount != null)
                  Text(
                    '${userModel.threadCount ?? 0} Postingan',
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: NomizoTheme.nomizoDark.shade500,
                        ),
                  ),
                const SizedBox(height: 2),
                // subtitle2
                Text(
                  '${userModel.followersCount} Pengikut',
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
                    .unfollowUser(value.selectedUser!.iD!)
                    .then((value) => Navigator.pop(context));
              }, 'Mengikuti');
            }
            return elevatedBtn28(context, () async {
              buildLoading(context);
              provider
                  .followUser(value.selectedUser!.iD!)
                  .then((value) => Navigator.pop(context));
            }, 'Ikuti');
          }),
        ],
      ),
    ),
  );
}

/// SEARCH CATEGORY CARD
Widget searchCategoryCard(
    BuildContext context, SearchCategoryModel categoryModel) {
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
                  '${categoryModel.threadCount ?? 0} Postingan',
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

Widget searchHistoryCard(BuildContext context, SearchHistoryModel history) {
  final provider = Provider.of<SearchHistoryProvider>(context, listen: false);
  return Container(
    height: 28,
    padding: const EdgeInsets.symmetric(vertical: 2),
    child: Row(
      children: [
        const Icon(Icons.schedule, size: 24),
        const SizedBox(width: 8),
        Expanded(
            child: Text(history.keyword!,
                style: Theme.of(context).textTheme.bodyMedium)),
        const SizedBox(width: 8),
        InkWell(
          onTap: () {
            provider.removeHistory(history.id!);
          },
          child: const Icon(Icons.close, size: 18),
        ),
      ],
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

/// ADMIN BLOCK CONFIRMATION
Widget blockConfirmation({
  required BuildContext context,
  required String title,
  required String subtitle,
  required String button1,
  required String button2,
  required void Function()? function,
}) {
  return AlertDialog(
    contentPadding: const EdgeInsets.symmetric(
      horizontal: 16,
      vertical: 16,
    ),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(16),
    ),
    content: Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          height: 24,
          width: MediaQuery.of(context).size.width,
          alignment: Alignment.centerRight,
          child: InkWell(
            onTap: () => Navigator.pop(context),
            child: const Icon(Icons.close),
          ),
        ),
        const SizedBox(height: 18),
        Image.asset(
          'assets/img/confirmation.png',
          width: 168,
          height: 120,
        ),
        const SizedBox(height: 18),
        Text(
          title,
          textAlign: TextAlign.center,
          style: Theme.of(context).textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.w600,
              ),
        ),
        Text(
          subtitle,
          textAlign: TextAlign.center,
          style: Theme.of(context).textTheme.bodyMedium,
        ),
        const SizedBox(height: 18),
      ],
    ),
    actions: [
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          OutlinedButton(
            onPressed: () => Navigator.pop(context),
            style: Theme.of(context).outlinedButtonTheme.style?.copyWith(
                  fixedSize: MaterialStateProperty.all(const Size(100, 42)),
                ),
            child: Text(button1),
          ),
          ElevatedButton(
            onPressed: function,
            style: Theme.of(context).elevatedButtonTheme.style?.copyWith(
                  fixedSize: MaterialStateProperty.all(const Size(100, 42)),
                ),
            child: Text(button2),
          ),
        ],
      ),
    ],
  );
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
