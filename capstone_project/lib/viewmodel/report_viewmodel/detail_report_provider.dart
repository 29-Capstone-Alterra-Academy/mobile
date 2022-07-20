import 'package:capstone_project/model/category_model/category_model.dart';
import 'package:capstone_project/model/reply_model/reply_model.dart';
import 'package:capstone_project/model/thread_model/thread_model.dart';
import 'package:capstone_project/model/user_model/user_model.dart';
// import 'package:capstone_project/services/api_services.dart';
import 'package:capstone_project/utils/finite_state.dart';
import 'package:flutter/cupertino.dart';

class DetailReportProvider extends ChangeNotifier {
  // APIServices _apiServices = APIServices();
  FiniteState state = FiniteState.none;

  ThreadModel? thread;
  ReplyModel? reply;
  CategoryModel? category;
  UserModel? user;

  /// Change State
  void changeState(FiniteState s) {
    state = s;
    notifyListeners();
  }

  // get detail thread
  void getDetailThread() {}

  // get detail thread
  void getDetailReply() {}

  // get detail thread
  void getDetailCategory() {}

  // get detail user
  void getDetailUser() {}
}
