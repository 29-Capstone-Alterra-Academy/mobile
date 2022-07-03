import 'package:capstone_project/model/user_model.dart';
import 'package:capstone_project/services/api_services.dart';
import 'package:capstone_project/utils/finite_state.dart';
import 'package:flutter/cupertino.dart';

class ProfileProvider extends ChangeNotifier {
  final APIServices _apiServices = APIServices();

  UserModel? currentUser;
  FiniteState state = FiniteState.none;

  // CHANGE MAIN STATE
  void changeState(FiniteState s) {
    state = s;
    notifyListeners();
  }

  /// GET CURRENT USER PROFILE
  void getProfile() async {
    changeState(FiniteState.loading);
    currentUser = await _apiServices.getUserProfile();
    changeState(FiniteState.none);
  }
}
