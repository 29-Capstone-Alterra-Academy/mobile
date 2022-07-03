// import package
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

// import utils, theme & component
import 'package:capstone_project/utils/finite_state.dart';
import 'package:capstone_project/themes/nomizo_theme.dart';
import 'package:capstone_project/screens/components/card_widget.dart';

// import model
import 'package:capstone_project/model/user_model.dart';
import 'package:capstone_project/model/thread_model.dart';
import 'package:capstone_project/model/category_model.dart';

// import provider
import 'package:capstone_project/modelview/search_screen_provider.dart';

// import screen
import 'package:capstone_project/screens/search_screen/focused_search_screen.dart';

class SearchResultScreen extends StatefulWidget {
  final String value;
  const SearchResultScreen(this.value, {Key? key}) : super(key: key);

  @override
  State<SearchResultScreen> createState() => _SearchResultScreenState();
}

class _SearchResultScreenState extends State<SearchResultScreen> {
  late final TextEditingController _searchController;

  @override
  void initState() {
    _searchController = TextEditingController(text: widget.value);
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      Provider.of<SearchScreenProvider>(context, listen: false)
          .getSearchResult(widget.value);
    });
    super.initState();
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 4,
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
          title: TextField(
            controller: _searchController,
            onTap: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (_) => FocusedSearchScreen(_searchController.text),
                ),
              );
            },
            decoration: InputDecoration(
              prefixIcon: const Icon(Icons.search),
              hintText: 'Cari disini...',
              suffixIcon: IconButton(
                onPressed: () {
                  _searchController.clear();
                },
                icon: const Icon(Icons.close),
              ),
              isDense: true,
              border: const OutlineInputBorder(
                borderRadius: BorderRadius.all(
                  Radius.circular(4),
                ),
              ),
            ),
          ),
          bottom: const TabBar(
            tabs: [
              SizedBox(
                height: 42,
                child: Center(child: Text('Populer')),
              ),
              SizedBox(
                height: 42,
                child: Center(child: Text('Terbaru')),
              ),
              SizedBox(
                height: 42,
                child: Center(child: Text('Kategori')),
              ),
              SizedBox(
                height: 42,
                child: Center(child: Text('Kreator')),
              ),
            ],
          ),
        ),
        body: Consumer<SearchScreenProvider>(builder: (context, value, _) {
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
            return TabBarView(
              children: [
                threadTabView(value.searchResult.threads),
                // threadTabView('date'),
                notFound(context),
                categoryTabView(value.searchResult.topics),
                usersTabView(value.searchResult.users),
              ],
            );
          }
        }),
      ),
    );
  }

  Widget threadTabView(List<ThreadModel>? threadModel) {
    if (threadModel == null) {
      return notFound(context);
    }
    return ListView.separated(
      itemCount: threadModel.length,
      separatorBuilder: (context, index) => Divider(
        height: 1,
        color: NomizoTheme.nomizoDark.shade100,
      ),
      itemBuilder: (context, index) {
        return threadCard(context, threadModel[index]);
      },
    );
  }

  // Widget newThreadTabView() {
  //   return ListView.separated(
  //     itemCount: 3,
  //     separatorBuilder: (context, index) => Divider(
  //       height: 1,
  //       color: NomizoTheme.nomizoDark.shade100,
  //     ),
  //     itemBuilder: (context, index) {
  //       return threadCard(context);
  //     },
  //   );
  // }

  Widget categoryTabView(List<CategoryModel>? categoryModel) {
    if (categoryModel == null) {
      return notFound(context);
    }
    return ListView.separated(
      itemCount: categoryModel.length,
      padding: const EdgeInsets.symmetric(horizontal: 16),
      separatorBuilder: (context, index) => Divider(
        height: 1,
        color: NomizoTheme.nomizoDark.shade100,
      ),
      itemBuilder: (context, index) {
        return categoryCard(context, categoryModel[index]);
      },
    );
  }

  Widget usersTabView(List<UserModel>? userModel) {
    if (userModel == null) {
      return notFound(context);
    }
    return ListView.separated(
      itemCount: userModel.length,
      padding: const EdgeInsets.symmetric(horizontal: 16),
      separatorBuilder: (context, index) => Divider(
        height: 1,
        color: NomizoTheme.nomizoDark.shade100,
      ),
      itemBuilder: (context, index) {
        return userCard(context, userModel[index]);
      },
    );
  }
}
