// import package
import 'package:flutter/cupertino.dart';

// import package
import 'package:capstone_project/utils/finite_state.dart';

// import services
import 'package:capstone_project/services/api_services.dart';

// import model
import 'package:capstone_project/model/thread_model/thread_model.dart';

class HomeScreenProvider extends ChangeNotifier {
  final APIServices _apiServices = APIServices();

  List<ThreadModel> recomended = [];
  List<ThreadModel> followed = [];
  ThreadModel? selectedThread;

  FiniteState state = FiniteState.none;
  int currentPage = 1;

  /// Change tab page
  void changePage(int index) async {
    changeState(FiniteState.loading);
    if (index == 0) {
      await getFollowedThread();
    }
    if (index == 1) {
      await getRecomendedThread();
    }
    currentPage = index;
    changeState(FiniteState.none);
  }

  /// Change State
  void changeState(FiniteState s) {
    state = s;
    notifyListeners();
  }

  /// Get Recomended Thread
  Future getRecomendedThread() async {
    recomended = await _apiServices.getThread(categoryId: 1);
    notifyListeners();
  }

  /// Get Thread from Followed Category
  Future getFollowedThread() async {
    followed = await _apiServices.getThread(categoryId: 3);
    notifyListeners();
  }

  // void getSelectedThread(int threadId) async {
  //   changeState(FiniteState.loading);
  //   selectedThread = await _apiServices.getThread
  //   changeState(FiniteState.none);
  // }
}
