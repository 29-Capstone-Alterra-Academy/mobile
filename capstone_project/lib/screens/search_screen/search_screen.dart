// import package
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

// import utils, theme & component
import 'package:capstone_project/utils/finite_state.dart';
import 'package:capstone_project/themes/nomizo_theme.dart';
import 'package:capstone_project/screens/components/card_widget.dart';

// import provider
import 'package:capstone_project/modelview/search_screen_provider.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      Provider.of<SearchScreenProvider>(context, listen: false)
          .getPopularCategory();
      Provider.of<SearchScreenProvider>(context, listen: false)
          .getPopularUser();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: TextField(
          readOnly: true,
          onTap: () => Navigator.pushNamed(context, '/search'),
          decoration: const InputDecoration(
            prefixIcon: Icon(Icons.search),
            hintText: 'Cari disini...',
            isDense: true,
            border: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(4))),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Kategori terpopuler minggu ini',
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.w500,
                    ),
              ),
              const SizedBox(height: 8),
              // Popular Category
              Consumer<SearchScreenProvider>(
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
                      return const Center(
                          child: Text('Kategori Terpopuler Tidak Ada'));
                    } else {
                      return Column(
                        children: [
                          ListView.builder(
                            itemCount: value.popularCategory.length,
                            shrinkWrap: true,
                            itemBuilder: (context, index) {
                              return categoryCard(
                                  context, value.popularCategory[index]);
                            },
                          ),
                          const SizedBox(height: 4),
                          seeAllButton(context, '/popularCategory'),
                        ],
                      );
                    }
                  }
                },
              ),
              const SizedBox(height: 16),
              // Weekly Popular User
              Text(
                'Pengguna terpopuler minggu ini',
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.w500,
                    ),
              ),
              const SizedBox(height: 8),
              Consumer<SearchScreenProvider>(
                builder: (context, value, _) {
                  if (value.userState == FiniteState.loading) {
                    return Center(
                      child: CircularProgressIndicator(
                        color: NomizoTheme.nomizoTosca.shade600,
                      ),
                    );
                  }
                  if (value.userState == FiniteState.failed) {
                    return const Center(
                      child: Text('Something Wrong!!!'),
                    );
                  } else {
                    if (value.popularUser.isEmpty) {
                      return const Center(
                          child: Text('Pengguna Terpopuler Tidak Ada'));
                    } else {
                      return Column(
                        children: [
                          ListView.builder(
                            itemCount: value.popularUser.length,
                            shrinkWrap: true,
                            itemBuilder: (context, index) {
                              return userCard(
                                  context, value.popularUser[index]);
                            },
                          ),
                          const SizedBox(height: 4),
                          seeAllButton(context, '/popularUser'),
                        ],
                      );
                    }
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  /// BUTTON LIHAT SEMUANYA
  Widget seeAllButton(BuildContext context, String route) {
    return Center(
      child: InkWell(
        onTap: () {
          Navigator.pushNamed(context, route);
        },
        child: Text(
          'Lihat Semuanya',
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                fontWeight: FontWeight.w500,
              ),
        ),
      ),
    );
  }
}
