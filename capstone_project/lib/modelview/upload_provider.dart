import 'dart:io';

import 'package:capstone_project/model/category_model.dart';
import 'package:capstone_project/model/search_model.dart';
import 'package:capstone_project/model/thread_model.dart';
import 'package:capstone_project/services/api_services.dart';
import 'package:capstone_project/utils/finite_state.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';

class UploadProvider extends ChangeNotifier {
  final APIServices apiServices = APIServices();

  ThreadModel? thread;
  List<CategoryModel>? popularCategory;
  List<CategoryModel>? newestCategory;
  CategoryModel? selectedCategory;
  SearchModel? results;
  List<File> files = [];

  FiniteState state = FiniteState.none;
  bool isSearched = false;

  /// Change State
  void changeState(FiniteState s) {
    state = s;
    notifyListeners();
  }

  /// Pick Images Form Device
  void pickImage() async {
    FilePickerResult? result =
        await FilePicker.platform.pickFiles(allowMultiple: true);

    // if failed to pick image end this method
    if (result == null) {
      return;
    }
    files.clear();
    int i = 0;
    for (var element in result.files) {
      if (i > 4) {
        break;
      } else if (element.path != null) {
        files.add(File(element.path!));
        i++;
      }
    }
    notifyListeners();
  }

  /// Upload Post
  Future<bool> uploadThread(ThreadModel threadModel) async {
    changeState(FiniteState.loading);
    if (await apiServices.uploadThread(threadModel)) {
      resetForm();
      return true;
    }
    changeState(FiniteState.none);
    return false;
  }

  /// Get ALl Category
  void getAllCategory() async {
    changeState(FiniteState.loading);
    popularCategory = await apiServices.getCategroy(sortby: 'activity_count');
    newestCategory = await apiServices.getCategroy(sortby: 'date');
    changeState(FiniteState.none);
  }

  /// Search ALl Category
  void searchCategory(String category) async {
    changeState(FiniteState.loading);
    results = await apiServices.getSearchResult(category: category);
    changeState(FiniteState.none);
  }

  /// Select Category
  void selectCategory(CategoryModel categoryModel) {
    selectedCategory = categoryModel;
    notifyListeners();
  }

  /// Remove Image
  void removeImage(int index) {
    files.removeAt(index);
    notifyListeners();
  }

  /// Reset Upload Form
  void resetForm() {
    files.clear();
    selectedCategory = null;
    notifyListeners();
  }

  /// Reset search result
  void resetSearchResult() {
    isSearched = false;
    results = null;
    notifyListeners();
  }
}
