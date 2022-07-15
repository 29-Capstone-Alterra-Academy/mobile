import 'package:badges/badges.dart';
import 'package:capstone_project/model/report_category_model.dart' as category;
import 'package:capstone_project/model/report_reply_model.dart' as reply;
import 'package:capstone_project/model/report_thread_model.dart' as thread;
import 'package:capstone_project/model/report_user_model.dart' as user;
import 'package:capstone_project/screens/admin/report_screen/detail_report_screen.dart';
import 'package:capstone_project/screens/components/card_widget.dart';
import 'package:capstone_project/themes/nomizo_theme.dart';
import 'package:flutter/material.dart';
import 'package:timeago/timeago.dart' as timeago;

class ReportScreen extends StatefulWidget {
  const ReportScreen({Key? key}) : super(key: key);

  @override
  State<ReportScreen> createState() => _ReportScreenState();
}

class _ReportScreenState extends State<ReportScreen> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 4,
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: const Text('Laporan'),
          bottom: const TabBar(
            tabs: [
              SizedBox(
                height: 42,
                child: Center(child: Text('Thread')),
              ),
              SizedBox(
                height: 42,
                child: Center(child: Text('Reply')),
              ),
              SizedBox(
                height: 42,
                child: Center(child: Text('Category')),
              ),
              SizedBox(
                height: 42,
                child: Center(child: Text('User')),
              ),
            ],
          ),
        ),
        body: SafeArea(
          child: TabBarView(
            children: [
              // thread report
              InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => const DetailReportScreen(
                        tabIndex: 0,
                      ),
                    ),
                  );
                },
                child: reportThreadItem(reportThreadModel),
              ),
              // reply report
              InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => const DetailReportScreen(
                        tabIndex: 1,
                      ),
                    ),
                  );
                },
                child: reportReplyItem(reportReplyModel),
              ),
              // category report
              InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => const DetailReportScreen(
                        tabIndex: 2,
                      ),
                    ),
                  );
                },
                child: reportCategoryItem(reportCategoryModel),
              ),
              // user report
              InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => const DetailReportScreen(
                        tabIndex: 3,
                      ),
                    ),
                  );
                },
                child: reportUserItem(reportUserModel),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // report category item
  Widget reportThreadItem(thread.ReportThreadModel threadModel) {
    return ListView.builder(
      itemCount: 2,
      itemBuilder: (context, index) {
        return Container(
          width: MediaQuery.of(context).size.width,
          color: NomizoTheme.nomizoDark.shade50,
          padding: const EdgeInsets.all(16),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // moderator profile picture
              circlePic(42, threadModel.reporter!.profileImage!),
              const SizedBox(width: 8),
              // moderator report section
              Flexible(
                child: reportDescription(
                  reporterName: threadModel.reporter!.username!,
                  highlight: threadModel.thread!.title!,
                  type: 'thread',
                  time: threadModel.createdAt!,
                  reason: threadModel.reason!.detail!,
                ),
              ),
              // isReviewed
              Badge(
                badgeColor: NomizoTheme.nomizoRed.shade600,
                position: BadgePosition.topEnd(top: 0, end: 0),
              ),
            ],
          ),
        );
      },
    );
  }

  // report category item
  Widget reportReplyItem(reply.ReportReplyModel replyModel) {
    return ListView.builder(
      itemCount: 2,
      itemBuilder: (context, index) {
        return Container(
          width: MediaQuery.of(context).size.width,
          color: NomizoTheme.nomizoDark.shade50,
          padding: const EdgeInsets.all(16),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // moderator profile picture
              circlePic(42, replyModel.reporter!.profileImage!),
              const SizedBox(width: 8),
              // moderator report section
              Flexible(
                child: reportDescription(
                  reporterName: replyModel.reporter!.username!,
                  highlight: replyModel.reply!.content!,
                  type: 'reply',
                  time: replyModel.createdAt!,
                  reason: replyModel.reason!.detail!,
                ),
              ),
              // isReviewed
              Badge(
                badgeColor: NomizoTheme.nomizoRed.shade600,
                position: BadgePosition.topEnd(top: 0, end: 0),
              ),
            ],
          ),
        );
      },
    );
  }

  // report category item
  Widget reportCategoryItem(category.ReportCategoryModel categoryModel) {
    return ListView.builder(
      itemCount: 2,
      itemBuilder: (context, index) {
        return Container(
          width: MediaQuery.of(context).size.width,
          color: NomizoTheme.nomizoDark.shade50,
          padding: const EdgeInsets.all(16),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // moderator profile picture
              circlePic(42, categoryModel.reporter!.profileImage!),
              const SizedBox(width: 8),
              // moderator report section
              Flexible(
                child: reportDescription(
                  reporterName: categoryModel.reporter!.username!,
                  highlight: categoryModel.topic!.name!,
                  type: 'category',
                  time: categoryModel.createdAt!,
                  reason: categoryModel.reason!.detail!,
                ),
              ),
              // isReviewed
              Badge(
                badgeColor: NomizoTheme.nomizoRed.shade600,
                position: BadgePosition.topEnd(top: 0, end: 0),
              ),
            ],
          ),
        );
      },
    );
  }

  // report user item
  Widget reportUserItem(user.ReportUserModel userModel) {
    return ListView.builder(
      itemCount: 2,
      itemBuilder: (context, index) {
        return Container(
          width: MediaQuery.of(context).size.width,
          color: NomizoTheme.nomizoDark.shade50,
          padding: const EdgeInsets.all(16),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // moderator profile picture
              circlePic(42, userModel.reporter!.profileImage!),
              const SizedBox(width: 8),
              // moderator report section
              Flexible(
                child: reportDescription(
                  reporterName: userModel.reporter!.username!,
                  highlight: '@${userModel.suspect!.username!}',
                  type: 'user',
                  time: userModel.createdAt!,
                  reason: userModel.reason!.detail!,
                ),
              ),
              // isReviewed
              Badge(
                badgeColor: NomizoTheme.nomizoRed.shade600,
                position: BadgePosition.topEnd(top: 0, end: 0),
              ),
            ],
          ),
        );
      },
    );
  }

  // moderator report description
  Widget reportDescription({
    required String reporterName,
    required String highlight,
    required String type,
    required String time,
    required String reason,
  }) {
    return Container(
      width: MediaQuery.of(context).size.width,
      color: NomizoTheme.nomizoDark.shade50,
      alignment: Alignment.centerLeft,
      child: Column(
        children: [
          // description
          Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // name & time report
              reporter(username: reporterName, time: time),
              // report description
              RichText(
                text: TextSpan(
                  text: 'Meneruskan laporan sebuah $type dengan alasan:',
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
          // report content section
          reportHighlight(highlight),
        ],
      ),
    );
  }

  // report higlight
  Widget reportHighlight(String title) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: 24,
      padding: const EdgeInsets.only(left: 8),
      alignment: Alignment.centerLeft,
      decoration: BoxDecoration(
        color: NomizoTheme.nomizoDark.shade50,
        border: Border(
          left: BorderSide(
            width: 2,
            color: NomizoTheme.nomizoDark.shade100,
          ),
        ),
      ),
      child: Text(title,
          style: Theme.of(context).textTheme.bodySmall?.copyWith(
                color: NomizoTheme.nomizoDark.shade500,
              )),
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

  user.ReportUserModel reportUserModel = user.ReportUserModel(
    reporter: user.Reporter(
      id: 1,
      username: 'mapti',
      profileImage: '',
    ),
    reason: user.Reason(id: 2, detail: 'Kekerasan'),
    suspect: user.Suspect(
      id: 17,
      username: 'fami',
      profileImage: '',
    ),
    createdAt: '2022-07-14T14:29:28.538845Z',
  );

  category.ReportCategoryModel reportCategoryModel =
      category.ReportCategoryModel(
    reporter: category.Reporter(
      id: 1,
      username: 'mapti',
      profileImage: '',
    ),
    reason: category.Reason(id: 2, detail: 'Kekerasan'),
    topic: category.Topic(id: 2, name: 'Foods', profileImage: ''),
    createdAt: '2022-07-14T14:29:28.538845Z',
  );

  thread.ReportThreadModel reportThreadModel = thread.ReportThreadModel(
    reporter: thread.Reporter(
      id: 1,
      username: 'mapti',
      profileImage: '',
    ),
    reason: thread.Reason(id: 2, detail: 'Kekerasan'),
    topic: thread.Topic(id: 2, name: 'Foods', profileImage: ''),
    thread: thread.Thread(
      id: 3,
      title: 'Ambatukam',
      content: '',
      image1: '',
      image2: '',
      image3: '',
      image4: '',
      image5: '',
    ),
    createdAt: '2022-07-14T14:29:28.538845Z',
  );

  reply.ReportReplyModel reportReplyModel = reply.ReportReplyModel(
    reporter: reply.Reporter(
      id: 1,
      username: 'mapti',
      profileImage: '',
    ),
    reason: reply.Reason(id: 2, detail: 'Kekerasan'),
    topic: reply.Topic(id: 2, name: 'Foods', profileImage: ''),
    reply: reply.Reply(id: 3, content: 'Bertumbuk kita', image: ''),
    createdAt: '2022-07-14T14:29:28.538845Z',
  );
}
