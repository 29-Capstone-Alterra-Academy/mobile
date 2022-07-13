// import package
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:share_plus/share_plus.dart';
import 'package:timeago/timeago.dart' as timeago;
import 'package:carousel_slider/carousel_slider.dart';

// import utils & theme
import 'package:capstone_project/utils/url.dart';
import 'package:capstone_project/themes/nomizo_theme.dart';

// import component
import 'package:capstone_project/screens/components/card_widget.dart';
import 'package:capstone_project/screens/components/more_component.dart';
import 'package:capstone_project/screens/components/report_component.dart';

// import model
import 'package:capstone_project/model/thread_model.dart';

// import provider
import 'package:capstone_project/modelview/detail_thread_provider.dart';

// import screen
import 'package:capstone_project/screens/home_screen/detail_image.dart';
import 'package:capstone_project/screens/home_screen/detail_thread_screen.dart';
import 'package:capstone_project/screens/search_screen/detail_user/detail_user_screen.dart';
import 'package:capstone_project/screens/search_screen/detail_category/detail_category_screen.dart';

class ThreadComponent extends StatefulWidget {
  final ThreadModel threadModel;
  final bool isOpened;
  const ThreadComponent({
    Key? key,
    required this.threadModel,
    required this.isOpened,
  }) : super(key: key);

  @override
  State<ThreadComponent> createState() => _ThreadComponentState();
}

class _ThreadComponentState extends State<ThreadComponent> {
  late ThreadModel threadModel;
  late bool isOpened;
  late String threadDate;
  List<String> images = <String>[];

  @override
  void initState() {
    threadModel = widget.threadModel;
    isOpened = widget.isOpened;
    // set image list
    if (threadModel.image1 != '') {
      images.add('$baseURL${threadModel.image1}');
    }
    if (threadModel.image2 != '') {
      images.add('$baseURL${threadModel.image2}');
    }
    if (threadModel.image3 != '') {
      images.add('$baseURL${threadModel.image3}');
    }
    if (threadModel.image4 != '') {
      images.add('$baseURL${threadModel.image4}');
    }
    if (threadModel.image5 != '') {
      images.add('$baseURL${threadModel.image5}');
    }
    // convert thread date to time ago format
    var convert = DateTime.parse(threadModel.createdAt!);
    var difference = DateTime.now().difference(convert);
    var date = DateTime.now().subtract(difference);
    threadDate = timeago.format(date, locale: 'id');
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<DetailThreadProvider>(context, listen: false);
    return InkWell(
      onTap: isOpened
          ? null
          : () => openDetail(context: context, threadModel: threadModel),
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
                circlePic(42, threadModel.topic!.profileImage ?? ''),
                const SizedBox(width: 7),
                // title
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // posted by
                      Row(
                        children: [
                          InkWell(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (_) => DetailCategoryScreen(
                                    idCategory: threadModel.id ?? 1,
                                  ),
                                ),
                              );
                            },
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
                            child: InkWell(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (_) => DetailUserScreen(
                                      idUser: threadModel.author!.id ?? 1,
                                    ),
                                  ),
                                );
                              },
                              child: Text(
                                'diposting oleh @${threadModel.author!.username}',
                                style: Theme.of(context)
                                    .textTheme
                                    .bodySmall
                                    ?.copyWith(
                                      color: NomizoTheme.nomizoDark.shade500,
                                      fontWeight: FontWeight.w500,
                                    ),
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ),
                        ],
                      ),
                      // post time
                      Row(
                        children: [
                          Text(
                            threadDate,
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
                    showMoreMenu(
                      context,
                      MoreComponent(
                        myLabels: const <String>[
                          'Ikuti Pengguna',
                          'Ikuti Kategori',
                          'Laporkan',
                        ],
                        myFunctions: <void Function()>[
                          // follow user
                          () async {
                            buildLoading(context);
                            await provider
                                .followUser(threadModel.author!.id ?? 1)
                                .then((value) {
                              Navigator.pop(context);
                              Navigator.pop(context);
                            });
                          },
                          // follow category
                          () async {
                            buildLoading(context);
                            await provider
                                .followCategory(threadModel.author!.id ?? 1)
                                .then((value) {
                              Navigator.pop(context);
                              Navigator.pop(context);
                            });
                          },
                          // report thread
                          () {
                            Navigator.pop(context);
                            showMoreMenu(
                              context,
                              const ReportComponent(type: "thread"),
                            );
                          },
                        ],
                      ),
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
                    threadModel.title ?? '',
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
            if (images.isNotEmpty) carouselImage(images, isOpened),
            if (images.isNotEmpty) const SizedBox(height: 12),
            // like / dislike / comment / share button section
            Row(
              children: [
                // comment
                feedbackButton(
                  iconData: Icons.comment_outlined,
                  label: '${threadModel.replyCount}',
                  function: isOpened
                      ? () => provider.changeSelectedReply(replyModel: null)
                      : () => openDetail(
                            context: context,
                            threadModel: threadModel,
                          ),
                ),
                // like
                feedbackButton(
                  iconData: Icons.thumb_up_outlined,
                  label: '${threadModel.likedCount}',
                  function: () => provider.likeThread(threadModel),
                ),
                // dislike
                feedbackButton(
                  iconData: Icons.thumb_down_outlined,
                  function: () => provider.dislikeThread(threadModel),
                ),
                // share
                feedbackButton(
                  iconData: Icons.share,
                  function: () async {
                    await Share.share('Share');
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  // function openDetail
  void openDetail(
      {required BuildContext context, required ThreadModel threadModel}) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => DetailThreadScreen(
          threadModel: threadModel,
        ),
      ),
    );
  }

  // build carousel image slider
  Widget carouselImage(List<String> imgUrl, bool isOpened) {
    return CarouselSlider.builder(
      itemCount: imgUrl.length,
      itemBuilder: (context, itemIndex, pageViewIndex) {
        return InkWell(
          onTap: isOpened
              ? () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => const DetailImage()),
                  );
                }
              : null,
          child: Container(
            width: MediaQuery.of(context).size.width,
            height: 175,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(4),
              border: Border.all(
                width: 1,
                color: NomizoTheme.nomizoDark.shade100,
              ),
            ),
            clipBehavior: Clip.hardEdge,
            child: Image.network(
              imgUrl[itemIndex],
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) {
                return Padding(
                  padding: const EdgeInsets.all(70),
                  child: Image.asset('assets/images/nomizo-icon.png'),
                );
              },
            ),
          ),
        );
      },
      options: CarouselOptions(
        enableInfiniteScroll: false,
        viewportFraction: 1,
      ),
    );
  }

  // comment / like / unlike / share button
  Widget feedbackButton({
    required IconData iconData,
    String? label,
    void Function()? function,
  }) {
    return Expanded(
      child: Container(
        alignment: Alignment.centerLeft,
        child: InkWell(
          onTap: function,
          child: label == null
              ? Icon(iconData)
              : Row(
                  children: [
                    Icon(iconData),
                    const SizedBox(width: 4),
                    Text(
                      label,
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                            fontWeight: FontWeight.w500,
                          ),
                    ),
                  ],
                ),
        ),
      ),
    );
  }
}
