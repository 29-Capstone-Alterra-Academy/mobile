import 'dart:developer';

import 'package:capstone_project/model/reply_model.dart';
import 'package:capstone_project/screens/components/button_widget.dart';
import 'package:capstone_project/screens/components/reply_component.dart';
import 'package:capstone_project/themes/nomizo_theme.dart';
import 'package:flutter/material.dart';

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
      child: ReplyComponent(replyModel: replyModelExample),
    );
  }

  ReplyModel replyModelExample = ReplyModel(
      author: Author(
        id: 9,
        profileImage: '',
        username: 'gaga',
      ),
      childCount: 0,
      childExist: true,
      content:
          'Penyakit virus corona (COVID-19) adalah penyakit menular yang disebabkan oleh virus SARS-Cov-2.',
      createdAt: '2016-08-29T09:12:33.001Z',
      dislike: 99,
      id: 6898,
      like: 99,
      parentExist: true,
      thread: Thread(
        author: Author(),
        content: '',
        id: 3,
        image1: '',
        image2: '',
        image3: null,
        image4: null,
        image5: null,
        title: 'Abc',
        topic: Topic(
          activityCount: 0,
          contributorCount: 0,
          description: 'jkjkj',
          id: 88,
          moderatorCount: 0,
          name: 'jk',
          profileImage: '',
          rules: 'rules',
        ),
        updatedAt: '2016-08-29T09:12:33.001Z',
      ),
      updatedAt: '2016-08-29T09:12:33.001Z');
}
