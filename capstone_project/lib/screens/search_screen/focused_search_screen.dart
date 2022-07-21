// import package
import 'package:capstone_project/screens/components/card_widget.dart';
import 'package:capstone_project/viewmodel/search_viewmodel/search_history_provider.dart';
import 'package:flutter/material.dart';

// import theme
import 'package:capstone_project/themes/nomizo_theme.dart';

// import screen
import 'package:capstone_project/screens/search_screen/search_result_screen.dart';
import 'package:provider/provider.dart';

class FocusedSearchScreen extends StatefulWidget {
  final String? text;
  const FocusedSearchScreen(this.text, {Key? key}) : super(key: key);

  @override
  State<FocusedSearchScreen> createState() => _FocusedSearchScreenState();
}

class _FocusedSearchScreenState extends State<FocusedSearchScreen> {
  late final TextEditingController _searchController;

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      Provider.of<SearchHistoryProvider>(context, listen: false).getHistory();
    });
    _searchController = TextEditingController(text: widget.text);
    super.initState();
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<SearchHistoryProvider>(context, listen: false);
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
        title: TextField(
          controller: _searchController,
          autofocus: true,
          onChanged: (value) {
            if (value.isEmpty) {
              provider.resetSearch();
            } else {
              provider.searchHistory(value);
            }
          },
          onSubmitted: (value) {
            if (value.isNotEmpty) {
              provider.resetSearch();
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (_) => SearchResultScreen(value),
                ),
              );
            }
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
      ),
      body: Consumer<SearchHistoryProvider>(
        builder: (context, value, _) {
          if (value.history.isEmpty) {
            return Container();
          } else {
            if (value.isSearched) {
              if (value.result.isEmpty) {
                return Container();
              } else {
                return Padding(
                  padding: const EdgeInsets.symmetric(
                    vertical: 12,
                    horizontal: 16,
                  ),
                  child: ListView.builder(
                    itemCount:
                        value.result.length < 5 ? value.result.length : 5,
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemBuilder: (context, index) {
                      return searchHistoryCard(context, value.result[index]);
                    },
                  ),
                );
              }
            } else {
              return Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      'Pencarian Terakhir',
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                            fontWeight: FontWeight.w500,
                          ),
                    ),
                    const SizedBox(height: 8),
                    ListView.builder(
                      itemCount:
                          value.history.length < 5 ? value.history.length : 5,
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemBuilder: (context, index) {
                        return searchHistoryCard(context, value.history[index]);
                      },
                    ),
                    const SizedBox(height: 4),
                    Center(
                      child: InkWell(
                        onTap: () {
                          Navigator.pushNamed(context, '/searchHisotry');
                        },
                        child: Text(
                          'Lihat Semuanya',
                          style:
                              Theme.of(context).textTheme.bodyMedium?.copyWith(
                                    color: NomizoTheme.nomizoDark.shade500,
                                    fontWeight: FontWeight.w500,
                                  ),
                        ),
                      ),
                    ),
                  ],
                ),
              );
            }
          }
        },
      ),
    );
  }
}
