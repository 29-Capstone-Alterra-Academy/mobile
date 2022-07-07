import 'dart:io';

import 'package:capstone_project/model/user_model.dart';
import 'package:capstone_project/services/api_services.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';

class EditProfileProvider extends ChangeNotifier {
  final APIServices apiServices = APIServices();

  File? img;
  String profilePic = '';

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
  Future<bool> editProfile(UserModel userModel) async {
    if (await apiServices.editProfile(userModel)) {
      resetForm();
      return true;
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
