import 'package:capstone_project/model/modrequest_model.dart';
import 'package:capstone_project/screens/components/button_widget.dart';
import 'package:capstone_project/screens/components/card_widget.dart';
import 'package:flutter/material.dart';
import 'package:timeago/timeago.dart' as timeago;

class RequestModeratorItem extends StatefulWidget {
  final ModrequestModel model;
  const RequestModeratorItem({Key? key, required this.model}) : super(key: key);

  @override
  State<RequestModeratorItem> createState() => _RequestModeratorItemState();
}

class _RequestModeratorItemState extends State<RequestModeratorItem> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          // moderator profile request
          modrequest(
            moderatorName: widget.model.user!.username!,
            time: widget.model.createdAt!,
            category: widget.model.topic!.name!,
          ),
          const SizedBox(height: 12),
          // Approval button
          approvalButton(),
        ],
      ),
    );
  }

  // moderator profile request
  Widget modrequest({
    required String moderatorName,
    required String time,
    required String category,
  }) {
    return Row(
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
              moderator(username: moderatorName, time: time),
              // report description
              RichText(
                text: TextSpan(
                  text: 'Mengajukan diri menjadi moderator pada kategori',
                  style: Theme.of(context).textTheme.bodyMedium,
                  children: [
                    TextSpan(
                      text: ' $category',
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
    );
  }

  // name & time report
  Widget moderator({required String username, required String time}) {
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

  // Approval button
  Widget approvalButton() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        // reject button
        outlinedBtn42(context, () {}, 'Abaikan'),
        // accept button
        elevatedBtn42(context, () {}, 'Terima'),
      ],
    );
  }
}
