import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:file_picker/file_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:capstone_project/services/api_services.dart';

import 'package:capstone_project/model/profile_model.dart';

class EditProfileProvider extends ChangeNotifier {
  final APIServices apiServices = APIServices();

  File? img;
  String profilePic = '';

  // Set image user
  void setImage() {
    notifyListeners();
  }

  /// Pick Images Form Device
  void pickImage() async {
    FilePickerResult? result =
        await FilePicker.platform.pickFiles(type: FileType.image);

    // if failed to pick image end this method
    if (result == null) {
      return;
    }
    img = File(result.files.first.path!);
    profilePic = img!.path;
    notifyListeners();
  }

  /// Edit Profile
  Future<bool> editProfile(ProfileModel profileModel) async {
    final prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('access_token');
    String? imgPath = img != null ? img!.path : null;
    if (token != null) {
      if (await apiServices.editProfile(
        userProfile: profileModel,
        token: token,
        imgPath: imgPath,
      )) {
        resetForm();
        return true;
      }
      return false;
    }
    return false;
  }

  /// Check Username Availability
  Future<bool> checkUsername(String username) async {
    if (await apiServices.checkUsername(username: username)) {
      return true;
    }
    return false;
  }

  /// Reset form
  void resetForm() {
    img = null;
    notifyListeners();
  }
}
