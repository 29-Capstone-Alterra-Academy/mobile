// import package
import 'package:flutter/cupertino.dart';

// import package
import 'package:capstone_project/utils/finite_state.dart';

// import services
// import 'package:capstone_project/services/api_services.dart';

// import model
// import 'package:capstone_project/model/thread_model.dart';

class AdminHomeProvider extends ChangeNotifier {
  // final APIServices apiServices = APIServices();

  // List<ThreadModel> threads = [];
  List<String> blocked = [];

  FiniteState state = FiniteState.none;
  int currentPage = 0;

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
  // void getThread(String sortby) async {
  //   changeState(FiniteState.loading);
  //   threads = await apiServices.getThread(sortby: sortby);
  //   changeState(FiniteState.none);
  // }
}
