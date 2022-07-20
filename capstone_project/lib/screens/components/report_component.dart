// import package
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

// import theme
import 'package:capstone_project/themes/nomizo_theme.dart';

// import component
import 'package:capstone_project/screens/components/card_widget.dart';

// import provider
import 'package:capstone_project/modelview/user_provider.dart';
import 'package:capstone_project/modelview/category_provider.dart';
import 'package:capstone_project/modelview/detail_thread_provider.dart';

class ReportComponent extends StatefulWidget {
  final String type;
  const ReportComponent({Key? key, required this.type}) : super(key: key);

  @override
  State<ReportComponent> createState() => _ReportComponentState();
}

class _ReportComponentState extends State<ReportComponent> {
  final List<String> reportCause = [
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
  late final String reportType;

  @override
  void initState() {
    reportType = widget.type;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
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
              return moreMenu(index: index, type: reportType);
            },
          ),
          const SizedBox(height: 10),
        ],
      ),
    );
  }

  Widget moreMenu({required int index, required String type}) {
    return InkWell(
      onTap: reportFunction(type, index != 0 ? index + 2 : index + 1),
      child: Column(
        children: [
          Container(
            height: 42,
            width: MediaQuery.of(context).size.width,
            padding: const EdgeInsets.symmetric(horizontal: 16),
            alignment: Alignment.centerLeft,
            child: Text(
              reportCause[index],
              style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                    fontWeight: FontWeight.w500,
                  ),
            ),
          ),
        ],
      ),
    );
  }

  /// Get Report Function based on report type
  void Function()? reportFunction(String type, int reasonId) {
    void Function()? reportFunction;

    /// function based on report type
    switch (type) {
      case "category":
        final provider = Provider.of<CategoryProvider>(context, listen: false);
        reportFunction = () async {
          buildLoading(context);
          await provider
              .reportCategory(provider.currentCategory, reasonId)
              .then(
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
        reportFunction = () async {
          buildLoading(context);
          await provider
              .reportUser(
            provider.selectedUser!,
            reasonId + 2,
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
        final provider =
            Provider.of<DetailThreadProvider>(context, listen: false);
        reportFunction = () async {
          buildLoading(context);
          await provider.reportThread(provider.currentThread!, reasonId).then(
            (value) {
              Navigator.pop(context);
              Navigator.pop(context);
              buildToast(value);
            },
          );
        };
        break;
      case "reply":
        final provider =
            Provider.of<DetailThreadProvider>(context, listen: false);
        reportFunction = () async {
          buildLoading(context);
          await provider.reportReply(provider.selectedReply!, reasonId).then(
            (value) {
              Navigator.pop(context);
              Navigator.pop(context);
              buildToast(value);
            },
          );
        };
        break;
      default:
        final provider =
            Provider.of<DetailThreadProvider>(context, listen: false);
        reportFunction = () async {
          showDialog(
              context: context,
              builder: (context) =>
                  const Center(child: CircularProgressIndicator()));
          await provider.reportReply(provider.repliesThread[0], reasonId).then(
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
}
