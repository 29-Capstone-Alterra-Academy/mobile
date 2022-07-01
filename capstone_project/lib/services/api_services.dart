import 'dart:developer';

// import package
import 'package:capstone_project/model/user_model.dart';
import 'package:dio/dio.dart';

// import model
import 'package:capstone_project/model/category_model.dart';
import 'package:capstone_project/model/search_model.dart';

class APIServices {
  final Dio dio = Dio();

  APIServices() {
    dio.interceptors.add(
      LogInterceptor(
        responseBody: true,
        requestBody: true,
      ),
    );
  }

  final String _baseURL =
      'https://virtserver.swaggerhub.com/etrnal70/nomizo/1.0.0';

  /// GET POPULAR CATEGORY
  Future getCategroy() async {
    try {
      var response = await dio.get(
        '$_baseURL/topic',
        queryParameters: {'sort_by': 'activity_count'},
      );

      List<CategoryModel> topics = (response.data as List)
          .map((e) => CategoryModel.fromJson(e))
          .toList();

      return topics;
    } on Exception catch (e) {
      log(e.toString());
      return <CategoryModel>[];
    }
  }

  /// GET POPULAR USER
  Future getUsers() async {
    try {
      var response = await dio.get('$_baseURL/profile');

      // List<UserModel> topics = (response.data as List)
      //     .map((e) => UserModel.fromJson(e))
      //     .toList();

      var users = UserModel.fromJson(response.data);

      return [users];
    } on Exception catch (e) {
      log(e.toString());
      return <UserModel>[];
    }
  }

  /// GET SEARCH RESULT
  Future getSearchResult() async {
    try {
      var response = await dio.get(
        '$_baseURL/search',
        queryParameters: {
          'sort_thread': 'best',
          'order': 'asc',
          'topic': '',
          'limit': '10',
          'offset': '5',
        },
      );

      SearchModel searchResult = SearchModel.fromJson(response.data);

      return searchResult;
    } on Exception catch (e) {
      log(e.toString());
      return <SearchModel>[];
    }
  }
}
