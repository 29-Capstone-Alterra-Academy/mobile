import 'dart:developer';

// import package
import 'package:capstone_project/model/modrequest_model.dart';
import 'package:capstone_project/model/profile_model.dart';
import 'package:capstone_project/model/report_model/report_category_model.dart';
import 'package:capstone_project/model/report_model/report_reply_model.dart';
import 'package:capstone_project/model/report_model/report_thread_model.dart';
import 'package:capstone_project/model/report_model/report_user_model.dart';
import 'package:capstone_project/model/search_model/search_category_model.dart';
import 'package:capstone_project/model/search_model/search_user_model.dart';
import 'package:dio/dio.dart';

// import model
import 'package:capstone_project/model/user_model.dart';
import 'package:capstone_project/model/reply_model.dart';
import 'package:capstone_project/model/thread_model.dart';
import 'package:capstone_project/model/category_model.dart';
import 'package:capstone_project/model/moderator_model.dart';
import 'package:capstone_project/model/notification_model.dart';

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

  // final String _baseURL = 'https://virtserver.swaggerhub.com/etrnal70/nomizo/1.0.0';
  final String _baseURL = 'https://staking-spade-production.up.railway.app';

  /// LOGIN
  Future<List<String>> postLogin(String email, String password) async {
    try {
      final request = await dio.post(
        '$_baseURL/login',
        data: {
          "email": email,
          "password": password,
        },
      );

      Map auth = request.data;
      var response = auth.values.toList();

      return ['success', ...response];
    } on DioError catch (e) {
      log(e.toString());
      return ['', ''];
    }
  }

  /// LOGOUT
  // Future logout() async {
  //   try {
  //     await dio.post('$_baseURL/logout');
  //     return true;
  //   } catch (e) {
  //     log(e.toString());
  //     return false;
  //   }
  // }

  /// REFRESH TOKEN

  /// REGISTER
  Future<bool> registerUser(String email, String password) async {
    try {
      await dio.post(
        '$_baseURL/register',
        data: {
          "email": email,
          "password": password,
        },
      );

      return true;
    } on DioError catch (e) {
      log(e.message);
      return false;
    }
  }

  /// REQUEST FOR RESET PASSWORD
  /// INPUT RESET CODE
  /// SET NEW PASSWORD

  /// PROFILE
  Future getUserProfile({required String token}) async {
    try {
      var response = await dio.get(
        '$_baseURL/profile',
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
          },
        ),
      );

      var users = ProfileModel.fromJson(response.data);

      return users;
    } on Exception catch (e) {
      log(e.toString());
    }
  }

  /// EDIT PROFILE
  Future editProfile({
    required ProfileModel userProfile,
    required String token,
    String? imgPath,
  }) async {
    FormData formData = FormData.fromMap({
      "username": userProfile.username,
      if (imgPath != null)
        "profile_image": await MultipartFile.fromFile(imgPath),
      "bio": userProfile.bio,
    });
    try {
      await dio.put(
        '$_baseURL/profile',
        data: formData,
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
          },
        ),
      );
      return true;
    } catch (e) {
      log(e.toString());
      return false;
    }
  }

  /// EDIT CURRENT PASSWORD
  /// REQUEST EMAIL VERIFICARION CODE
  /// SUBMIT EMAIL VERIFICATION CODE

  /// CHECK EMAIL AVAILABILITY
  Future checkEmail(String email) async {
    try {
      var request = await dio.get(
        '$_baseURL/user/check',
        queryParameters: {'email': email},
      );
      log(request.data.toString());
      return true;
    } on DioError catch (e) {
      log(e.message);
      log(e.response!.statusCode.toString());
      return false;
    }
  }

  /// CHECK USERNAME AVAILIBILITY
  Future checkUsername({required String username}) async {
    try {
      await dio.get(
        '$_baseURL/user/check',
        queryParameters: {
          'username': username,
        },
      );
      return true;
    } catch (e) {
      log(e.toString());
      return false;
    }
  }

  /// GET USER PROFILE BY ID
  Future getUsersById(int idUser) async {
    try {
      var response = await dio.get('$_baseURL/user/$idUser');

      var users = UserModel.fromJson(response.data);

      return users;
    } on Exception catch (e) {
      log(e.toString());
    }
  }

  /// FOLLOW USER
  Future followUser({required String token, required int idUser}) async {
    try {
      await dio.get(
        '$_baseURL/user/$idUser/follow',
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
          },
        ),
      );
      return true;
    } catch (e) {
      log(e.toString());
      return false;
    }
  }

  /// UNFOLLOW USER
  Future unfollowUser({required String token, required int idUser}) async {
    try {
      await dio.get(
        '$_baseURL/user/$idUser/unfollow',
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
          },
        ),
      );
      return true;
    } catch (e) {
      log(e.toString());
      return false;
    }
  }

  /// GET LIST OF TOPICS
  Future<List<CategoryModel>> getCategory({int? limit, String? sortby}) async {
    try {
      var response = await dio.get(
        '$_baseURL/topic',
        queryParameters: {
          'limit': limit,
          'offset': 0,
          'sort_by': sortby ?? 'activity_count',
        },
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

  /// CREATE NEW TOPIC
  Future createCategory({
    required String token,
    required CategoryModel categoryModel,
  }) async {
    FormData formData = FormData.fromMap({
      'name': categoryModel.name,
      if (categoryModel.profileImage != '')
        'profile_image':
            await MultipartFile.fromFile(categoryModel.profileImage!),
      'description': categoryModel.description,
      'rules': categoryModel.rules
    });
    try {
      await dio.post(
        '$_baseURL/topic',
        data: formData,
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
          },
        ),
      );
      return true;
    } catch (e) {
      log(e.toString());
      return false;
    }
  }

  /// CHECK TOPIC NAME AVAILIBILITY
  Future<bool> checkCategoryName({
    required String token,
    required String name,
  }) async {
    try {
      await dio.get(
        '$_baseURL/topic/check',
        queryParameters: {
          'topicname': name,
        },
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
          },
        ),
      );
      return true;
    } on DioError catch (e) {
      log(e.message.toString());
      return false;
    }
  }

  /// GET TOPIC BY ID
  Future getCategroyById(
      {required String token, required int idCategory}) async {
    try {
      var response = await dio.get(
        '$_baseURL/topic/$idCategory',
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
          },
        ),
      );

      CategoryModel topics = CategoryModel.fromJson(response.data);

      return topics;
    } on Exception catch (e) {
      log(e.toString());
      return CategoryModel();
    }
  }

  /// GET TOPIC MODERATOR
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

  /// REQUEST TO BE MODERATOR
  Future<bool> requestModerator({
    required String token,
    required int idCategory,
  }) async {
    try {
      await dio.post(
        '$_baseURL/topic/$idCategory/modrequest',
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
          },
        ),
      );
      return true;
    } on DioError catch (e) {
      log(e.message.toString());
      return false;
    }
  }

  /// SUBSCRIBE TO TOPIC
  Future<bool> subscribeCategory({
    required String token,
    required int idCategory,
  }) async {
    try {
      await dio.get(
        '$_baseURL/topic/$idCategory/subscribe',
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
          },
        ),
      );
      return true;
    } catch (e) {
      log(e.toString());
      return false;
    }
  }

  /// CRETAE NEW THREAD
  Future<bool> uploadThread(ThreadModel threadModel, String token) async {
    FormData formData = FormData.fromMap({
      "title": threadModel.title,
      "content": threadModel.content,
      if (threadModel.image1 != '')
        "image_1": await MultipartFile.fromFile(threadModel.image1!),
      if (threadModel.image2 != '')
        "image_2": await MultipartFile.fromFile(threadModel.image2!),
      if (threadModel.image3 != '')
        "image_3": await MultipartFile.fromFile(threadModel.image3!),
      if (threadModel.image4 != '')
        "image_4": await MultipartFile.fromFile(threadModel.image4!),
      if (threadModel.image5 != '')
        "image_5": await MultipartFile.fromFile(threadModel.image5!),
    });

    try {
      await dio.post(
        '$_baseURL/topic/${threadModel.topic!.id}/thread',
        data: formData,
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
          },
        ),
      );

      return true;
    } catch (e) {
      log(e.toString());
      return false;
    }
  }

  /// UNSUBSCRIBE TO TOPIC
  Future<bool> unsubscribeCategory({
    required String token,
    required int idCategory,
  }) async {
    try {
      await dio.get(
        '$_baseURL/topic/$idCategory/subscribe',
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
          },
        ),
      );
      return true;
    } catch (e) {
      log(e.toString());
      return false;
    }
  }

  /// GET THREAD
  Future<List<ThreadModel>> getThread(
      {int? userId, int? categoryId, String? sortby}) async {
    try {
      var response = await dio.get(
        '$_baseURL/thread',
        queryParameters: {
          'userId': userId,
          'topicId': categoryId,
          'limit': 100,
          'offset': 0,
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

  /// GET THREAD BY ID
  Future<ThreadModel?> getThreadById(int threadId) async {
    try {
      var response = await dio.get('$_baseURL/thread/$threadId');

      ThreadModel thread = ThreadModel.fromJson(response.data);

      return thread;
    } on Exception catch (e) {
      log(e.toString());
      return null;
    }
  }

  /// DELETE THREAD
  /// UPDATE THREAD

  /// DELETE LIKE THREAD
  Future<bool> deleteLikeThread({
    required String token,
    required int idThread,
  }) async {
    try {
      await dio.delete(
        '$_baseURL/thread/$idThread/like',
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
          },
        ),
      );

      return true;
    } catch (e) {
      log(e.toString());
      return false;
    }
  }

  /// LIKE THREAD THREAD
  Future<bool> likeThread({
    required String token,
    required int idThread,
  }) async {
    try {
      await dio.post(
        '$_baseURL/thread/$idThread/like',
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
          },
        ),
      );

      return true;
    } catch (e) {
      log(e.toString());
      return false;
    }
  }

  /// REPLY TO A THREAD
  Future<bool> replyThread({
    required String token,
    required int idThread,
    required String content,
  }) async {
    try {
      await dio.post(
        '$_baseURL/thread/$idThread/reply',
        data: FormData.fromMap({
          'content': content,
        }),
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
          },
        ),
      );
      return true;
    } catch (e) {
      log(e.toString());
      return false;
    }
  }

  /// DELETE DISLIKE THREAD
  Future<bool> deleteDislikeThread({
    required String token,
    required int idThread,
  }) async {
    try {
      await dio.delete(
        '$_baseURL/thread/$idThread/unlike',
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
          },
        ),
      );

      return true;
    } catch (e) {
      log(e.toString());
      return false;
    }
  }

  /// DISLIKE THREAD
  Future<bool> dislikeThread({
    required String token,
    required int idThread,
  }) async {
    try {
      await dio.post(
        '$_baseURL/thread/$idThread/unlike',
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
          },
        ),
      );

      return true;
    } catch (e) {
      log(e.toString());
      return false;
    }
  }

  /// GET LIST OF PERSONAL NOTIFICATION
  Future notification() async {
    try {
      var response = await dio.get('$_baseURL/notification');

      if (response.statusCode == 200) {
        return [
          NotificationModel(
            id: response.data['context']['author']['id'],
            username: response.data['context']['author']['username'],
            image: response.data['context']['author']['profile_image'],
          )
        ];
      }

      return <NotificationModel>[];
    } catch (e) {
      log(e.toString());
      return <NotificationModel>[];
    }
  }

  /// GET NOTIFICATION CONTEXT
  /// UNREAD ALL NOTIF

  /// GET LIST OF MODERATOR REQUEST
  Future getModrequest(String token) async {
    try {
      var response = await dio.get(
        '$_baseURL/modrequest',
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
          },
        ),
      );

      List<ModrequestModel> result = (response.data as List)
          .map((e) => ModrequestModel.fromJson(e))
          .toList();

      return result;
    } catch (e) {
      log(e.toString());
      return [];
    }
  }

  /// REJECT MODERATOR REQUEST
  /// GET LIST OF REPORTS
  Future getReports({
    required String token,
    required String scope,
    required int limit,
  }) async {
    try {
      var response = await dio.get(
        '$_baseURL/report',
        queryParameters: {
          'scope': scope,
          'limit': limit,
          'offset': 0,
        },
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
          },
        ),
      );

      if (scope == 'thread') {
        List<ReportThreadModel> result = (response.data as List)
            .map((e) => ReportThreadModel.fromJson(e))
            .toList();
        return result;
      } else if (scope == 'reply') {
        List<ReportReplyModel> result = (response.data as List)
            .map((e) => ReportReplyModel.fromJson(e))
            .toList();
        return result;
      } else if (scope == 'topic') {
        List<ReportCategoryModel> result = (response.data as List)
            .map((e) => ReportCategoryModel.fromJson(e))
            .toList();
        return result;
      } else if (scope == 'user') {
        List<ReportUserModel> result = (response.data as List)
            .map((e) => ReportUserModel.fromJson(e))
            .toList();
        return result;
      }

      return [];
    } catch (e) {
      log(e.toString());
      if (scope == 'thread') {
        return <ReportThreadModel>[];
      } else if (scope == 'reply') {
        return <ReportReplyModel>[];
      } else if (scope == 'topic') {
        return <ReportCategoryModel>[];
      } else if (scope == 'user') {
        return <ReportUserModel>[];
      }
      return [];
    }
  }

  /// TAKE ACTION OF A REPORT

  /// UPDATE EXISTING TOPIC
  /// GET BAN REQUEST
  /// MARK REVIEWED BAN REQUEST
  /// REJECT BAN REQUEST
  /// QUIT MODERATOR

  /// GET LIST OF REPORT REASON
  /// CREATE REPORT REASON
  /// DELETE REPORT REASON

  /// REPLY
  Future getReply({
    required String scope,
    required int idThread,
    required int limit,
    int? offset,
  }) async {
    try {
      var response = await dio.get(
        '$_baseURL/reply',
        queryParameters: {
          'scope': scope,
          'threadId': idThread,
          'limit': limit,
          'offset': offset ?? 0,
        },
      );

      List<ReplyModel> reply =
          (response.data as List).map((e) => ReplyModel.fromJson(e)).toList();

      return reply;
    } catch (e) {
      log(e.toString());
      return null;
    }
  }

  /// DELETE REPLY

  /// GET REPLY'S CHILD BY REPLY ID
  Future getReplyChild({required int replyId}) async {
    try {
      var response = await dio.get(
        '$_baseURL/reply/$replyId/childs',
        queryParameters: {
          'limit': 20,
          'offset': 0,
        },
      );

      List<ReplyModel> reply =
          (response.data as List).map((e) => ReplyModel.fromJson(e)).toList();

      return reply;
    } catch (e) {
      log(e.toString());
      return null;
    }
  }

  /// EDIT REPLY
  /// GET REPLYS CHILDS

  /// DELETE LIKE FROM REPLY
  Future<bool> deleteLikeReply({
    required String token,
    required int idReply,
  }) async {
    try {
      await dio.delete(
        '$_baseURL/reply/$idReply/like',
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
          },
        ),
      );

      return true;
    } catch (e) {
      log(e.toString());
      return false;
    }
  }

  /// LIKE REPLY
  Future<bool> likeReply({required String token, required int idReply}) async {
    try {
      await dio.post(
        '$_baseURL/reply/$idReply/like',
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
          },
        ),
      );

      return true;
    } catch (e) {
      log(e.toString());
      return false;
    }
  }

  /// DELETE DISLIKE FROM REPLY
  Future<bool> deleteDislikeReply(
      {required String token, required int idReply}) async {
    try {
      await dio.delete(
        '$_baseURL/reply/$idReply/unlike',
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
          },
        ),
      );

      return true;
    } catch (e) {
      log(e.toString());
      return false;
    }
  }

  /// DISLIKe REPLY
  Future<bool> dislikeReply(
      {required String token, required int idReply}) async {
    try {
      await dio.post(
        '$_baseURL/reply/$idReply/unlike',
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
          },
        ),
      );

      return true;
    } catch (e) {
      log(e.toString());
      return false;
    }
  }

  /// REPLY TO A REPLY
  Future replyChild({
    required String token,
    required int idReplyParent,
    required String content,
  }) async {
    try {
      await dio.post(
        '$_baseURL/reply/$idReplyParent/reply',
        data: FormData.fromMap({
          "content": content,
        }),
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
          },
        ),
      );
      return true;
    } catch (e) {
      log(e.toString());
      return false;
    }
  }

  /// REPORT REPLY
  Future reportReply(String token, ReplyModel replyModel, int reasonId) async {
    try {
      await dio.post(
        '$_baseURL/reply/${replyModel.id}/report',
        queryParameters: {
          "reasonId": reasonId,
        },
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
          },
        ),
      );
      return true;
    } catch (e) {
      log(e.toString());
      return false;
    }
  }

  /// REPORT THREAD
  Future reportThread(
      String token, ThreadModel threadModel, int reasonId) async {
    try {
      await dio.post(
        '$_baseURL/thread/${threadModel.id}/report',
        queryParameters: {
          "reasonId": reasonId,
        },
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
          },
        ),
      );
      return true;
    } catch (e) {
      log(e.toString());
      return false;
    }
  }

  /// REPORT TOPIC
  Future reportCategory(
      String token, CategoryModel categoryModel, int reasonId) async {
    try {
      await dio.post(
        '$_baseURL/topic/${categoryModel.id}/report',
        queryParameters: {
          'reasonId': reasonId,
        },
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
          },
        ),
      );
      return true;
    } catch (e) {
      log(e.toString());
      return false;
    }
  }

  /// REPORT USER
  Future reportUser(String token, UserModel userModel, int reasonId) async {
    try {
      await dio.post(
        '$_baseURL/user/${userModel.iD}/report',
        queryParameters: {
          "reasonId": reasonId,
        },
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
          },
        ),
      );
      return true;
    } catch (e) {
      log(e.toString());
      return false;
    }
  }

  /// SEARCH
  Future getSearchResult({
    required int limit,
    required int offset,
    required String keyword,
    required String scope,
  }) async {
    try {
      var response = await dio.get(
        '$_baseURL/search',
        queryParameters: {
          'limit': limit,
          'offset': offset,
          'keyword': keyword,
          'scope': scope,
        },
      );

      if (scope == 'thread') {
        List<ThreadModel> searchResult = (response.data as List)
            .map((e) => ThreadModel.fromJson(e))
            .toList();
        return searchResult;
      } else if (scope == 'topic') {
        List<SearchCategoryModel> searchResult = (response.data as List)
            .map((e) => SearchCategoryModel.fromJson(e))
            .toList();
        return searchResult;
      } else {
        List<SearchUserModel> searchResult = (response.data as List)
            .map((e) => SearchUserModel.fromJson(e))
            .toList();
        return searchResult;
      }
    } on Exception catch (e) {
      log(e.toString());
      if (scope == 'thread') {
        return <ThreadModel>[];
      } else if (scope == 'topic') {
        return <SearchCategoryModel>[];
      } else {
        return <SearchUserModel>[];
      }
    }
  }

  /// GET POPULAR USER
  // Future getUsers() async {
  //   try {
  //     var response = await dio.get('$_baseURL/profile');
  //     // List<UserModel> topics = (response.data as List)
  //     //     .map((e) => UserModel.fromJson(e))
  //     //     .toList();
  //     var users = UserModel.fromJson(response.data);
  //     return [users];
  //   } on Exception catch (e) {
  //     log(e.toString());
  //     return <UserModel>[];
  //   }
  // }

  /// GET THREAD BY ID
  // Future getThreadById(int idThread) async {
  //   try {
  //     var response = await dio.get('$_baseURL/thread');
  //     List<ThreadModel> category =
  //         (response.data as List).map((e) => ThreadModel.fromJson(e)).toList();
  //     return category.first;
  //   } on Exception catch (e) {
  //     log(e.toString());
  //     return ThreadModel();
  //   }
  // }

}
