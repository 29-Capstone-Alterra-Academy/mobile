import 'package:capstone_project/modelview/profile_provider.dart';
import 'package:capstone_project/screens/components/card_widget.dart';
import 'package:capstone_project/screens/components/more_component.dart';
import 'package:capstone_project/screens/components/thread_component.dart';
import 'package:capstone_project/themes/nomizo_theme.dart';
import 'package:capstone_project/utils/finite_state.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      Provider.of<ProfileProvider>(context, listen: false).changePage(0);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<ProfileProvider>(context, listen: false);
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Consumer<ProfileProvider>(builder: (context, value, _) {
          if (value.state == FiniteState.loading) {
            return Container();
          }
          if (value.state == FiniteState.failed) {
            return const Center(
              child: Text('Something Wrong!!!'),
            );
          } else {
            return Text(value.currentUser!.username!);
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
                    'Edit profil',
                    'Keluar',
                  ],
                  myFunctions: <void Function()>[
                    // edit profile
                    () {
                      Navigator.pop(context);
                      Navigator.pushNamed(context, '/editProfile');
                    },
                    // report thread
                    () {
                      Navigator.pushNamedAndRemoveUntil(
                        context,
                        '/login',
                        (route) => false,
                      );
                    }
                  ],
                ),
              );
            },
            icon: const Icon(Icons.more_horiz),
          ),
          const SizedBox(width: 16),
        ],
      ),
      body: Consumer<ProfileProvider>(builder: (context, value, _) {
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
          return SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                  child: Column(
                    children: [
                      // Profile
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          // pics
                          circlePic(
                            100,
                            value.currentUser!.profileImage ?? '',
                          ),
                          // activities
                          profileDetails(
                            context: context,
                            count: '1',
                            label: 'Postingan',
                          ),
                          // followers
                          profileDetails(
                            context: context,
                            count: '987',
                            label: 'Aktivitas',
                          ),
                          // following
                          profileDetails(
                            context: context,
                            count: '2',
                            label: 'Mengikuti',
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
                              value.currentUser!.username ?? 'Full Name',
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyLarge
                                  ?.copyWith(
                                    fontWeight: FontWeight.w600,
                                  ),
                            ),
                            // description
                            Text(
                              'Deskripsi Bio',
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
                    ],
                  ),
                ),
                // button tab
                Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // popular tab
                    Expanded(
                      child: InkWell(
                        onTap: () {
                          provider.changePage(0);
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
                          provider.changePage(1);
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
      }),
    );
  }

  Widget profileDetails({
    required BuildContext context,
    required String count,
    required String label,
  }) {
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
