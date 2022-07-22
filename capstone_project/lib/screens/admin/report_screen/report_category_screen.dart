// import package
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

// import utils, theme
import 'package:capstone_project/utils/finite_state.dart';
import 'package:capstone_project/themes/nomizo_theme.dart';
import 'package:capstone_project/screens/components/card_widget.dart';

// import component
import 'package:capstone_project/screens/components/thread_card.dart';
import 'package:capstone_project/screens/components/button_widget.dart';

// import model
import 'package:capstone_project/model/thread_model/thread_model.dart';

// import provider
import 'package:capstone_project/viewmodel/category_viewmodel/category_provider.dart';

class ReportCategoryScreen extends StatefulWidget {
  final int idCategory;
  const ReportCategoryScreen({Key? key, required this.idCategory})
      : super(key: key);

  @override
  State<ReportCategoryScreen> createState() => _ReportCategoryScreenState();
}

class _ReportCategoryScreenState extends State<ReportCategoryScreen> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      Provider.of<CategoryProvider>(context, listen: false)
          .getDetailCategory(widget.idCategory);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<CategoryProvider>(context, listen: false);
    return WillPopScope(
      onWillPop: () async {
        provider.resetPage();
        return true;
      },
      child: DefaultTabController(
        length: 2,
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
          body: Consumer<CategoryProvider>(
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
                if (value.currentCategory.id == null) {
                  return Container();
                }
                var convert = DateTime.parse(value.currentCategory.createdAt ??
                    DateTime.now().toIso8601String());
                String createdTime = DateFormat('MMMM yyyy').format(convert);
                return SingleChildScrollView(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Padding(
                        padding: const EdgeInsets.fromLTRB(16, 12, 16, 12),
                        child: Column(
                          children: [
                            // Profile
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                // pics
                                circlePic(
                                  100,
                                  value.currentCategory.profileImage ?? '',
                                ),
                                // aktivitas
                                profileDetails(
                                  '${value.currentCategory.activityCount}',
                                  'Aktivitas',
                                ),
                                // kontibutor
                                InkWell(
                                  onTap: () {
                                    // Navigator.pushNamed(
                                    //     context, '/contributor');
                                  },
                                  child: profileDetails(
                                    '${value.currentCategory.contributorCount}',
                                    'Kontributor',
                                  ),
                                ),
                                // moderator
                                InkWell(
                                  onTap: () {
                                    Navigator.pushNamed(context, '/moderator');
                                  },
                                  child: profileDetails(
                                    '${value.currentCategory.moderatorCount}',
                                    'Moderator',
                                  ),
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
                                  // title
                                  Text(
                                    value.currentCategory.name ?? 'Nama Topic',
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyLarge
                                        ?.copyWith(
                                          fontWeight: FontWeight.w600,
                                        ),
                                  ),
                                  // description
                                  Text(
                                    value.currentCategory.description ??
                                        'Deskripsi Topic',
                                    style:
                                        Theme.of(context).textTheme.bodyMedium,
                                  ),
                                  // rules
                                  Text(
                                    'Aturan: \n${value.currentCategory.rules}',
                                    style:
                                        Theme.of(context).textTheme.bodyMedium,
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(height: 4),
                            // created by
                            Row(
                              children: [
                                Text(
                                  'Created ',
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodySmall
                                      ?.copyWith(
                                        color: NomizoTheme.nomizoDark.shade500,
                                      ),
                                ),
                                // Text(
                                //   '@robert',
                                //   style: Theme.of(context)
                                //       .textTheme
                                //       .bodySmall
                                //       ?.copyWith(
                                //         fontWeight: FontWeight.w600,
                                //         color: NomizoTheme.nomizoDark.shade500,
                                //       ),
                                // ),
                                Text(
                                  ' on $createdTime',
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodySmall
                                      ?.copyWith(
                                        color: NomizoTheme.nomizoDark.shade500,
                                      ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 12),
                          ],
                        ),
                      ),
                      const SizedBox(height: 12),
                      // button tab
                      pageTabButton(
                        provider,
                        value.currentPage,
                        value.currentCategory.id!,
                      ),
                      IgnorePointer(
                        ignoring: true,
                        child: threadView(
                          value.subState,
                          value.currentPage,
                          value.threads,
                        ),
                      ),
                    ],
                  ),
                );
              }
            },
          ),
          bottomNavigationBar: approvalButton(),
        ),
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

  // page view tab section
  Widget pageTabButton(CategoryProvider provider, int page, int idCategory) {
    return Row(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Expanded(
          child: InkWell(
            onTap: () {
              provider.changePage(0, idCategory);
            },
            child: Container(
              height: 44,
              decoration: BoxDecoration(
                border: page == 0
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
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: page == 0
                            ? NomizoTheme.nomizoDark.shade900
                            : NomizoTheme.nomizoDark.shade500,
                        fontWeight:
                            page == 0 ? FontWeight.w600 : FontWeight.w500,
                      ),
                ),
              ),
            ),
          ),
        ),
        Expanded(
          child: InkWell(
            onTap: () {
              provider.changePage(1, idCategory);
            },
            child: Container(
              height: 44,
              decoration: BoxDecoration(
                border: page == 1
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
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: page == 1
                            ? NomizoTheme.nomizoDark.shade900
                            : NomizoTheme.nomizoDark.shade500,
                        fontWeight:
                            page == 1 ? FontWeight.w600 : FontWeight.w500,
                      ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  // thread view section
  Widget threadView(FiniteState state, int page, List<ThreadModel> threads) {
    if (state == FiniteState.loading) {
      return SizedBox(
        height: 200,
        child: Center(
          child: CircularProgressIndicator(
            color: NomizoTheme.nomizoTosca.shade600,
          ),
        ),
      );
    }
    if (state == FiniteState.failed) {
      return const SizedBox(
        height: 200,
        child: Center(
          child: Text('Something Wrong!!!'),
        ),
      );
    } else {
      if (threads.isEmpty) {
        return const SizedBox(
            height: 200, child: Center(child: Text('Tidak Ada Thread')));
      }
      return ListView.separated(
        itemCount: threads.length,
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        separatorBuilder: (context, index) => buildDivider(),
        itemBuilder: (context, index) {
          if (page == 0) {
            // Popular Thread
            return threadCard(
              context: context,
              threadModel: threads[index],
              isOpened: false,
            );
          } else {
            // Newest Thread
            return threadCard(
              context: context,
              threadModel: threads[index],
              isOpened: false,
            );
          }
        },
      );
    }
  }

  // approval button
  Widget approvalButton() {
    return Container(
      height: 57,
      color: NomizoTheme.nomizoDark.shade50,
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      alignment: Alignment.center,
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
