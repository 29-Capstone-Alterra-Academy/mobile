import 'package:badges/badges.dart';
import 'package:capstone_project/model/report_model/report_category_model.dart'
    as category;
import 'package:capstone_project/model/report_model/report_reply_model.dart'
    as reply;
import 'package:capstone_project/model/report_model/report_thread_model.dart'
    as thread;
import 'package:capstone_project/model/report_model/report_user_model.dart'
    as user;
import 'package:capstone_project/screens/admin/report_screen/detail_report_screen.dart';
import 'package:capstone_project/screens/admin/report_screen/report_category_screen.dart';
import 'package:capstone_project/screens/admin/report_screen/report_thread_screen.dart';
import 'package:capstone_project/screens/admin/report_screen/report_user_screen.dart';
import 'package:capstone_project/screens/components/card_widget.dart';
import 'package:capstone_project/themes/nomizo_theme.dart';
import 'package:capstone_project/utils/finite_state.dart';
import 'package:capstone_project/viewmodel/admin_viewmodel/admin_report_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:timeago/timeago.dart' as timeago;

class ReportScreen extends StatefulWidget {
  const ReportScreen({Key? key}) : super(key: key);

  @override
  State<ReportScreen> createState() => _ReportScreenState();
}

class _ReportScreenState extends State<ReportScreen> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      Provider.of<AdminReportProvider>(context, listen: false).getReports();
    });
    super.initState();
  }

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
          child: Consumer<AdminReportProvider>(builder: (context, value, _) {
            if (value.state == FiniteState.loading) {
              return Center(
                child: CircularProgressIndicator(
                  color: NomizoTheme.nomizoTosca.shade600,
                ),
              );
            } else {
              return TabBarView(
                children: [
                  // thread report
                  reportThreadItem(value.threads),
                  // reply report
                  reportReplyItem(value.replies),
                  // category report
                  reportCategoryItem(value.categories),
                  // user report
                  reportUserItem(value.users),
                ],
              );
            }
          }),
        ),
      ),
    );
  }

  // report category item
  Widget reportThreadItem(List<thread.ReportThreadModel> threadModel) {
    if (threadModel.isEmpty) {
      return const Center(
        child: Text('Laporan Kosong'),
      );
    }
    return ListView.builder(
      itemCount: threadModel.length,
      itemBuilder: (context, index) {
        return InkWell(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => ReportThreadScreen(
                  idThread: threadModel[index].thread!.id!,
                ),
              ),
            );
          },
          child: Container(
            width: MediaQuery.of(context).size.width,
            color: NomizoTheme.nomizoDark.shade50,
            padding: const EdgeInsets.all(16),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // moderator profile picture
                circlePic(42, threadModel[index].reporter!.profileImage ?? ''),
                const SizedBox(width: 8),
                // moderator report section
                Flexible(
                  child: reportDescription(
                    reporterName: threadModel[index].reporter!.username!,
                    highlight: threadModel[index].thread!.title!,
                    type: 'thread',
                    time: threadModel[index].createdAt!,
                    reason: threadModel[index].reason!.detail!,
                  ),
                ),
                // isReviewed
                Badge(
                  badgeColor: NomizoTheme.nomizoRed.shade600,
                  position: BadgePosition.topEnd(top: 0, end: 0),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  // report category item
  Widget reportReplyItem(List<reply.ReportReplyModel> replyModel) {
    if (replyModel.isEmpty) {
      return const Center(
        child: Text('Laporan Kosong'),
      );
    }
    return ListView.builder(
      itemCount: replyModel.length,
      itemBuilder: (context, index) {
        return InkWell(
          onTap: () {
            showDialog(
              context: context,
              builder: (BuildContext context) {
                return blockConfirmation(
                  context: context,
                  title: 'Apakah yakin memblokir?',
                  subtitle:
                      'Seluruh aktivitas yang ada pada laporan ini akan terblokir',
                  button1: 'Batalkan',
                  button2: 'Blokir',
                  function: () {
                    Navigator.pop(context);
                  },
                );
              },
            );
          },
          onLongPress: () {
            showDialog(
              context: context,
              builder: (BuildContext context) {
                return blockConfirmation(
                  context: context,
                  title: 'Apakah yakin mengabaikannya?',
                  subtitle:
                      'Setelah anda mengabaikannya, maka laporan dianggap selesai',
                  button1: 'Batalkan',
                    button2: 'Abaikan',
                  function: () {
                    Navigator.pop(context);
                  },
                );
              },
            );
          },
          child: Container(
            width: MediaQuery.of(context).size.width,
            color: NomizoTheme.nomizoDark.shade50,
            padding: const EdgeInsets.all(16),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // moderator profile picture
                circlePic(42, replyModel[index].reporter!.profileImage!),
                const SizedBox(width: 8),
                // moderator report section
                Flexible(
                  child: reportDescription(
                    reporterName: replyModel[index].reporter!.username!,
                    highlight: replyModel[index].reply!.content!,
                    type: 'reply',
                    time: replyModel[index].createdAt!,
                    reason: replyModel[index].reason!.detail!,
                  ),
                ),
                // isReviewed
                Badge(
                  badgeColor: NomizoTheme.nomizoRed.shade600,
                  position: BadgePosition.topEnd(top: 0, end: 0),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  // report category item
  Widget reportCategoryItem(List<category.ReportCategoryModel> categoryModel) {
    if (categoryModel.isEmpty) {
      return const Center(
        child: Text('Laporan Kosong'),
      );
    }
    return ListView.builder(
      itemCount: categoryModel.length,
      itemBuilder: (context, index) {
        return InkWell(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => ReportCategoryScreen(
                  idCategory: categoryModel[index].topic!.id!,
                ),
              ),
            );
          },
          child: Container(
            width: MediaQuery.of(context).size.width,
            color: NomizoTheme.nomizoDark.shade50,
            padding: const EdgeInsets.all(16),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // moderator profile picture
                circlePic(42, '${categoryModel[index].reporter!.profileImage}'),
                const SizedBox(width: 8),
                // moderator report section
                Flexible(
                  child: reportDescription(
                    reporterName: categoryModel[index].reporter!.username!,
                    highlight: categoryModel[index].topic!.name!,
                    type: 'category',
                    time: categoryModel[index].createdAt!,
                    reason: categoryModel[index].reason!.detail!,
                  ),
                ),
                // isReviewed
                Badge(
                  badgeColor: NomizoTheme.nomizoRed.shade600,
                  position: BadgePosition.topEnd(top: 0, end: 0),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  // report user item
  Widget reportUserItem(List<user.ReportUserModel> userModel) {
    if (userModel.isEmpty) {
      return const Center(
        child: Text('Laporan Kosong'),
      );
    }
    return ListView.builder(
      itemCount: userModel.length,
      itemBuilder: (context, index) {
        return InkWell(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => ReportUserScreen(
                  idUser: userModel[index].suspect!.id!,
                ),
              ),
            );
          },
          child: Container(
            width: MediaQuery.of(context).size.width,
            color: NomizoTheme.nomizoDark.shade50,
            padding: const EdgeInsets.all(16),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // moderator profile picture
                circlePic(42, '${userModel[index].reporter!.profileImage}'),
                const SizedBox(width: 8),
                // moderator report section
                Flexible(
                  child: reportDescription(
                    reporterName: '${userModel[index].reporter!.username}',
                    highlight: '@${userModel[index].suspect!.username!}',
                    type: 'user',
                    time: userModel[index].createdAt!,
                    reason: userModel[index].reason!.detail!,
                  ),
                ),
                // isReviewed
                Badge(
                  badgeColor: NomizoTheme.nomizoRed.shade600,
                  position: BadgePosition.topEnd(top: 0, end: 0),
                ),
              ],
            ),
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
}
