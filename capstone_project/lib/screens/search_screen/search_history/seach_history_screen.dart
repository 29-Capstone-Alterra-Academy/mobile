import 'package:capstone_project/screens/components/card_widget.dart';
import 'package:capstone_project/viewmodel/search_viewmodel/search_history_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SearchHistoryScreen extends StatefulWidget {
  const SearchHistoryScreen({Key? key}) : super(key: key);

  @override
  State<SearchHistoryScreen> createState() => _SearchHistoryScreenState();
}

class _SearchHistoryScreenState extends State<SearchHistoryScreen> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      Provider.of<SearchHistoryProvider>(context, listen: false).getHistory();
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
        title: const Text('Riwayat Pencarian'),
        actions: [
          IconButton(
            onPressed: () {
              // Navigator.pushNamed(context, '/historySearch');
            },
            icon: const Icon(Icons.search),
          ),
          const SizedBox(width: 16),
        ],
      ),
      body: Consumer<SearchHistoryProvider>(
        builder: (context, value, _) {
          if (value.history.isEmpty) {
            return Container();
          } else {
            return ListView.builder(
              itemCount: value.history.length,
              shrinkWrap: true,
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              physics: const NeverScrollableScrollPhysics(),
              itemBuilder: (context, index) {
                return searchHistoryCard(context, value.history[index]);
              },
            );
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: const Icon(Icons.settings),
      ),
    );
  }
}
