// import package
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

// import utils & theme
import 'package:capstone_project/utils/finite_state.dart';
import 'package:capstone_project/themes/nomizo_theme.dart';

// import component
import 'package:capstone_project/screens/components/thread_card.dart';
import 'package:capstone_project/screens/components/card_widget.dart';
import 'package:capstone_project/screens/components/button_widget.dart';
import 'package:capstone_project/screens/components/reply_component.dart';

// import provider
import 'package:capstone_project/viewmodel/thread_viewmodel/detail_thread_provider.dart';

class ReportThreadScreen extends StatefulWidget {
  final int idThread;
  const ReportThreadScreen({Key? key, required this.idThread})
      : super(key: key);

  @override
  State<ReportThreadScreen> createState() => _ReportThreadScreenState();
}

class _ReportThreadScreenState extends State<ReportThreadScreen> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      Provider.of<DetailThreadProvider>(context, listen: false)
          .loadDetailThread(widget.idThread);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<DetailThreadProvider>(context, listen: false);
    return WillPopScope(
      onWillPop: () async {
        provider.reset();
        return true;
      },
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            onPressed: () {
              provider.reset();
              Navigator.pop(context);
            },
            icon: const Icon(
              Icons.keyboard_arrow_left,
            ),
          ),
          title: const Text('Laporan'),
        ),
        body: Consumer<DetailThreadProvider>(
          builder: (context, value, _) {
            if (value.state == FiniteState.loading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            if (value.state == FiniteState.failed) {
              return const Center(
                child: Text('Something Wrong!!!'),
              );
            } else {
              if (value.currentThread == null) {
                return const Center(
                  child: Text('Thread Tidak Ada'),
                );
              } else {
                return Container(
                  height: MediaQuery.of(context).size.height,
                  margin: const EdgeInsets.only(bottom: 70),
                  child: ListView(
                    shrinkWrap: true,
                    children: [
                      // post
                      threadCard(
                        context: context,
                        threadModel: value.currentThread!,
                        isOpened: true,
                      ),
                      buildDivider(),
                      // comment & reply section
                      if (value.repliesThread.isNotEmpty)
                        ListView.separated(
                          itemCount: value.repliesThread.length,
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          separatorBuilder: (context, index) => buildDivider(),
                          itemBuilder: (context, index) => ReplyComponent(
                            replyModel: value.repliesThread[index],
                            threadModel: value.currentThread!,
                          ),
                        ),
                    ],
                  ),
                );
              }
            }
          },
        ),
        bottomNavigationBar: approvalButton(),
      ),
    );
  }

  Widget approvalButton() {
    return Container(
      height: 57,
      color: NomizoTheme.nomizoDark.shade50,
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          // reject
          outlinedBtn42(
            context,
            () {
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
            'Tolak',
          ),
          // approve
          elevatedBtn42(
            context,
            () {
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
            'Terima',
          ),
        ],
      ),
    );
  }
}
