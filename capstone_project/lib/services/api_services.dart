import 'dart:developer';

// import package
import 'package:dio/dio.dart';

// import model
import 'package:capstone_project/model/auth_model.dart';
import 'package:capstone_project/model/user_model.dart';
import 'package:capstone_project/model/thread_model.dart';
import 'package:capstone_project/model/search_model.dart';
import 'package:capstone_project/model/category_model.dart';
import 'package:capstone_project/model/moderator_model.dart';

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

  /// LOGIN
  Future<List<AuthenticationModel>> postLogin() async {
    try {
      final request = await Dio().post('$_baseURL/login');

      List<AuthenticationModel> auth = (request.data as List)
          .map((e) => AuthenticationModel.fromJson(e))
          .toList();

      return auth;
    } on Exception catch (e) {
      log(e.toString());
      return <AuthenticationModel>[];
    }
  }

  /// POST | CREATE CATEGORY
  Future createCategory(CategoryModel categoryModel) async {
    try {
      await dio.post('$_baseURL/topic', data: categoryModel.toJson());
      return true;
    } catch (e) {
      log(e.toString());
      return false;
    }
  }

  /// GET POPULAR | Newesr CATEGORY
  Future getCategroy({String? sortby}) async {
    try {
      var response = await dio.get(
        '$_baseURL/topic',
        queryParameters: {'sort_by': sortby ?? 'activity_count'},
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

  /// GET CATEGORY BY ID
  Future getCategroyById(int idCategory) async {
    try {
      var response = await dio.get('$_baseURL/topic/$idCategory');

      // CategoryModel category = CategoryModel.fromJson(response.data);
      List<CategoryModel> topics = (response.data as List)
          .map((e) => CategoryModel.fromJson(e))
          .toList();

      return topics.first;
    } on Exception catch (e) {
      log(e.toString());
      return CategoryModel();
    }
  }

  /// Get Moderator
  Future getModerator(int idCategory) async {
    try {
      var response = await dio.get('$_baseURL/topic/$idCategory/moderator');

      List<ModeratorModel> moderator = (response.data as List)
          .map((e) => ModeratorModel.fromJson(e))
          .toList();

      return moderator;
    } on Exception catch (e) {
      log(e.toString());
      return <ModeratorModel>[];
    }
  }

  /// Get Contributor

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

  /// GET USER BY ID
  Future getUsersById(int idUser) async {
    try {
      var response = await dio.get('$_baseURL/user/$idUser');

      var users = UserModel.fromJson(response.data);

      return users;
    } on Exception catch (e) {
      log(e.toString());
    }
  }

  /// GET SEARCH RESULT
  Future getSearchResult({String? category}) async {
    try {
      var response = await dio.get(
        '$_baseURL/search',
        queryParameters: {
          'sort_thread': 'best',
          'order': 'asc',
          'topic': category ?? '',
          'limit': '10',
          'offset': '5',
        },
      );

      SearchModel searchResult = SearchModel.fromJson(response.data);

      return searchResult;
    } on Exception catch (e) {
      log(e.toString());
      return SearchModel();
    }
  }

  /// GET THREAD BY CATEGORY NAME
  Future getThread(
      {String? username, String? categoryName, String? sortby}) async {
    try {
      var response = await dio.get(
        '$_baseURL/thread',
        queryParameters: {
          'username': username ?? '',
          'topic': categoryName ?? '',
          'sort_by': sortby ?? 'like',
        },
      );

      List<ThreadModel> category =
          (response.data as List).map((e) => ThreadModel.fromJson(e)).toList();

      return category;
    } on Exception catch (e) {
      log(e.toString());
      return <ThreadModel>[];
    }
  }

  /// REQUEST MODERATOR CATEGORY
  Future requestModerator(CategoryModel categoryModel) async {
    try {
      await dio.post('$_baseURL/topic/${categoryModel.id}/modrequest');
      return true;
    } catch (e) {
      log(e.toString());
      return false;
    }
  }

  /// SUBSCRIBE TO CATEGORY
  Future subscribeCategory(int idCategory) async {
    try {
      await dio.get('$_baseURL/topic/$idCategory/subscribe');
      return true;
    } catch (e) {
      log(e.toString());
      return false;
    }
  }

  /// UNSUBSCRIBE TO CATEGORY
  Future unsubscribeCategory(int idCategory) async {
    try {
      await dio.get('$_baseURL/topic/$idCategory/unsubscribe');
      return true;
    } catch (e) {
      log(e.toString());
      return false;
    }
  }

  /// REPORT CATEGORY
  Future reportCategory(CategoryModel categoryModel, String reason) async {
    try {
      await dio.put(
        '$_baseURL/topic/${categoryModel.id}/report',
        data: {},
      );
      return true;
    } catch (e) {
      log(e.toString());
      return false;
    }
  }

  /// FOLLOW USER
  Future followUser(int idUser) async {
    try {
      await dio.get('$_baseURL/user/$idUser/follow');
      return true;
    } catch (e) {
      log(e.toString());
      return false;
    }
  }

  /// UNFOLLOW USER
  Future unfollowUser(int idUser) async {
    try {
      await dio.get('$_baseURL/topic/$idUser/unfollow');
      return true;
    } catch (e) {
      log(e.toString());
      return false;
    }
  }

  /// REPORT USER
  Future reportUser(
      UserModel currentUserModel, UserModel userModel, String reason) async {
    try {
      await dio.put(
        '$_baseURL/user/${userModel.id}/report',
        data: {
          "created_at": DateTime.now().toString(),
          "id": 3,
          "reason": reason,
          "reporter": {
            "id": "${currentUserModel.id}",
            "profile_image": "${currentUserModel.profileImage}",
            "username": "${currentUserModel.username}"
          },
          "reviewed": false,
          "suspect": {
            "id": "${userModel.id}",
            "profile_image": "${userModel.profileImage}",
            "username": "${userModel.username}"
          }
        },
      );
      return true;
    } catch (e) {
      log(e.toString());
      return false;
    }
  }

  /// REPORT THREAD
  Future reportThread(ThreadModel threadModel, String reason) async {
    try {
      await dio.put(
        '$_baseURL/thread/${threadModel.id}/report',
        data: {},
      );
    } catch (e) {
      log(e.toString());
    }
  }

  /// REPORT REPLY
  Future reportReply(ThreadModel threadModel, String reason) async {
    try {
      await dio.put(
        '$_baseURL/reply/${threadModel.id}/report',
        data: {},
      );
    } catch (e) {
      log(e.toString());
    }
  }

  /// POST | UPLOAD THREAD
  Future uploadThread(ThreadModel threadModel) async {
    try {
      await dio.post(
        '$_baseURL/topic/${threadModel.topic!.id}/thread',
        data: threadModel.toJson(),
      );

      return true;
    } catch (e) {
      log(e.toString());
      return true;
    }
  }

  /// GET USER PROFILE
  Future getUserProfile() async {
    try {
      var response = await dio.get('$_baseURL/profile');

      var users = UserModel.fromJson(response.data);

      return users;
    } on Exception catch (e) {
      log(e.toString());
    }
  }
}
