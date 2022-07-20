// import package
import 'package:capstone_project/screens/components/thread_card.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

// import theme
import 'package:capstone_project/themes/nomizo_theme.dart';

// import component
import 'package:capstone_project/utils/finite_state.dart';
import 'package:capstone_project/screens/components/card_widget.dart';

// import provider
import 'package:capstone_project/modelview/home_screen_provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late final PageController pageController;

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      Provider.of<HomeScreenProvider>(context, listen: false).changePage(1);
    });
    pageController = PageController(initialPage: 1);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final homeProvider =
        Provider.of<HomeScreenProvider>(context, listen: false);
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Consumer<HomeScreenProvider>(
          builder: (context, value, _) {
            return pageTab(homeProvider, value.currentPage);
          },
        ),
      ),
      body: PageView(
        controller: pageController,
        onPageChanged: (index) {
          homeProvider.changePage(index);
        },
        children: [
          followedView(),
          recomendedView(),
        ],
      ),
    );
  }

  /// Page Tab Button
  Widget pageTab(HomeScreenProvider provider, int currentPage) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Expanded(
          child: InkWell(
            onTap: () {
              pageController.previousPage(
                duration: const Duration(milliseconds: 500),
                curve: Curves.easeIn,
              );
            },
            child: Container(
              height: 58,
              alignment: Alignment.centerRight,
              child: Text(
                'Mengikuti',
                textAlign: TextAlign.right,
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      color: currentPage == 0
                          ? NomizoTheme.nomizoDark.shade900
                          : NomizoTheme.nomizoDark.shade500,
                      fontWeight:
                          currentPage == 0 ? FontWeight.w500 : FontWeight.w400,
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
        Expanded(
          child: InkWell(
            onTap: () {
              pageController.nextPage(
                duration: const Duration(milliseconds: 500),
                curve: Curves.easeIn,
              );
            },
            child: Container(
              height: 58,
              alignment: Alignment.centerLeft,
              child: Text(
                'Rekomendasi',
                textAlign: TextAlign.left,
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      color: currentPage == 1
                          ? NomizoTheme.nomizoDark.shade900
                          : NomizoTheme.nomizoDark.shade500,
                      fontWeight:
                          currentPage == 1 ? FontWeight.w500 : FontWeight.w400,
                    ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  // thread from followed topic
  Widget followedView() {
    return Consumer<HomeScreenProvider>(
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
          if (value.followed.isEmpty) {
            return const Center(
              child: Text('Thread Tidak ada'),
            );
          } else {
            return ListView.separated(
              itemCount: value.followed.length,
              separatorBuilder: (context, index) => buildDivider(),
              itemBuilder: (context, index) {
                return threadCard(
                  context: context,
                  threadModel: value.followed[index],
                  isOpened: false,
                );
              },
            );
          }
        }
      },
    );
  }

  // recomended thread
  Widget recomendedView() {
    return Consumer<HomeScreenProvider>(
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
          if (value.recomended.isEmpty) {
            return const Center(
              child: Text('Thread Tidak ada'),
            );
          } else {
            return ListView.separated(
              itemCount: value.recomended.length,
              separatorBuilder: (context, index) => buildDivider(),
              itemBuilder: (context, index) {
                return threadCard(
                  context: context,
                  threadModel: value.recomended[index],
                  isOpened: false,
                );
              },
            );
          }
        }
      },
    );
  }
}
