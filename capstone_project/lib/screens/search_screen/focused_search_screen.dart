// import package
import 'package:flutter/material.dart';

// import theme
import 'package:capstone_project/themes/nomizo_theme.dart';

// import screen
import 'package:capstone_project/screens/search_screen/search_result_screen.dart';

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
          onChanged: (value) {},
          onSubmitted: (value) {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (_) => SearchResultScreen(value),
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
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'Kategori terpopuler minggu ini',
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.w500,
                    ),
              ),
              const SizedBox(height: 8),
              searchHistoryCard(),
              searchHistoryCard(),
              searchHistoryCard(),
              searchHistoryCard(),
              searchHistoryCard(),
              const SizedBox(height: 4),
              Center(
                child: InkWell(
                  onTap: () {
                    // Navigator.pushNamed(context, '/searchHisotry');
                  },
                  child: Text(
                    'Lihat Semuanya',
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: NomizoTheme.nomizoDark.shade500,
                          fontWeight: FontWeight.w500,
                        ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget searchHistoryCard() {
    return SizedBox(
      height: 28,
      child: Row(
        children: [
          const Icon(Icons.schedule),
          const SizedBox(width: 8),
          const Expanded(
            child: Text('Riwayat Pencarian'),
          ),
          const SizedBox(width: 8),
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.close),
          ),
        ],
      ),
    );
  }
}
