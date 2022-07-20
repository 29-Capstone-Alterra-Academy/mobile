// import package
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

// import utils & theme
import 'package:capstone_project/utils/finite_state.dart';
import 'package:capstone_project/themes/nomizo_theme.dart';

// import component
import 'package:capstone_project/screens/components/card_widget.dart';

// import provider
import 'package:capstone_project/viewmodel/thread_viewmodel/upload_provider.dart';

class SearchSelectCategoryScreen extends StatefulWidget {
  const SearchSelectCategoryScreen({Key? key}) : super(key: key);

  @override
  State<SearchSelectCategoryScreen> createState() =>
      _SearchSelectCategoryScreenState();
}

class _SearchSelectCategoryScreenState
    extends State<SearchSelectCategoryScreen> {
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
    final provider = Provider.of<UploadProvider>(context, listen: false);
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
            provider.searchCategory(_searchController.text.trim());
          },
          decoration: InputDecoration(
            prefixIcon: const Icon(Icons.search),
            hintText: 'Cari kategori',
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
      body: Consumer<UploadProvider>(
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
            if (value.results.isEmpty) {
              if (value.isSearched) {
                return notFound(context);
              }
              return Container();
            } else {
              return ListView.builder(
                itemCount: value.results.length,
                padding: const EdgeInsets.fromLTRB(16, 12, 16, 0),
                itemBuilder: (context, index) {
                  return selectCategory(
                    context,
                    value.results[index],
                    provider,
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
