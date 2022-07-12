import 'package:capstone_project/model/category_model.dart';
import 'package:capstone_project/modelview/admin/admin_moderator_provider.dart';
import 'package:capstone_project/screens/admin/moderator_screen/category_item.dart';
import 'package:capstone_project/screens/admin/moderator_screen/request_moderator_item.dart';
import 'package:capstone_project/screens/components/card_widget.dart';
import 'package:capstone_project/themes/nomizo_theme.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ModeratorScreen extends StatefulWidget {
  const ModeratorScreen({Key? key}) : super(key: key);

  @override
  State<ModeratorScreen> createState() => _ModeratorScreenState();
}

class _ModeratorScreenState extends State<ModeratorScreen> {
  final PageController pageController = PageController();
  final TextEditingController searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final homeProvider =
        Provider.of<AdminModeratorProvider>(context, listen: false);
    return Consumer<AdminModeratorProvider>(
      builder: (context, value, _) {
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
                          'Moderator Aktif',
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
                          'Permohonan',
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
                return activeModeratorView();
              } else {
                return requestModeratorView();
              }
            },
          ),
        );
      },
    );
  }

  // Active Moderator View
  Widget activeModeratorView() {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      child: ListView(
        children: [
          Container(
            height: 58,
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: TextField(
              controller: searchController,
              readOnly: true,
              style: Theme.of(context).textTheme.bodyMedium,
              onTap: () => Navigator.pushNamed(context, '/moderatorSearch'),
              decoration: InputDecoration(
                isDense: true,
                border: const OutlineInputBorder(
                  borderRadius: BorderRadius.all(
                    Radius.circular(4),
                  ),
                ),
                prefixIcon: Icon(
                  Icons.search,
                  color: NomizoTheme.nomizoDark.shade900,
                ),
                hintText: 'Cari berdasarkan kategori',
                hintStyle: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: NomizoTheme.nomizoDark.shade500,
                    ),
              ),
            ),
          ),
          ListView.builder(
            itemCount: 10,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemBuilder: (context, index) {
              return CategoryItem(
                categoryModel: CategoryModel(
                  activityCount: 0,
                  contributorCount: 0,
                  description: 'jkjkj',
                  id: 88,
                  moderatorCount: 0,
                  name: 'Covid-19',
                  profileImage: '',
                  rules: 'rules',
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  // Reuqest Moderator View
  Widget requestModeratorView() {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      padding: const EdgeInsets.only(top: 12),
      child: ListView.separated(
        itemCount: 2,
        separatorBuilder: (context, index) => buildDivider(),
        itemBuilder: (context, index) {
          return const RequestModeratorItem();
        },
      ),
    );
  }
}
