import 'dart:developer';

import 'package:capstone_project/model/reply_model.dart';
import 'package:capstone_project/screens/components/button_widget.dart';
import 'package:capstone_project/screens/components/card_widget.dart';
import 'package:capstone_project/themes/nomizo_theme.dart';
import 'package:flutter/material.dart';
import 'package:timeago/timeago.dart' as timeago;

import '../../components/nomizo_icons_icons.dart';

class BlockedItem extends StatefulWidget {
  const BlockedItem({Key? key}) : super(key: key);

  @override
  State<BlockedItem> createState() => _BlockedItemState();
}

class _BlockedItemState extends State<BlockedItem> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      color: NomizoTheme.nomizoDark.shade50,
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          // blocked reason section
          blockedReason('Kekerasan'),
          const SizedBox(height: 12),
          // detail blocked section
          blockedDetail(date: '28/06/2022', time: '14:36', reporter: 'tompos'),
          const SizedBox(height: 12),
          // blocked item section
          blockedItem(),
          const SizedBox(height: 12),
          // ublocked button
          elevatedBtnLong42(
            context,
            () => log('Batalkan Blokir'),
            'Batalkan pemblokiran',
          ),
        ],
      ),
    );
  }

  // reason for blocking
  Widget blockedReason(String reason) {
    return Container(
      width: MediaQuery.of(context).size.width,
      color: NomizoTheme.nomizoDark.shade100,
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      child: RichText(
        textAlign: TextAlign.center,
        text: TextSpan(
            text: 'Alasan: ',
            style: Theme.of(context).textTheme.bodyMedium,
            children: [
              TextSpan(
                text: reason,
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
              )
            ]),
      ),
    );
  }

  // blocked detail
  Widget blockedDetail({String? date, String? time, String? reporter}) {
    TextStyle? regularContent = Theme.of(context).textTheme.bodyMedium;
    TextStyle? semiboldContent =
        Theme.of(context).textTheme.bodyMedium?.copyWith(
              fontWeight: FontWeight.w600,
            );
    return Container(
      width: MediaQuery.of(context).size.width,
      color: NomizoTheme.nomizoDark.shade50,
      child: RichText(
        text: TextSpan(
          text: 'Pemblokiran dilakukan pada tanggal ',
          style: regularContent,
          children: [
            TextSpan(
              text: date,
              style: semiboldContent,
            ),
            TextSpan(
              text: ' pukul',
              style: regularContent,
            ),
            TextSpan(
              text: time,
              style: semiboldContent,
            ),
            TextSpan(
              text: ' WIB bedasarkan pengajuan oleh ',
              style: regularContent,
            ),
            TextSpan(
              text: '@$reporter',
              style: semiboldContent,
            ),
          ],
        ),
      ),
    );
  }

  // blocked item
  Widget blockedItem() {
    return Container(
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        color: NomizoTheme.nomizoDark.shade50,
        borderRadius: BorderRadius.circular(4),
        border: Border.all(
          width: 1,
          color: NomizoTheme.nomizoDark.shade100,
        ),
      ),
      child: replyCard(replyModelExample),
    );
  }

  Widget replyCard(ReplyModel reply) {
    // convert thread date to time ago format
    var convert = DateTime.parse(reply.createdAt!);
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
                    Text(
                      '@${reply.author!.username}',
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                            fontWeight: FontWeight.w500,
                          ),
                      overflow: TextOverflow.ellipsis,
                    ),
                    // post time
                    Row(
                      children: [
                        Text(
                          'mengomentari',
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
                onPressed: () {},
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
          Row(
            children: [
              // comment
              feedbackButton(
                iconData: NomizoIcons.commentOutlined,
                label: reply.replyCount.toString(),
              ),
              // like
              feedbackButton(
                iconData: NomizoIcons.likeOutlined,
                label: reply.likedCount.toString(),
              ),
              // dislike
              feedbackButton(iconData: NomizoIcons.dislikeOutlined),
              // share
              feedbackButton(iconData: NomizoIcons.share),
            ],
          ),
        ],
      ),
    );
  }

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

  ReplyModel replyModelExample = ReplyModel(
      id: 1,
      author: Author(
        id: 9,
        profileImage: '',
        username: 'gaga',
      ),
      image: '',
      likedCount: 10,
      unlikedCount: 20,
      replyCount: 376,
      content:
          'Penyakit virus corona (COVID-19) adalah penyakit menular yang disebabkan oleh virus SARS-Cov-2.',
      createdAt: '2016-08-29T09:12:33.001Z',
      updatedAt: '2016-08-29T09:12:33.001Z');
}
