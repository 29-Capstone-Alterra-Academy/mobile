import 'package:capstone_project/model/thread_model.dart';
import 'package:capstone_project/screens/components/button_widget.dart';
import 'package:capstone_project/screens/components/card_widget.dart';
import 'package:capstone_project/screens/components/thread_component.dart';
import 'package:capstone_project/themes/nomizo_theme.dart';
import 'package:flutter/material.dart';
import 'package:timeago/timeago.dart' as timeago;

class BlockRequestItem extends StatefulWidget {
  const BlockRequestItem({Key? key}) : super(key: key);

  @override
  State<BlockRequestItem> createState() => _BlockRequestItemState();
}

class _BlockRequestItemState extends State<BlockRequestItem> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      color: NomizoTheme.nomizoDark.shade50,
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          // moderator report section
          reportDescription(
            reporterName: 'mapti',
            time: '2016-08-29T09:12:33.001Z',
            reason: 'Informasi palsu',
          ),
          const SizedBox(height: 12),
          // report content section
          reportContent(),
          const SizedBox(height: 12),
          // button section
          reportButton(),
        ],
      ),
    );
  }

  // moderator report description
  Widget reportDescription({
    required String reporterName,
    required String time,
    required String reason,
  }) {
    return Container(
      width: MediaQuery.of(context).size.width,
      color: NomizoTheme.nomizoDark.shade50,
      child: Row(
        children: [
          // moderator profile picture
          circlePic(42, ''),
          const SizedBox(width: 8),
          // description
          Flexible(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // name & time report
                reporter(username: reporterName, time: time),
                // report description
                RichText(
                  text: TextSpan(
                    text: 'Meneruskan laporan sebuah postingan dengan alasan:',
                    style: Theme.of(context).textTheme.bodyMedium,
                    children: [
                      TextSpan(
                        text: ' $reason',
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                              fontWeight: FontWeight.w600,
                            ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // report content
  Widget reportContent() {
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
      child: IgnorePointer(
        ignoring: true,
        child:
            ThreadComponent(threadModel: threadModelExample, isOpened: false),
      ),
    );
  }

  // button section
  Widget reportButton() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        // reject button
        outlinedBtn42(context, () {}, 'Tolak'),
        // accept button
        elevatedBtn42(context, () {}, 'Terima'),
      ],
    );
  }

  // name & time report
  Widget reporter({required String username, required String time}) {
    TextStyle? bold = Theme.of(context).textTheme.bodyMedium?.copyWith(
          fontWeight: FontWeight.w600,
        );
    var convert = DateTime.parse(time);
    var difference = DateTime.now().difference(convert);
    var date = DateTime.now().subtract(difference);
    String timeAgo = timeago.format(date, locale: 'id');

    return Row(
      children: [
        // reporter username
        Text('@$username', style: bold),
        // dot divider
        buildDotDivider(),
        // time report
        Text(
          timeAgo,
          style: bold,
        ),
      ],
    );
  }

  ThreadModel threadModelExample = ThreadModel(
      author: Author(
        id: 3,
        username: 'raymond',
      ),
      content: 'Content Thread Bla Bla Bla...',
      createdAt: '2016-08-29T09:12:33.001Z',
      id: 198,
      image1: '',
      image2: '',
      image3: '',
      image4: null,
      image5: null,
      title: 'Judul Thread',
      topic: Topic(
        id: 88,
        name: 'jk',
        profileImage: '',
      ),
      updatedAt: '2016-08-29T09:12:33.001Z');
}
