import 'package:capstone_project/services/api_services.dart';
import 'package:flutter/cupertino.dart';
import 'package:capstone_project/utils/finite_state.dart';

import '../../model/notification_model/notification_model.dart';

class NotificationProvider with ChangeNotifier {
  final APIServices _apiServices = APIServices();
  List<NotificationModel> _notification = [];
  List<NotificationModel> get notification => _notification;
  FiniteState state = FiniteState.none;

  getAllNotification() async {
    var source = await _apiServices.notification();
    _notification = source;
    notifyListeners();
  }
}
