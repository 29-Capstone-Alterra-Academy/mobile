// import package
import 'dart:math';

import 'package:flutter/cupertino.dart';

// import package
import 'package:capstone_project/utils/finite_state.dart';

// import services
import 'package:capstone_project/services/api_services.dart';

// import model
import 'package:capstone_project/model/thread_model.dart';

class HomeScreenProvider extends ChangeNotifier {
  final APIServices apiServices = APIServices();

  List<ThreadModel> threads = [];

  FiniteState state = FiniteState.none;
  int currentPage = 1;

  /// Change tab page
  void changePage(int index) {
    currentPage = index;
    notifyListeners();
  }

  /// Change State
  void changeState(FiniteState s) {
    state = s;
    notifyListeners();
  }

  /// Get Thread (Recomended | Followed)
  void getThread() async {
    changeState(FiniteState.loading);
    // get random topic
    var topics = await apiServices.getCategory(limit: 20);
    List<int> allCategoryId = [];
    for (var element in topics) {
      allCategoryId.add(element.id!);
    }
    int randomIndex = Random().nextInt(allCategoryId.length - 1);

    // get threads from random topic id
    threads = await apiServices.getThread(
      categoryId: allCategoryId[randomIndex],
      sortby: 'like',
    );
    changeState(FiniteState.none);
  }
}
