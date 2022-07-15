import 'package:capstone_project/model/user_model.dart';
import 'package:capstone_project/modelview/category_provider.dart';
import 'package:capstone_project/screens/components/card_widget.dart';
import 'package:capstone_project/themes/nomizo_theme.dart';
import 'package:capstone_project/utils/finite_state.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SearchUserScreen extends StatefulWidget {
  const SearchUserScreen({Key? key}) : super(key: key);

  @override
  State<SearchUserScreen> createState() => _SearchUserScreenState();
}

class _SearchUserScreenState extends State<SearchUserScreen> {
  late final TextEditingController _searchController;

  @override
  void initState() {
    _searchController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<CategoryProvider>(context, listen: false);
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            provider.resetSearchResult();
            Navigator.pop(context);
          },
          icon: const Icon(
            Icons.keyboard_arrow_left,
          ),
        ),
        title: TextField(
          controller: _searchController,
          autofocus: true,
          onSubmitted: (value) {
            provider.getSearchResult(keyword: _searchController.text);
          },
          decoration: InputDecoration(
            prefixIcon: const Icon(Icons.search),
            hintText: 'Cari pengguna',
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
            if (value.searchUser.isEmpty) {
              if (value.isSearched) {
                return notFound(context);
              }
              return Container();
            } else {
              return ListView.builder(
                itemCount: value.searchUser.length,
                padding: const EdgeInsets.fromLTRB(16, 12, 16, 0),
                itemBuilder: (context, index) {
                  return userCard(
                      context,
                      UserModel(
                        iD: value.searchUser[index].id,
                        profileImage: value.searchUser[index].profileImage,
                        username: value.searchUser[index].username,
                        followersCount: value.searchUser[index].followersCount,
                      ));
                },
              );
            }
          }
        },
      ),
    );
  }
}
