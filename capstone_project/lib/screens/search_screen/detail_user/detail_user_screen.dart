// import package
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:share_plus/share_plus.dart';

// import utils & theme
import 'package:capstone_project/utils/finite_state.dart';
import 'package:capstone_project/themes/nomizo_theme.dart';

// import component
import 'package:capstone_project/screens/components/card_widget.dart';
import 'package:capstone_project/screens/components/button_widget.dart';
import 'package:capstone_project/screens/components/more_component.dart';
import 'package:capstone_project/screens/components/thread_component.dart';
import 'package:capstone_project/screens/components/report_component.dart';

// import provider
import 'package:capstone_project/modelview/user_provider.dart';

class DetailUserScreen extends StatefulWidget {
  final int idUser;
  const DetailUserScreen({Key? key, required this.idUser}) : super(key: key);

  @override
  State<DetailUserScreen> createState() => _DetailUserScreenState();
}

class _DetailUserScreenState extends State<DetailUserScreen> {
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
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(
            Icons.keyboard_arrow_left,
          ),
        ),
        title: Consumer<UserProvider>(builder: (context, value, _) {
          if (value.state == FiniteState.loading) {
            return Container();
          }
          if (value.state == FiniteState.failed) {
            return const Center(
              child: Text('Something Wrong!!!'),
            );
          } else {
            if (value.selectedUser == null) {
              return Container();
            } else {
              return Text(value.selectedUser!.username!);
            }
          }
        }),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.pushNamed(context, '/searchThread');
            },
            icon: const Icon(Icons.search),
          ),
          const SizedBox(width: 12),
          IconButton(
            onPressed: () {
              showMoreMenu(
                context,
                MoreComponent(
                  myLabels: const <String>[
                    'Bagikan profil pengguna',
                    'Laporkan',
                  ],
                  myFunctions: <void Function()>[
                    // share user
                    () async {
                      Navigator.pop(context);
                      await Share.share('Share');
                    },
                    // report thread
                    () {
                      Navigator.pop(context);
                      showMoreMenu(
                        context,
                        const ReportComponent(type: "user"),
                      );
                    },
                  ],
                ),
              );
            },
            icon: const Icon(Icons.more_horiz),
          ),
          const SizedBox(width: 16),
        ],
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
                              value.selectedUser!.profileImage?? '',
                            ),
                            // activities
                            profileDetails('1,2 K', 'Postingan'),
                            // followers
                            profileDetails('987', 'Pengikut'),
                            // following
                            profileDetails('2', 'Mengikuti'),
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
                                'Raymond silapo',
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyLarge
                                    ?.copyWith(
                                      fontWeight: FontWeight.w600,
                                    ),
                              ),
                              // description
                              Text(
                                'Coba, coba, dan coba lagi. Pantang Menyerah!',
                                style: Theme.of(context).textTheme.bodyMedium,
                              ),
                              const SizedBox(height: 4),
                              // created by
                              Text(
                                'Created on may 2022',
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
                        // follow button
                        value.isSub
                            ? outlinedBtn42(context, () async {
                                buildLoading(context);
                                await provider
                                    .unfollowUser(value.selectedUser!.id ?? 9)
                                    .then((value) => Navigator.pop(context));
                              }, 'Mengikuti')
                            : elevatedBtn42(context, () async {
                                buildLoading(context);
                                provider
                                    .followUser(value.selectedUser!.id ?? 9)
                                    .then((value) => Navigator.pop(context));
                              }, 'Ikuti'),
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
                            provider.changePage(
                                0, value.selectedUser!.username!);
                          },
                          child: Container(
                            height: 44,
                            decoration: BoxDecoration(
                              border: value.currentPage == 0
                                  ? Border(
                                      bottom: BorderSide(
                                        width: 2,
                                        color: NomizoTheme.nomizoDark.shade900,
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
                            provider.changePage(
                                1, value.selectedUser!.username!);
                          },
                          child: Container(
                            height: 44,
                            decoration: BoxDecoration(
                              border: value.currentPage == 1
                                  ? Border(
                                      bottom: BorderSide(
                                        width: 2,
                                        color: NomizoTheme.nomizoDark.shade900,
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
                  Builder(builder: (context) {
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
                      return ListView.builder(
                        itemCount: value.threads.length,
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemBuilder: (context, index) {
                          if (value.currentPage == 0) {
                            return ThreadComponent(
                              threadModel: value.threads[index],
                              isOpened: false,
                            );
                          } else {
                            return ThreadComponent(
                              threadModel: value.threads[index],
                              isOpened: false,
                            );
                          }
                        },
                      );
                    }
                  }),
                ],
              ),
            );
          }
        }
      }),
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
}
