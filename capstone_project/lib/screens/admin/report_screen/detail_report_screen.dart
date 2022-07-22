import 'package:flutter/material.dart';

class DetailReportScreen extends StatefulWidget {
  final int tabIndex;
  final int? threadId;
  final int? replyId;
  final int? categoryId;
  final int? userId;
  const DetailReportScreen({
    Key? key,
    required this.tabIndex,
    this.threadId,
    this.replyId,
    this.categoryId,
    this.userId,
  }) : super(key: key);

  @override
  State<DetailReportScreen> createState() => _DetailReportScreenState();
}

class _DetailReportScreenState extends State<DetailReportScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        leading: InkWell(
          onTap: () {
            Navigator.pop(context);
          },
          child: const Icon(Icons.keyboard_arrow_left),
        ),
        title: const Text('Laporan'),
      ),
      body: loadDetailReport(),
    );
  }

  Widget loadDetailReport() {
    switch (widget.tabIndex) {
      case 0:
        return showThread();

      case 1:
        return showReply();

      case 2:
        return showCategory();

      case 3:
        return showUser();

      default:
        return Container();
    }
  }

  /// show the detail of reported thread
  Widget showThread() {
    return Container(
      width: 100,
      height: 100,
      color: Colors.yellow,
    );
  }

  /// show the detail of reported reply
  Widget showReply() {
    return Container(
      width: 100,
      height: 100,
      color: Colors.red,
    );
  }

  /// show the detail of reported category
  Widget showCategory() {
    return Container(
      width: 100,
      height: 100,
      color: Colors.green,
    );
  }

  /// show the detail of reported user
  Widget showUser() {
    return Container(
      width: 100,
      height: 100,
      color: Colors.blue,
    );
  }
}
