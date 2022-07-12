// import package
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

// import theme
import 'package:capstone_project/themes/nomizo_theme.dart';

// import component
import 'package:capstone_project/utils/finite_state.dart';
import 'package:capstone_project/screens/components/card_widget.dart';

// import item
import 'package:capstone_project/screens/admin/home_screen/blocked_item.dart';
import 'package:capstone_project/screens/admin/home_screen/block_request_item.dart';

// import provider
import 'package:capstone_project/modelview/admin/admin_home_provider.dart';

class AdminHomeScreen extends StatefulWidget {
  const AdminHomeScreen({Key? key}) : super(key: key);

  @override
  State<AdminHomeScreen> createState() => _AdminHomeScreenState();
}

class _AdminHomeScreenState extends State<AdminHomeScreen> {
  final PageController pageController = PageController();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final homeProvider = Provider.of<AdminHomeProvider>(context, listen: false);
    return Consumer<AdminHomeProvider>(builder: (context, value, _) {
      return Scaffold(
        appBar: AppBar(
            automaticallyImplyLeading: false,
            title: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // blocked tab
                Expanded(
                  child: InkWell(
                    onTap: () {
                      homeProvider.changePage(0);
                      pageController.jumpTo(0);
                      // homeProvider.getThread('like');
                    },
                    child: Container(
                      height: 58,
                      alignment: Alignment.centerRight,
                      child: Text(
                        'Terblokir',
                        textAlign: TextAlign.right,
                        style:
                            Theme.of(context).textTheme.titleMedium?.copyWith(
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
                SizedBox(
                  height: 25,
                  child: VerticalDivider(
                    color: NomizoTheme.nomizoDark.shade100,
                    thickness: 1,
                    indent: 5,
                    endIndent: 0,
                  ),
                ),
                // block request tab
                Expanded(
                  child: InkWell(
                    onTap: () {
                      homeProvider.changePage(1);
                      pageController.jumpTo(1);
                    },
                    child: Container(
                      height: 58,
                      alignment: Alignment.centerLeft,
                      child: Text(
                        'Permintaan Blokir',
                        textAlign: TextAlign.left,
                        style:
                            Theme.of(context).textTheme.titleMedium?.copyWith(
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
              ],
            )),
        body: PageView.builder(
          controller: pageController,
          itemCount: 2,
          onPageChanged: (index) {
            homeProvider.changePage(index);
          },
          itemBuilder: (context, index) {
            if (value.currentPage == 0) {
              return blockedView();
            } else {
              return requestView();
            }
          },
        ),
      );
    });
  }

  // Blocked Tab View
  Widget blockedView() {
    return Consumer<AdminHomeProvider>(
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
          // if (value.blocked.isEmpty) {
          //   return noBlockFound();
          // }
          return ListView.separated(
            itemCount: 2,
            separatorBuilder: (context, index) => buildDivider(),
            itemBuilder: (context, index) {
              return const BlockedItem();
            },
          );
        }
      },
    );
  }

  // Bloc Request Tab View
  Widget requestView() {
    return Consumer<AdminHomeProvider>(
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
          // if (value.blocked.isEmpty) {
          //   return noBlockFound();
          // }
          return ListView.separated(
            itemCount: 1,
            separatorBuilder: (context, index) => buildDivider(),
            itemBuilder: (context, index) {
              return const BlockRequestItem();
            },
          );
        }
      },
    );
  }

  // No Block Found View
  Widget noBlockFound() {
    return Center(
      child: Container(
        width: MediaQuery.of(context).size.width,
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // not found image
            Image.asset(
              'assets/img/not_found.png',
              width: 168,
              height: 120,
            ),
            const SizedBox(height: 18),
            // not found title
            Text(
              'Oops, Maaf !',
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.w600,
                    color: NomizoTheme.nomizoRed.shade600,
                  ),
            ),
            // not found descriotion
            Text(
              'Belum ada Postingan, Komentar, Kategori,\ndan pengguna yang telah diblokir',
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            const SizedBox(height: 18),
          ],
        ),
      ),
    );
  }
}
