import 'dart:io';

import 'package:capstone_project/model/category_model/category_model.dart';
import 'package:capstone_project/model/thread_model/thread_model.dart';
import 'package:capstone_project/services/api_services.dart';
import 'package:capstone_project/utils/finite_state.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UploadProvider extends ChangeNotifier {
  final APIServices _apiServices = APIServices();

  ThreadModel? thread;
  List<CategoryModel> popularCategory = [];
  List<CategoryModel> newestCategory = [];
  CategoryModel? selectedCategory;
  List<CategoryModel> results = [];
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
    final prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('access_token');
    if (token != null) {
      if (await _apiServices.uploadThread(threadModel, token)) {
        resetForm();
        return true;
      }
    }
    changeState(FiniteState.none);
    return false;
  }

  /// Get ALl Category
  void getAllCategory() async {
    changeState(FiniteState.loading);
    // get popular category
    await getPopularCategory();
    // get newest category
    await getNewesCategory();
    changeState(FiniteState.none);
  }

  Future getPopularCategory() async {
    popularCategory =
        await _apiServices.getCategory(limit: 20, sortby: 'activity_count');
    popularCategory
        .sort((a, b) => a.activityCount!.compareTo(b.activityCount!));
    popularCategory = popularCategory.reversed.toList();
    notifyListeners();
  }

  Future getNewesCategory() async {
    newestCategory = await _apiServices.getCategory(limit: 20, sortby: 'date');
    newestCategory.sort((a, b) => a.createdAt!.compareTo(b.createdAt!));
    newestCategory = newestCategory.reversed.toList();
    notifyListeners();
  }

  /// Search ALl Category
  void searchCategory(String keyword) async {
    changeState(FiniteState.loading);
    results.clear();
    for (var element in newestCategory) {
      if (element.name!.contains(keyword) ||
          element.name!.contains(keyword.characters.first.toUpperCase())) {
        results.add(element);
      }
    }
    isSearched = true;
    // results = await _apiServices.getSearchResult(
    //     limit: 100, offset: 0, keyword: keyword, scope: 'topic');
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
    results.clear();
    notifyListeners();
  }
}
