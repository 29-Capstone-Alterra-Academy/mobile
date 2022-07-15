import 'package:capstone_project/model/user_model.dart';
import 'package:capstone_project/modelview/search_screen_provider.dart';
import 'package:capstone_project/screens/components/card_widget.dart';
import 'package:capstone_project/themes/nomizo_theme.dart';
import 'package:capstone_project/utils/finite_state.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class PopularUserScreen extends StatefulWidget {
  const PopularUserScreen({Key? key}) : super(key: key);

  @override
  State<PopularUserScreen> createState() => _PopularUserScreenState();
}

class _PopularUserScreenState extends State<PopularUserScreen> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      Provider.of<SearchScreenProvider>(context, listen: false)
          .getPopularUser();
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
        title: const Text('Pengguna Terpopuler'),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.pushNamed(context, '/searchUser');
            },
            icon: const Icon(Icons.search),
          ),
          const SizedBox(width: 10),
        ],
      ),
      body: Consumer<SearchScreenProvider>(
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
            // if (value.popularUser.isEmpty) {
            if (value.searchUser.isEmpty) {
              return const Center(child: Text('User Terpopuler Tidak Ada'));
            } else {
              return ListView.builder(
                // itemCount: value.popularUser.length,
                itemCount: value.searchUser.length,
                padding: const EdgeInsets.fromLTRB(16, 12, 16, 24),
                itemBuilder: (context, index) {
                  // return userCard(context, value.popularUser[index]);
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
