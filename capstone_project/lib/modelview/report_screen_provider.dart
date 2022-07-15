import 'package:capstone_project/model/report_category_model.dart';
import 'package:capstone_project/model/report_reply_model.dart';
import 'package:capstone_project/model/report_thread_model.dart';
import 'package:capstone_project/model/report_user_model.dart';
// import 'package:capstone_project/services/api_services.dart';
import 'package:capstone_project/utils/finite_state.dart';
import 'package:flutter/cupertino.dart';

class ReportScreenProvider extends ChangeNotifier {
  // APIServices _apiServices = APIServices();
  FiniteState state = FiniteState.none;

  List<ReportThreadModel> reportThreads = [];
  List<ReportReplyModel> reportReply = [];
  List<ReportCategoryModel> reportCategory = [];
  List<ReportUserModel> reportUsers = [];

  /// Change State
  void changeState(FiniteState s) {
    state = s;
    notifyListeners();
  }

  // get all reports
  void getReports() {}
}
