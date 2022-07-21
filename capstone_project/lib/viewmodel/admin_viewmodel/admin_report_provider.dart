import 'package:capstone_project/model/report_model/report_category_model.dart';
import 'package:capstone_project/model/report_model/report_reply_model.dart';
import 'package:capstone_project/model/report_model/report_thread_model.dart';
import 'package:capstone_project/model/report_model/report_user_model.dart';
import 'package:capstone_project/services/api_services.dart';
import 'package:capstone_project/utils/finite_state.dart';
import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AdminReportProvider extends ChangeNotifier {
  final APIServices _apiServices = APIServices();
  FiniteState state = FiniteState.none;

  List<ReportThreadModel> threads = [];
  List<ReportReplyModel> replies = [];
  List<ReportCategoryModel> categories = [];
  List<ReportUserModel> users = [];

  /// Change State
  void changeState(FiniteState s) {
    state = s;
    notifyListeners();
  }

  // Get reported thread list
  void getReports() async {
    changeState(FiniteState.loading);
    final prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('access_token');
    if (token != null) {
      threads = await _apiServices.getReports(
        token: token,
        scope: 'thread',
        limit: 30,
      );
      replies = await _apiServices.getReports(
        token: token,
        scope: 'reply',
        limit: 30,
      );
      categories = await _apiServices.getReports(
        token: token,
        scope: 'topic',
        limit: 30,
      );
      users = await _apiServices.getReports(
        token: token,
        scope: 'user',
        limit: 30,
      );
    }
    changeState(FiniteState.none);
  }
}
