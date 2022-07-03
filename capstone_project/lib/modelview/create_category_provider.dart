import 'dart:io';

import 'package:capstone_project/model/category_model.dart';
import 'package:capstone_project/services/api_services.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';

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
  Future createCategory(CategoryModel categoryModel) async {
    if (await apiServices.createCategory(categoryModel)) {
      resetForm();
      return 'Kategori berhasil dibuat';
    }
    return 'Kategori gagal dibuat';
  }

  /// Reset form
  void resetForm() {
    img = null;
    notifyListeners();
  }
}
