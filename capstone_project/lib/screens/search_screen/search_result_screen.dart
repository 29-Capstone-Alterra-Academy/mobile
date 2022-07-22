// import package
import 'package:capstone_project/viewmodel/search_viewmodel/search_history_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

// import utils, theme & component
import 'package:capstone_project/utils/finite_state.dart';
import 'package:capstone_project/themes/nomizo_theme.dart';
import 'package:capstone_project/screens/components/card_widget.dart';
import 'package:capstone_project/screens/components/thread_card.dart';

// import model
import 'package:capstone_project/model/thread_model/thread_model.dart';
import 'package:capstone_project/model/user_model/user_model.dart';
import 'package:capstone_project/model/search_model/search_user_model.dart';
import 'package:capstone_project/model/search_model/search_category_model.dart';

// import provider
import 'package:capstone_project/viewmodel/search_viewmodel/search_screen_provider.dart';

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
      Provider.of<SearchHistoryProvider>(context, listen: false)
          .checkHistory(widget.value);
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
                threadTabView(value.searchThread),
                newThreadTabView(value.searchThread),
                categoryTabView(value.searchCategory),
                usersTabView(value.searchUser),
                // notFound(context),
                // notFound(context),
                // notFound(context),
                // notFound(context),
              ],
            );
          }
        }),
      ),
    );
  }

  Widget threadTabView(List<ThreadModel> threadModel) {
    if (threadModel.isEmpty) {
      return notFound(context);
    } else {
      // reverse sort by reply + like count
      threadModel.sort(
        (a, b) => (a.replyCount! + a.likedCount!).compareTo(
          (b.replyCount! + b.likedCount!),
        ),
      );
      threadModel = threadModel.reversed.toList();
      return ListView.separated(
        itemCount: threadModel.length,
        separatorBuilder: (context, index) => buildDivider(),
        itemBuilder: (context, index) => threadCard(
          context: context,
          threadModel: threadModel[index],
          isOpened: false,
        ),
      );
    }
  }

  Widget newThreadTabView(List<ThreadModel> threadModel) {
    if (threadModel.isEmpty) {
      return notFound(context);
    } else {
      // reverse sort by update date
      threadModel.sort((a, b) => a.createdAt!.compareTo(b.createdAt!));
      threadModel = threadModel.reversed.toList();
      return ListView.separated(
        itemCount: threadModel.length,
        separatorBuilder: (context, index) => buildDivider(),
        itemBuilder: (context, index) => threadCard(
          context: context,
          threadModel: threadModel[index],
          isOpened: false,
        ),
      );
    }
  }

  Widget categoryTabView(List<SearchCategoryModel> categoryModel) {
    if (categoryModel.isEmpty) {
      return notFound(context);
    }
    return ListView.separated(
      itemCount: categoryModel.length,
      padding: const EdgeInsets.symmetric(horizontal: 16),
      separatorBuilder: (context, index) => buildDivider(),
      itemBuilder: (context, index) {
        return searchCategoryCard(context, categoryModel[index]);
      },
    );
  }

  Widget usersTabView(List<SearchUserModel> userModel) {
    if (userModel.isEmpty) {
      return notFound(context);
    }
    return ListView.separated(
      itemCount: userModel.length,
      padding: const EdgeInsets.symmetric(horizontal: 16),
      separatorBuilder: (context, index) => buildDivider(),
      itemBuilder: (context, index) {
        return userCard(
            context,
            UserModel(
              iD: userModel[index].id,
              profileImage: userModel[index].profileImage,
              username: userModel[index].username,
              followersCount: userModel[index].followersCount,
            ));
      },
    );
  }
}
