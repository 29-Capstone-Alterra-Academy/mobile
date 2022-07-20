import 'package:capstone_project/model/thread_model/thread_model.dart';
import 'package:capstone_project/screens/components/card_widget.dart';
import 'package:capstone_project/screens/components/more_component.dart';
import 'package:capstone_project/screens/components/nomizo_icons_icons.dart';
import 'package:capstone_project/screens/components/report_component.dart';
import 'package:capstone_project/screens/home_screen/detail_image.dart';
import 'package:capstone_project/screens/home_screen/detail_thread_screen.dart';
import 'package:capstone_project/screens/search_screen/detail_category/detail_category_screen.dart';
import 'package:capstone_project/screens/search_screen/detail_user/detail_user_screen.dart';
import 'package:capstone_project/themes/nomizo_theme.dart';
import 'package:capstone_project/utils/url.dart';
import 'package:capstone_project/viewmodel/profile_viewmodel/profile_provider.dart';
import 'package:capstone_project/viewmodel/thread_viewmodel/detail_thread_provider.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:share_plus/share_plus.dart';
import 'package:timeago/timeago.dart' as timeago;

Widget threadCard({
  required BuildContext context,
  required ThreadModel threadModel,
  required bool isOpened,
}) {
  List<String> images = <String>[];
  // set image list
  if (threadModel.image1 != '') {
    images.add(threadModel.image1!);
  }
  if (threadModel.image2 != '') {
    images.add(threadModel.image2!);
  }
  if (threadModel.image3 != '') {
    images.add(threadModel.image3!);
  }
  if (threadModel.image4 != '') {
    images.add(threadModel.image4!);
  }
  if (threadModel.image5 != '') {
    images.add(threadModel.image5!);
  }
  return InkWell(
    onTap: isOpened
        ? null
        : () => Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => DetailThreadScreen(threadModel: threadModel),
              ),
            ),
    child: Container(
      padding: const EdgeInsets.all(16),
      color: NomizoTheme.nomizoDark.shade50,
      child: Column(
        children: [
          ListTile(
            contentPadding: EdgeInsets.zero,
            leading: circlePic(42, threadModel.topic!.profileImage ?? ''),
            title: threadCardTitle(context, threadModel),
            subtitle: threadCardSubtitle(context, threadModel),
            trailing: moreButton(context, threadModel),
          ),
          const SizedBox(height: 12),
          threadContent(context, threadModel),
          const SizedBox(height: 12),
          if (images.isNotEmpty) carouselImage(images, isOpened),
          if (images.isNotEmpty) const SizedBox(height: 12),
          threadFeedback(context, threadModel, isOpened),
        ],
      ),
    ),
  );
}

Widget threadCardTitle(BuildContext context, ThreadModel threadModel) {
  final myId =
      Provider.of<ProfileProvider>(context, listen: false).currentUser!.id;
  return Row(
    children: [
      InkWell(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => DetailCategoryScreen(
                idCategory: threadModel.topic!.id!,
              ),
            ),
          );
        },
        child: Text(
          '${threadModel.topic!.name}',
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                fontWeight: FontWeight.w500,
              ),
          overflow: TextOverflow.ellipsis,
        ),
      ),
      buildDotDivider(),
      Flexible(
        child: InkWell(
          onTap: () {
            if (threadModel.author!.id != myId) {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => DetailUserScreen(
                    idUser: threadModel.author!.id!,
                  ),
                ),
              );
            }
          },
          child: Text(
            'diposting oleh @${threadModel.author!.username}',
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  color: NomizoTheme.nomizoDark.shade500,
                  fontWeight: FontWeight.w500,
                ),
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ),
    ],
  );
}

Widget threadCardSubtitle(BuildContext context, ThreadModel threadModel) {
  var convert = DateTime.parse(threadModel.createdAt ?? threadModel.updatedAt!);
  var difference = DateTime.now().difference(convert);
  var date = DateTime.now().subtract(difference);
  String threadDate = timeago.format(date, locale: 'id');
  return Row(
    children: [
      Text(
        threadDate,
        style: Theme.of(context).textTheme.bodySmall?.copyWith(
              color: NomizoTheme.nomizoDark.shade500,
            ),
        overflow: TextOverflow.ellipsis,
      ),
      buildDotDivider(),
      Text(
        'diposting',
        style: Theme.of(context).textTheme.bodySmall?.copyWith(
              color: NomizoTheme.nomizoDark.shade500,
            ),
      ),
    ],
  );
}

Widget moreButton(BuildContext context, ThreadModel threadModel) {
  final provider = Provider.of<DetailThreadProvider>(context, listen: false);
  return InkWell(
    child: const Icon(NomizoIcons.more),
    onTap: () {
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
              await provider.followUser(threadModel.author!.id!).then((value) {
                Navigator.pop(context);
                if (value) {
                  buildToast(
                      'Berhasil mengikuti @${threadModel.author!.username}');
                } else {
                  buildToast(
                      'Gagal mengikuti @${threadModel.author!.username}');
                }
                Navigator.pop(context);
              });
            },
            // follow category
            () async {
              buildLoading(context);
              await provider
                  .followCategory(threadModel.topic!.id!)
                  .then((value) {
                Navigator.pop(context);
                if (value) {
                  buildToast('Berhasil engikuti kategori');
                } else {
                  buildToast('Gagal mengikuti kategori');
                }
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
  );
}

Widget threadContent(BuildContext context, ThreadModel threadModel) {
  return SizedBox(
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
  );
}

Widget carouselImage(List<String> imgUrl, bool isOpened) {
  return CarouselSlider.builder(
    itemCount: imgUrl.length,
    itemBuilder: (context, itemIndex, pageViewIndex) {
      return InkWell(
        onTap: isOpened
            ? () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => DetailImage(
                      imageUrl: imgUrl[itemIndex],
                    ),
                  ),
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

Widget threadFeedback(
    BuildContext context, ThreadModel threadModel, bool isOpened) {
  final provider = Provider.of<DetailThreadProvider>(context, listen: false);
  return Row(
    children: [
      // comment
      feedbackButton(
        context: context,
        iconData: NomizoIcons.commentOutlined,
        label: '${threadModel.replyCount}',
        function: isOpened
            ? () => provider.changeSelectedReply(replyModel: null)
            : () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) =>
                        DetailThreadScreen(threadModel: threadModel),
                  ),
                ),
      ),
      // like
      feedbackButton(
        context: context,
        iconData: Icons.thumb_up_alt_outlined,
        label: '${threadModel.likedCount}',
        function: () => provider.likeThread(threadModel.id!),
      ),
      // dislike
      feedbackButton(
        context: context,
        iconData: Icons.thumb_down_alt_outlined,
        function: () => provider.dislikeThread(threadModel.id!),
      ),
      // share
      feedbackButton(
        context: context,
        iconData: NomizoIcons.share,
        function: () async {
          await Share.share(
              '$baseURL/thread?userId&topicId=1&limit=100&offset=0');
        },
      ),
    ],
  );
}

Widget feedbackButton({
  required BuildContext context,
  required IconData iconData,
  String? label,
  void Function()? function,
}) {
  return Flexible(
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
