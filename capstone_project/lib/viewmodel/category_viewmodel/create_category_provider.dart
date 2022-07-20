import 'dart:io';

import 'package:capstone_project/model/category_model/category_model.dart';
import 'package:capstone_project/services/api_services.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CreateCategoryProvider extends ChangeNotifier {
  final APIServices apiServices = APIServices();

  File? img;

  /// Pick Images Form Device
  void pickImage() async {
    FilePickerResult? result =
        await FilePicker.platform.pickFiles(type: FileType.image);

    // if failed to pick image end this method
    if (result == null) {
      return;
    }
    img = File(result.files.first.path!);
    notifyListeners();
  }

  /// Create Category
  Future<bool> checkCategoryName({required String name}) async {
    final prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('access_token');
    if (token != null) {
      if (await apiServices.checkCategoryName(
        token: token,
        name: name,
      )) {
        return true;
      }
    }
    return false;
  }

  /// Create Category
  Future<bool> createCategory(CategoryModel categoryModel) async {
    final prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('access_token');
    if (token != null) {
      if (await apiServices.createCategory(
        token: token,
        categoryModel: categoryModel,
      )) {
        resetForm();
        return true;
      }
    }
    return false;
  }

  /// Reset form
  void resetForm() {
    img = null;
    notifyListeners();
  }
}
