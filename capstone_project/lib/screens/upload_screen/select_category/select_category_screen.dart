// import package
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

// import utils & theme
import 'package:capstone_project/utils/finite_state.dart';
import 'package:capstone_project/themes/nomizo_theme.dart';

// import component
import 'package:capstone_project/screens/components/card_widget.dart';
import 'package:capstone_project/screens/components/button_widget.dart';

// import provider
import 'package:capstone_project/viewmodel/thread_viewmodel/upload_provider.dart';

class SelectCategoryScreen extends StatefulWidget {
  const SelectCategoryScreen({Key? key}) : super(key: key);

  @override
  State<SelectCategoryScreen> createState() => _SelectCategoryScreenState();
}

class _SelectCategoryScreenState extends State<SelectCategoryScreen> {
  late final TextEditingController _searchController;

  @override
  void initState() {
    _searchController = TextEditingController();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      Provider.of<UploadProvider>(context, listen: false).getAllCategory();
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
    final provider = Provider.of<UploadProvider>(context, listen: false);
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(Icons.close),
          ),
          title: TextField(
            controller: _searchController,
            readOnly: true,
            onTap: () => Navigator.pushNamed(context, '/searchSelectCategory'),
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
                borderRadius: BorderRadius.all(Radius.circular(4)),
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
            ],
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
              if (value.popularCategory.isEmpty ||
                  value.newestCategory.isEmpty) {
                return const Center(
                  child: Text('Kategori tidak ada'),
                );
              }
              return TabBarView(
                children: [
                  RefreshIndicator(
                    onRefresh: () async => provider.getPopularCategory(),
                    child: ListView.builder(
                      itemCount: value.popularCategory.length,
                      padding: const EdgeInsets.fromLTRB(16, 12, 16, 0),
                      itemBuilder: (context, index) {
                        return selectCategory(
                          context,
                          value.popularCategory[index],
                          provider,
                        );
                      },
                    ),
                  ),
                  RefreshIndicator(
                    onRefresh: () async => provider.getNewesCategory(),
                    child: ListView.builder(
                      itemCount: value.newestCategory.length,
                      padding: const EdgeInsets.fromLTRB(16, 12, 16, 0),
                      itemBuilder: (context, index) {
                        return selectCategory(
                          context,
                          value.newestCategory[index],
                          provider,
                        );
                      },
                    ),
                  ),
                ],
              );
            }
          },
        ),
        bottomNavigationBar: Container(
          padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
          child: elevatedBtnLong42(
            context,
            () {
              Navigator.pushNamed(context, '/createCategory');
            },
            'Tambah Kategori',
          ),
        ),
      ),
    );
  }
}
