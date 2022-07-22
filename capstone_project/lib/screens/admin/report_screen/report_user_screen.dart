// import package
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

// import utils & theme
import 'package:capstone_project/utils/url.dart';
import 'package:capstone_project/utils/finite_state.dart';
import 'package:capstone_project/themes/nomizo_theme.dart';

// import component
import 'package:capstone_project/screens/components/thread_card.dart';
import 'package:capstone_project/screens/components/card_widget.dart';
import 'package:capstone_project/screens/components/button_widget.dart';

// import provider
import 'package:capstone_project/viewmodel/user_viewmodel/user_provider.dart';

class ReportUserScreen extends StatefulWidget {
  final int idUser;
  const ReportUserScreen({Key? key, required this.idUser}) : super(key: key);

  @override
  State<ReportUserScreen> createState() => _ReportUserScreenState();
}

class _ReportUserScreenState extends State<ReportUserScreen> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      Provider.of<UserProvider>(context, listen: false)
          .getDetailUser(widget.idUser);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<UserProvider>(context, listen: false);
    return WillPopScope(
      onWillPop: () async {
        provider.resetPage();
        return true;
      },
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            onPressed: () {
              provider.resetPage();
              Navigator.pop(context);
            },
            icon: const Icon(
              Icons.keyboard_arrow_left,
            ),
          ),
          title: const Text('Laporan'),
        ),
        body: Consumer<UserProvider>(builder: (context, value, _) {
          if (value.state == FiniteState.loading) {
            return Center(
              child: CircularProgressIndicator(
                color: NomizoTheme.nomizoTosca.shade600,
              ),
            );
          }
          if (value.state == FiniteState.failed) {
            return const Center(
              child: Text('Something Wrong!!!'),
            );
          } else {
            if (value.selectedUser == null) {
              return Container();
            } else {
              var convert = DateTime.parse(value.selectedUser!.createdAt ??
                  DateTime.now().toIso8601String());
              String createdTime = DateFormat('MMMM yyyy').format(convert);
              return SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 12),
                      child: Column(
                        children: [
                          // Profile
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              // pics
                              circlePic(
                                100,
                                '$baseURL/public/assets/${value.selectedUser!.profileImage}',
                              ),
                              // activities
                              profileDetails(
                                '${value.selectedUser?.threadCount!}',
                                'Postingan',
                              ),
                              // followers
                              profileDetails(
                                '${value.selectedUser?.followersCount!}',
                                'Pengikut',
                              ),
                              // following
                              profileDetails(
                                '${value.selectedUser?.followingCount!}',
                                'Mengikuti',
                              ),
                            ],
                          ),
                          const SizedBox(height: 12),
                          // Details
                          SizedBox(
                            width: MediaQuery.of(context).size.width,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                // full name
                                Text(
                                  value.selectedUser!.username ?? '',
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyLarge
                                      ?.copyWith(
                                        fontWeight: FontWeight.w600,
                                      ),
                                ),
                                // description
                                Text(
                                  value.selectedUser!.bio ?? '',
                                  style: Theme.of(context).textTheme.bodyMedium,
                                ),
                                const SizedBox(height: 4),
                                // created by
                                Text(
                                  'Created on $createdTime',
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodySmall
                                      ?.copyWith(
                                        color: NomizoTheme.nomizoDark.shade500,
                                      ),
                                ),
                              ],
                            ),
                          ),

                          const SizedBox(height: 12),
                        ],
                      ),
                    ),
                    const SizedBox(height: 12),
                    // button tab
                    Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        // popular tab
                        Expanded(
                          child: InkWell(
                            onTap: () {
                              provider.changePage(0, value.selectedUser!.iD!);
                            },
                            child: Container(
                              height: 44,
                              decoration: BoxDecoration(
                                border: value.currentPage == 0
                                    ? Border(
                                        bottom: BorderSide(
                                          width: 2,
                                          color:
                                              NomizoTheme.nomizoDark.shade900,
                                        ),
                                      )
                                    : const Border(),
                              ),
                              child: Center(
                                child: Text(
                                  'Populer',
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyMedium
                                      ?.copyWith(
                                        color: value.currentPage == 0
                                            ? NomizoTheme.nomizoDark.shade900
                                            : NomizoTheme.nomizoDark.shade500,
                                        fontWeight: value.currentPage == 0
                                            ? FontWeight.w600
                                            : FontWeight.w500,
                                      ),
                                ),
                              ),
                            ),
                          ),
                        ),
                        // newest tab
                        Expanded(
                          child: InkWell(
                            onTap: () {
                              provider.changePage(1, value.selectedUser!.iD!);
                            },
                            child: Container(
                              height: 44,
                              decoration: BoxDecoration(
                                border: value.currentPage == 1
                                    ? Border(
                                        bottom: BorderSide(
                                          width: 2,
                                          color:
                                              NomizoTheme.nomizoDark.shade900,
                                        ),
                                      )
                                    : const Border(),
                              ),
                              child: Center(
                                child: Text(
                                  'Terbaru',
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyMedium
                                      ?.copyWith(
                                        color: value.currentPage == 1
                                            ? NomizoTheme.nomizoDark.shade900
                                            : NomizoTheme.nomizoDark.shade500,
                                        fontWeight: value.currentPage == 1
                                            ? FontWeight.w600
                                            : FontWeight.w500,
                                      ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    IgnorePointer(
                      ignoring: true,
                      child: Builder(builder: (context) {
                        if (value.subState == FiniteState.loading) {
                          return SizedBox(
                            height: 200,
                            child: Center(
                              child: CircularProgressIndicator(
                                color: NomizoTheme.nomizoTosca.shade600,
                              ),
                            ),
                          );
                        }
                        if (value.subState == FiniteState.failed) {
                          return const SizedBox(
                            height: 200,
                            child: Center(
                              child: Text('Something Wrong!!!'),
                            ),
                          );
                        } else {
                          if (value.threads.isEmpty) {
                            return const SizedBox(
                                height: 200,
                                child: Center(child: Text('Tidak Ada Thread')));
                          }
                          return ListView.separated(
                            itemCount: value.threads.length,
                            separatorBuilder: (context, index) =>
                                buildDivider(),
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemBuilder: (context, index) {
                              if (value.currentPage == 0) {
                                return threadCard(
                                  context: context,
                                  threadModel: value.threads[index],
                                  isOpened: false,
                                );
                              } else {
                                return threadCard(
                                  context: context,
                                  threadModel: value.threads[index],
                                  isOpened: false,
                                );
                              }
                            },
                          );
                        }
                      }),
                    ),
                  ],
                ),
              );
            }
          }
        }),
        bottomNavigationBar: approvalButton(),
      ),
    );
  }

  Widget profileDetails(String count, String label) {
    return Column(
      children: [
        Text(
          count,
          style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                fontWeight: FontWeight.w600,
              ),
        ),
        Text(
          label,
          style: Theme.of(context).textTheme.bodySmall,
        ),
      ],
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
