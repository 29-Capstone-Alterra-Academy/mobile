import 'package:capstone_project/modelview/category_provider.dart';
import 'package:capstone_project/screens/components/card_widget.dart';
import 'package:capstone_project/screens/components/thread_component.dart';
import 'package:capstone_project/themes/nomizo_theme.dart';
import 'package:capstone_project/utils/finite_state.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SearchThreadScreen extends StatefulWidget {
  const SearchThreadScreen({Key? key}) : super(key: key);

  @override
  State<SearchThreadScreen> createState() => _SearchThreadScreenState();
}

class _SearchThreadScreenState extends State<SearchThreadScreen> {
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
            provider.getSearchResult(category: provider.currentCategory.name);
          },
          decoration: InputDecoration(
            prefixIcon: const Icon(Icons.search),
            hintText: 'Cari aktivitas di',
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
            if (value.results == null || value.results!.threads == null) {
              if (value.isSearched) {
                return notFound(context);
              }
              return Container();
            } else {
              return ListView.builder(
                itemCount: value.results!.threads!.length,
                itemBuilder: (context, index) {
                  return ThreadComponent(
                    threadModel: value.results!.threads![index],
                    isOpened: false,
                  );
                },
              );
            }
          }
        },
      ),
    );
  }
}
