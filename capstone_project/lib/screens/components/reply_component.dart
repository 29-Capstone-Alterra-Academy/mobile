// import package
import 'package:capstone_project/model/thread_model.dart';
import 'package:capstone_project/utils/url.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:share_plus/share_plus.dart';
import 'package:timeago/timeago.dart' as timeago;
// import 'package:carousel_slider/carousel_slider.dart';

// import theme
import 'package:capstone_project/themes/nomizo_theme.dart';

// import component
import 'package:capstone_project/screens/components/card_widget.dart';
import 'package:capstone_project/screens/components/more_component.dart';
import 'package:capstone_project/screens/components/report_component.dart';

// import model
import 'package:capstone_project/model/reply_model.dart';

// import provider
import 'package:capstone_project/modelview/detail_thread_provider.dart';

// import screen
import 'package:capstone_project/screens/search_screen/detail_user/detail_user_screen.dart';

class ReplyComponent extends StatefulWidget {
  final ThreadModel? threadModel;
  final ReplyModel replyModel;
  const ReplyComponent({Key? key, required this.replyModel, this.threadModel})
      : super(key: key);

  @override
  State<ReplyComponent> createState() => _ReplyComponentState();
}

class _ReplyComponentState extends State<ReplyComponent> {
  late ReplyModel parentReply;

  @override
  void initState() {
    parentReply = widget.replyModel;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<DetailThreadProvider>(context, listen: false);
    return Consumer<DetailThreadProvider>(
      builder: (context, value, _) {
        return Column(
          children: [
            // reply parent
            replyCard(parentReply, provider),
            if (parentReply.replyCount! > 0)
              Column(
                children: [
                  // reply child section
                  AnimatedSize(
                    curve: Curves.easeIn,
                    duration: const Duration(milliseconds: 300),
                    child: SizedBox(
                      height: value.expandReply ? null : 0,
                      child: value.repliesChild.isEmpty
                          ? Container()
                          : ListView.builder(
                              itemCount: value.repliesChild.length,
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              itemBuilder: (context, index) {
                                return Padding(
                                  padding: const EdgeInsets.only(left: 50),
                                  child: replyCard(
                                      value.repliesChild[index], provider),
                                );
                              },
                            ),
                    ),
                  ),
                  // see more reply button
                  buildMoreReply(
                    isExpanded: value.expandReply,
                    label: 'Lihat Balasan (${parentReply.replyCount})',
                    function: () async {
                      if (!value.expandReply) {
                        await provider.getReplyChild(parentReply.id!);
                      }
                      provider.expandReplyParent();
                    },
                  ),
                ],
              ),
          ],
        );
      },
    );
  }

  Widget buildMoreReply({
    required bool isExpanded,
    required String label,
    void Function()? function,
  }) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: 36,
      padding: const EdgeInsets.fromLTRB(66, 4, 16, 4),
      color: NomizoTheme.nomizoDark.shade50,
      child: InkWell(
        onTap: function,
        child: Row(
          children: [
            Text(label),
            isExpanded
                ? const Icon(Icons.keyboard_arrow_up)
                : const Icon(Icons.keyboard_arrow_down),
          ],
        ),
      ),
    );
  }

  Widget replyCard(ReplyModel reply, DetailThreadProvider provider) {
    // convert thread date to time ago format
    var convert = DateTime.parse(parentReply.createdAt!);
    var difference = DateTime.now().difference(convert);
    var date = DateTime.now().subtract(difference);
    String replyDate = timeago.format(date, locale: 'id');

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // head
          Row(
            children: [
              // profile pic
              circlePic(42, '${reply.author!.profileImage}'),
              const SizedBox(width: 7),
              // title
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // posted by
                    InkWell(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => DetailUserScreen(
                              idUser: reply.author!.id ?? 1,
                            ),
                          ),
                        );
                      },
                      child: Text(
                        '${reply.author!.username}',
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                              fontWeight: FontWeight.w500,
                            ),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    // post time
                    Row(
                      children: [
                        Text(
                          'mengomentari @${widget.threadModel!.author!.username}',
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
                        Expanded(
                          child: Text(
                            replyDate,
                            style:
                                Theme.of(context).textTheme.bodySmall?.copyWith(
                                      color: NomizoTheme.nomizoDark.shade500,
                                    ),
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
                  provider.changeSelectedReply(replyModel: reply);
                  showMoreMenu(
                    context,
                    MoreComponent(
                      myLabels: const <String>[
                        'Ikuti Penngguna',
                        'Laporkan',
                      ],
                      myFunctions: <void Function()>[
                        // follow user
                        () async {
                          buildLoading(context);
                          await provider
                              .followUser(reply.author!.id ?? 1)
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
                            const ReportComponent(type: "reply"),
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
            child: Text(
              '${reply.content}',
              style: Theme.of(context).textTheme.bodyMedium,
            ),
          ),
          const SizedBox(height: 12),
          // image
          // if (replyModel.images != null) carouselImage(replyModel.images!),
          // if (replyModel.images != null) const SizedBox(height: 12),
          // like / dislike / comment / share button section
          Row(
            children: [
              // comment
              feedbackButton(
                iconData: Icons.comment_outlined,
                label: reply.replyCount.toString(),
                function: () => provider.changeSelectedReply(replyModel: reply),
              ),
              // like
              feedbackButton(
                iconData: Icons.thumb_up_outlined,
                label: reply.likedCount.toString(),
                function: () =>
                    provider.likeReply(reply, provider.currentThread!.id!),
              ),
              // dislike
              feedbackButton(
                iconData: Icons.thumb_down_outlined,
                function: () =>
                    provider.dislikeReply(reply, provider.currentThread!.id!),
              ),
              // share
              feedbackButton(
                iconData: Icons.share,
                function: () async {
                  await Share.share(
                      '$baseURL/reply?scope=thread&limit=100&offset=0&threadId=${reply.id}');
                },
              ),
            ],
          ),
        ],
      ),
    );
  }

  // build carousel image slider
  // Widget carouselImage(List<String> imgUrl) {
  //   return CarouselSlider.builder(
  //     itemCount: imgUrl.length,
  //     itemBuilder: (context, itemIndex, pageViewIndex) {
  //       return Container(
  //         width: MediaQuery.of(context).size.width,
  //         height: 175,
  //         decoration: BoxDecoration(
  //           borderRadius: BorderRadius.circular(4),
  //           border: Border.all(
  //             width: 1,
  //             color: NomizoTheme.nomizoDark.shade100,
  //           ),
  //         ),
  //         clipBehavior: Clip.hardEdge,
  //         child: Image.network(
  //           imgUrl[itemIndex],
  //           fit: BoxFit.cover,
  //           errorBuilder: (context, error, stackTrace) {
  //             return Image.asset('assets/img/app_logo.png');
  //           },
  //         ),
  //       );
  //     },
  //     options: CarouselOptions(
  //       enableInfiniteScroll: false,
  //       viewportFraction: 1,
  //     ),
  //   );
  // }

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
