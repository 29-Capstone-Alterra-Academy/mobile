// import package
import 'package:capstone_project/screens/components/button_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

// import utils, theme & component
import 'package:capstone_project/utils/finite_state.dart';
import 'package:capstone_project/themes/nomizo_theme.dart';
import 'package:capstone_project/screens/components/card_widget.dart';

import 'package:capstone_project/model/category_model.dart';

import 'package:capstone_project/modelview/category_provider.dart';
import 'package:share_plus/share_plus.dart';

class DetailCategoryScreen extends StatefulWidget {
  final CategoryModel? categoryModel;
  const DetailCategoryScreen({Key? key, this.categoryModel}) : super(key: key);

  @override
  State<DetailCategoryScreen> createState() => _DetailCategoryScreenState();
}

class _DetailCategoryScreenState extends State<DetailCategoryScreen> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      Provider.of<CategoryProvider>(context, listen: false)
          .getCategoryById(widget.categoryModel!.id ?? 0);
      Provider.of<CategoryProvider>(context, listen: false)
          .changePage(0, widget.categoryModel!.name!);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<CategoryProvider>(context, listen: false);
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(
              Icons.keyboard_arrow_left,
            ),
          ),
          title: const Text('Kategori'),
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
                showModalBottomSheet(
                  context: context,
                  shape: const RoundedRectangleBorder(
                    borderRadius:
                        BorderRadius.vertical(top: Radius.circular(16)),
                  ),
                  builder: (context) {
                    return bottomSheetCard(
                      context,
                      // label
                      [
                        'Ajukan diri menjadi moderator',
                        'Bagikan kategori',
                        'Laporkan',
                      ],
                      // functions
                      [
                        // request moderator
                        () async {
                          buildLoading(context);
                          await provider
                              .requestModerator(provider.currentCategory)
                              .then(
                            (value) {
                              Navigator.pop(context);
                              Navigator.pop(context);
                              buildToast(value);
                            },
                          );
                        },
                        // share category
                        () async {
                          Navigator.pop(context);
                          await Share.share('Share');
                        },
                        // report category
                        () {
                          Navigator.pop(context);
                          showModalBottomSheet(
                            shape: const RoundedRectangleBorder(
                              borderRadius: BorderRadius.vertical(
                                  top: Radius.circular(16)),
                            ),
                            isScrollControlled: true,
                            context: context,
                            builder: (context) {
                              return reportCard(context, "category");
                            },
                          );
                        },
                      ],
                    );
                  },
                );
              },
              icon: const Icon(Icons.more_horiz),
            ),
            const SizedBox(width: 16),
          ],
        ),
        body: Consumer<CategoryProvider>(
          builder: (context, value, _) {
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
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: Column(
                        children: [
                          // Profile
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              // pics
                              circlePic(
                                100,
                                value.currentCategory.profileImage!,
                              ),
                              // aktivitas
                              profileDetails(
                                '${value.currentCategory.activityCount}',
                                'Aktivitas',
                              ),
                              // kontibutor
                              InkWell(
                                onTap: () {
                                  Navigator.pushNamed(context, '/contributor');
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
                                  style: Theme.of(context).textTheme.bodyMedium,
                                ),
                                // rules
                                Text(
                                  'Aturan: \n${value.currentCategory.rules}',
                                  style: Theme.of(context).textTheme.bodyMedium,
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 4),
                          // created by
                          Row(
                            children: [
                              Text(
                                'Created by ',
                                style: Theme.of(context)
                                    .textTheme
                                    .bodySmall
                                    ?.copyWith(
                                      color: NomizoTheme.nomizoDark.shade500,
                                    ),
                              ),
                              Text(
                                '@robert',
                                style: Theme.of(context)
                                    .textTheme
                                    .bodySmall
                                    ?.copyWith(
                                      fontWeight: FontWeight.w600,
                                      color: NomizoTheme.nomizoDark.shade500,
                                    ),
                              ),
                              Text(
                                ' on may 2022',
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
                          // follow button
                          value.isSub
                              ? outlinedBtn42(context, () async {
                                  buildLoading(context);
                                  await provider
                                      .unsubscribeCategory(
                                          value.currentCategory.id ?? 9)
                                      .then((value) => Navigator.pop(context));
                                }, 'Mengikuti')
                              : elevatedBtn42(context, () async {
                                  buildLoading(context);
                                  provider
                                      .subscribeCategory(
                                          value.currentCategory.id ?? 9)
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
                        Expanded(
                          child: InkWell(
                            onTap: () {
                              provider.changePage(
                                  0, widget.categoryModel!.name!);
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
                        Expanded(
                          child: InkWell(
                            onTap: () {
                              provider.changePage(
                                  1, widget.categoryModel!.name!);
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
                              // log('Popular Thread');
                              return threadCard(context, value.threads[index]);
                              // return Text('Popular Thread');
                            } else {
                              // log('Newest Thread');
                              return threadCard(context, value.threads[index]);
                              // return Text('Newest Thread');
                            }
                          },
                        );
                      }
                    }),
                  ],
                ),
              );
            }
          },
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {},
          child: const Icon(Icons.add),
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
}
