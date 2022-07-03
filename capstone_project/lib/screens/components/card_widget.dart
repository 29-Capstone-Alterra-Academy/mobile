import 'dart:developer';

// import package
import 'package:capstone_project/modelview/upload_provider.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:timeago/timeago.dart' as timeago;

// import model
import 'package:capstone_project/model/user_model.dart';
import 'package:capstone_project/model/thread_model.dart';
import 'package:capstone_project/model/category_model.dart';

// import theme & component
import 'package:capstone_project/themes/nomizo_theme.dart';
import 'package:capstone_project/screens/components/button_widget.dart';

// import provider
import 'package:provider/provider.dart';
import 'package:capstone_project/modelview/user_provider.dart';
import 'package:capstone_project/modelview/profile_provider.dart';
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
            categoryModel: categoryModel,
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

/// USER CARD
Widget userCard(BuildContext context, UserModel userModel) {
  final provider = Provider.of<UserProvider>(context, listen: false);
  return InkWell(
    onTap: () {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (_) => DetailUserScreen(
            userModel: userModel,
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
          circlePic(52, userModel.profileImage!),
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
    color: NomizoTheme.nomizoDark.shade100,
  );
}

/// REPORT REASON MODALBOTTOMSHEET
Widget reportCard(BuildContext context, String type) {
  List<String> reportCause = [
    'Spam',
    'Aktivitas seksual',
    'Ujaran kebencian',
    'Penipuan',
    'Informasi palsu',
    'Kekerasan',
    'Membahas hal melawan hukum',
    'Melanggar hak cipta',
    'Saya hanya tidak menyukainya',
    'Lainnya',
  ];
  return Container(
    decoration: const BoxDecoration(
        borderRadius: BorderRadius.only(topLeft: Radius.circular(16))),
    child: SingleChildScrollView(
      child: Column(
        children: [
          const SizedBox(height: 8),
          Container(
            width: 50,
            height: 2,
            color: NomizoTheme.nomizoDark.shade600,
          ),
          const SizedBox(height: 12),
          Container(
            height: 42,
            width: MediaQuery.of(context).size.width,
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Center(
              child: Text(
                'Laporkan',
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                      fontWeight: FontWeight.w700,
                    ),
              ),
            ),
          ),
          buildDivider(),
          Container(
            height: 42,
            width: MediaQuery.of(context).size.width,
            padding: const EdgeInsets.symmetric(horizontal: 16),
            alignment: Alignment.centerLeft,
            child: Text(
              'Mengapa Anda melaporkan postingan ini?',
              style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
            ),
          ),
          buildDivider(),
          // menu
          ListView.separated(
            separatorBuilder: (context, index) => buildDivider(),
            itemCount: 10,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemBuilder: (context, index) {
              return bottomSheetMenu(
                context,
                reportCause[index],
                reportFunction(context, type, reportCause[index]),
              );
            },
          ),
          const SizedBox(height: 10),
        ],
      ),
    ),
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

/// RETURN REPORT FUNCTION BY REPORT TYPE (category/user/thread/reply)
void Function()? reportFunction(
    BuildContext context, String type, String reason) {
  void Function()? reportFunction;
  switch (type) {
    case "category":
      final provider = Provider.of<CategoryProvider>(context, listen: false);
      reportFunction = () async {
        buildLoading(context);
        await provider.reportCategory(provider.currentCategory, reason).then(
          (value) {
            Navigator.pop(context);
            Navigator.pop(context);
            buildToast(value);
          },
        );
      };
      break;
    case "user":
      final provider = Provider.of<UserProvider>(context, listen: false);
      final reporter = Provider.of<ProfileProvider>(context, listen: false);
      reportFunction = () async {
        buildLoading(context);
        await provider
            .reportUser(
          reporter.currentUser!,
          provider.selectedUser!,
          reason,
        )
            .then(
          (value) {
            Navigator.pop(context);
            Navigator.pop(context);
            buildToast(value);
          },
        );
      };
      break;
    case "thread":
      break;
    case "reply":
      break;
    default:
      final provider = Provider.of<CategoryProvider>(context, listen: false);
      reportFunction = () async {
        showDialog(
            context: context,
            builder: (context) =>
                const Center(child: CircularProgressIndicator()));
        await provider.reportCategory(provider.currentCategory, reason).then(
          (value) {
            Navigator.pop(context);
            Navigator.pop(context);
            buildToast(value);
          },
        );
      };
  }
  return reportFunction;
}

/// MAIN MODALBOTTOMSHEET for Report / Follow Menu
Widget bottomSheetCard(
  BuildContext context,
  List<String> lables,
  List<void Function()?> functions,
) {
  return Container(
    decoration: const BoxDecoration(
        borderRadius: BorderRadius.only(topLeft: Radius.circular(16))),
    child: SingleChildScrollView(
      child: Column(
        children: [
          const SizedBox(height: 8),
          Container(
            width: 50,
            height: 2,
            color: NomizoTheme.nomizoDark.shade600,
          ),
          // menu
          ListView.separated(
            separatorBuilder: (context, index) => buildDivider(),
            itemCount: lables.length,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemBuilder: (context, index) {
              return bottomSheetMenu(context, lables[index], functions[index]);
            },
          ),
          const SizedBox(height: 10),
        ],
      ),
    ),
  );
}

/// MODALBOTTOMSHEET MENU
Widget bottomSheetMenu(
    BuildContext context, String label, void Function()? function) {
  return InkWell(
    onTap: function,
    child: Column(
      children: [
        Container(
          height: 42,
          width: MediaQuery.of(context).size.width,
          padding: const EdgeInsets.symmetric(horizontal: 16),
          alignment: Alignment.centerLeft,
          child: Text(
            label,
            style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                  fontWeight: FontWeight.w500,
                ),
          ),
        ),
      ],
    ),
  );
}

/// THREAD CARD
Widget threadCard(BuildContext context, ThreadModel threadModel) {
  var tempDate = '2019-11-20T00:00:00.000+00:00';
  var convert = DateTime.parse(tempDate);
  var difference = DateTime.now().difference(convert);
  var ago = DateTime.now().subtract(difference);

  return InkWell(
    onTap: () {},
    child: Container(
      padding: const EdgeInsets.all(16),
      color: NomizoTheme.nomizoDark.shade50,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // head thread
          Row(
            children: [
              // profile pic
              circlePic(42, threadModel.author!.profileImage!),
              const SizedBox(width: 7),
              // title
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // posted by
                    Row(
                      children: [
                        SizedBox(
                          width: 75,
                          child: Text(
                            threadModel.topic!.name!,
                            style: Theme.of(context)
                                .textTheme
                                .bodyMedium
                                ?.copyWith(
                                  fontWeight: FontWeight.w500,
                                ),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        Container(
                          width: 2,
                          height: 2,
                          margin: const EdgeInsets.symmetric(horizontal: 4),
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: NomizoTheme.nomizoDark.shade500,
                          ),
                        ),
                        Expanded(
                          child: Text(
                            'diposting oleh @${threadModel.author!.username}',
                            style:
                                Theme.of(context).textTheme.bodySmall?.copyWith(
                                      color: NomizoTheme.nomizoDark.shade500,
                                      fontWeight: FontWeight.w500,
                                    ),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),
                    // post time
                    Row(
                      children: [
                        Text(
                          timeago.format(ago, locale: 'id'),
                          style:
                              Theme.of(context).textTheme.bodySmall?.copyWith(
                                    color: NomizoTheme.nomizoDark.shade500,
                                  ),
                          overflow: TextOverflow.ellipsis,
                        ),
                        Container(
                          width: 2,
                          height: 2,
                          margin: const EdgeInsets.symmetric(horizontal: 4),
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: NomizoTheme.nomizoDark.shade500,
                          ),
                        ),
                        Text(
                          'diposting',
                          style:
                              Theme.of(context).textTheme.bodySmall?.copyWith(
                                    color: NomizoTheme.nomizoDark.shade500,
                                  ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              // more
              IconButton(
                onPressed: () {
                  showModalBottomSheet(
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.vertical(
                        top: Radius.circular(16),
                      ),
                    ),
                    context: context,
                    builder: (context) {
                      return bottomSheetCard(
                        context,
                        ['Laporkan'],
                        [
                          () {
                            log('Laporkan Thread berhasil');
                          }
                        ],
                      );
                    },
                  );
                },
                icon: Icon(
                  Icons.more_horiz,
                  color: NomizoTheme.nomizoDark.shade900,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          // thread content
          SizedBox(
            width: MediaQuery.of(context).size.width,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // title
                Text(
                  threadModel.title ?? '...',
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.w500,
                      ),
                ),
                const SizedBox(height: 4),
                // content
                Text(
                  '${threadModel.content}',
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
              ],
            ),
          ),
          const SizedBox(height: 12),
          // image
          if (threadModel.images!.isNotEmpty)
            CarouselSlider.builder(
              itemCount: threadModel.images!.length,
              itemBuilder: (context, itemIndex, pageViewIndex) {
                return Image.network(
                  threadModel.images![itemIndex],
                  errorBuilder: (context, error, stackTrace) {
                    return Image.network(
                        'https://picsum.photos/seed/picsum/300/200');
                  },
                  fit: BoxFit.cover,
                );
              },
              options: CarouselOptions(
                enableInfiniteScroll: false,
              ),
            ),
          const SizedBox(height: 12),
          // like / dislike / comment / share
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              // comment
              InkWell(
                onTap: () {
                  Navigator.pushNamed(context, '/detailPost');
                },
                child: Row(
                  children: [
                    const Icon(Icons.comment_outlined),
                    const SizedBox(width: 4),
                    Text(
                      '999',
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                            fontWeight: FontWeight.w500,
                          ),
                    ),
                  ],
                ),
              ),
              // like
              InkWell(
                onTap: () {},
                child: Row(
                  children: [
                    const Icon(Icons.thumb_up_outlined),
                    const SizedBox(width: 4),
                    Text(
                      '999',
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                            fontWeight: FontWeight.w500,
                          ),
                    ),
                  ],
                ),
              ),
              // dislike
              InkWell(
                onTap: () {},
                child: Row(
                  children: [
                    const Icon(Icons.thumb_down_outlined),
                    const SizedBox(width: 4),
                    Text(
                      '999',
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                            fontWeight: FontWeight.w500,
                          ),
                    ),
                  ],
                ),
              ),
              // share
              IconButton(
                onPressed: () {},
                icon: const Icon(Icons.share),
              ),
            ],
          ),
        ],
      ),
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
