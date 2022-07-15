import 'package:capstone_project/modelview/admin/admin_moderator_provider.dart';
import 'package:capstone_project/screens/admin/moderator_screen/category_item.dart';
import 'package:capstone_project/screens/components/card_widget.dart';
import 'package:capstone_project/themes/nomizo_theme.dart';
import 'package:capstone_project/utils/finite_state.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ModeratorSearchScreen extends StatefulWidget {
  const ModeratorSearchScreen({Key? key}) : super(key: key);

  @override
  State<ModeratorSearchScreen> createState() => _ModeratorSearchScreenState();
}

class _ModeratorSearchScreenState extends State<ModeratorSearchScreen> {
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
    final provider =
        Provider.of<AdminModeratorProvider>(context, listen: false);
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
        title: Container(
          height: 58,
          padding: const EdgeInsets.symmetric(vertical: 8),
          child: TextField(
            controller: _searchController,
            autofocus: true,
            style: Theme.of(context).textTheme.bodyMedium,
            onChanged: (value) {
              provider.getSearchResult(category: _searchController.text.trim());
            },
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
              suffixIcon: InkWell(
                onTap: () {
                  _searchController.clear();
                  provider.resetSearchResult();
                },
                child:
                    Icon(Icons.close, color: NomizoTheme.nomizoDark.shade900),
              ),
              hintText: 'Cari berdasarkan kategori',
              hintStyle: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: NomizoTheme.nomizoDark.shade500,
                  ),
            ),
          ),
        ),
      ),
      body: Consumer<AdminModeratorProvider>(
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
            if (value.results == null || value.results!.topics == null) {
              if (value.isSearched) {
                return notFound(context);
              }
              return Container();
            } else {
              return ListView.builder(
                itemCount: value.results!.topics!.length,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                padding: const EdgeInsets.only(top: 12),
                itemBuilder: (context, index) {
                  return CategoryItem(
                      categoryModel: value.results!.topics![index]);
                },
              );
            }
          }
        },
      ),
    );
  }
}
