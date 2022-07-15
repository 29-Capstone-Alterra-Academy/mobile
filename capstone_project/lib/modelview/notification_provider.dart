import 'package:capstone_project/services/api_services.dart';
import 'package:flutter/cupertino.dart';
import 'package:capstone_project/utils/finite_state.dart';

import '../model/norification_model.dart';

class NotificationProvider with ChangeNotifier {
  List<NotificationModel> _notification = [];
  List<NotificationModel> get notification => _notification;
  FiniteState state = FiniteState.none;

  getAllNotification(APIServices data) async {
    var source = await data.notification();
    _notification = source;
    notifyListeners();
  }
}
