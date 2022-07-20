// import package
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

// import utils, theme & component
import 'package:capstone_project/utils/finite_state.dart';
import 'package:capstone_project/themes/nomizo_theme.dart';
import 'package:capstone_project/screens/components/card_widget.dart';

// import provider
import 'package:capstone_project/viewmodel/search_viewmodel/search_screen_provider.dart';

class PopularCategoryScreen extends StatefulWidget {
  const PopularCategoryScreen({Key? key}) : super(key: key);

  @override
  State<PopularCategoryScreen> createState() => _PopularCategoryScreenState();
}

class _PopularCategoryScreenState extends State<PopularCategoryScreen> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      Provider.of<SearchScreenProvider>(context, listen: false)
          .getPopularCategory();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(
            Icons.keyboard_arrow_left,
          ),
        ),
        title: const Text('Kategori Terpopuler'),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.pushNamed(context, '/searchCategory');
            },
            icon: const Icon(Icons.search),
          ),
          const SizedBox(width: 10),
        ],
      ),
      body: Consumer<SearchScreenProvider>(
        builder: (context, value, _) {
          if (value.categoryState == FiniteState.loading) {
            return Center(
              child: CircularProgressIndicator(
                color: NomizoTheme.nomizoTosca.shade600,
              ),
            );
          }
          if (value.categoryState == FiniteState.failed) {
            return const Center(
              child: Text('Something Wrong!!!'),
            );
          } else {
            if (value.popularCategory.isEmpty) {
              return const Center(child: Text('TOPIC TERPOPULER TIDAK ADA'));
            } else {
              return ListView.builder(
                itemCount: value.popularCategory.length,
                padding: const EdgeInsets.fromLTRB(16, 12, 16, 0),
                itemBuilder: (context, index) {
                  return categoryCard(context, value.popularCategory[index]);
                },
              );
            }
          }
        },
      ),
    );
  }
}
