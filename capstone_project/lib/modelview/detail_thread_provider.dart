import 'dart:io';
// import package
import 'package:capstone_project/model/profile_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:file_picker/file_picker.dart';

// import util
import 'package:capstone_project/utils/finite_state.dart';

// import service
import 'package:capstone_project/services/api_services.dart';

// import model
import 'package:capstone_project/model/thread_model.dart';
import 'package:capstone_project/model/reply_model.dart' as reply;
import 'package:shared_preferences/shared_preferences.dart';

class DetailThreadProvider extends ChangeNotifier {
  final APIServices _apiServices = APIServices();

  ThreadModel? currentThread;
  reply.ReplyModel? selectedReply;

  List<reply.ReplyModel>? repliesThread;
  List<reply.ReplyModel> repliesChild = [];

  FiniteState state = FiniteState.none;
  bool expandReply = false;
  bool isLikeThread = false;
  bool isDislikeThread = false;
  bool isLikeReply = false;
  bool isDislikeReply = false;

  File? image;

  /// Change State
  void changeState(FiniteState s) {
    state = s;
    notifyListeners();
  }

  /// Change selected reply
  void changeSelectedReply({reply.ReplyModel? replyModel}) {
    selectedReply = replyModel;
    notifyListeners();
  }

  void expandReplyParent() {
    expandReply = !expandReply;
    notifyListeners();
  }

  /// Reset detailthreadscreen display
  void reset() {
    expandReply = false;
    image = null;
    currentThread = null;
    isLikeThread = false;
    isDislikeThread = false;
    isLikeReply = false;
    isDislikeReply = false;
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
    image = File(result.files.first.path!);
    notifyListeners();
  }

  /// Get Thread, Reply parent, & currentUser
  void loadDetailThread(ThreadModel threadModel) async {
    changeState(FiniteState.loading);
    currentThread = threadModel;
    repliesThread = await _apiServices.getReply(
      scope: 'thread',
      idThread: threadModel.id!,
      limit: 30,
    );
    changeState(FiniteState.none);
  }

  /// Get Reply Child
  Future getReplyChild(int replyParentId) async {
    repliesChild = await _apiServices.getReplyChild(replyId: replyParentId);
    notifyListeners();
  }

  /// Like | Delete Like Thread
  void likeThread(ThreadModel threadModel) async {
    final prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('access_token');
    if (token != null) {
      if (isLikeThread) {
        if (await _apiServices.deleteLikeThread(
            token: token, idThread: threadModel.id!)) {
          isLikeThread = false;
        }
      } else {
        if (await _apiServices.likeThread(
          token: token,
          idThread: threadModel.id!,
        )) {
          isLikeThread = true;
        }
      }
    }
  }

  /// Dislike | Delete Dislike Thread
  void dislikeThread(ThreadModel threadModel) async {
    final prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('access_token');
    if (token != null) {
      if (isLikeThread) {
        if (await _apiServices.deleteDislikeThread(
            token: token, idThread: threadModel.id!)) {
          isLikeThread = false;
        }
      } else {
        if (await _apiServices.dislikeThread(
          token: token,
          idThread: threadModel.id!,
        )) {
          isLikeThread = true;
        }
      }
    }
  }

  /// Post Comment | Reply
  Future<bool> postReplyThread({
    required int idThread,
    required String content,
  }) async {
    final prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('access_token');
    if (await _apiServices.replyThread(
      token: token!,
      idThread: idThread,
      content: content,
    )) {
      repliesThread = await _apiServices.getReply(
        scope: 'thread',
        idThread: idThread,
        limit: 30,
      );
      notifyListeners();
      return true;
    }
    return false;
  }

  /// Like | Delete Like Thread
  void likeReply(reply.ReplyModel replyModel, int idThread) async {
    final prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('access_token');
    if (token != null) {
      if (isLikeReply) {
        if (await _apiServices.deleteLikeReply(
          token: token,
          idReply: replyModel.id!,
        )) {
          isLikeReply = false;
        }
      } else {
        if (await _apiServices.likeReply(
          token: token,
          idReply: replyModel.id!,
        )) {
          isLikeReply = true;
        }
      }
      loadDetailThread(currentThread!);
    }
  }

  /// Dislike | Delete Dislike Thread
  void dislikeReply(reply.ReplyModel replyModel, int idThread) async {
    final prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('access_token');
    if (token != null) {
      if (isLikeReply) {
        if (await _apiServices.deleteDislikeReply(
          token: token,
          idReply: replyModel.id!,
        )) {
          isLikeReply = false;
        }
      } else {
        if (await _apiServices.dislikeReply(
          token: token,
          idReply: replyModel.id!,
        )) {
          isLikeReply = true;
        }
      }
      loadDetailThread(currentThread!);
    }
  }

  /// Post Reply Child / Reply from reply
  Future postReplyChild({
    required int idReplyParent,
    required String content,
  }) async {
    final prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('access_token');
    if (token != null) {
      if (await _apiServices.replyChild(
        token: token,
        idReplyParent: idReplyParent,
        content: content,
      )) {
        repliesChild = await _apiServices.getReplyChild(
          replyId: idReplyParent,
        );
        notifyListeners();
        return true;
      }
    }
    return false;
  }

  /// Follow User
  Future<bool> followUser(int idUser) async {
    final prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('access_token');
    if (token != null) {
      if (await _apiServices.followUser(token: token, idUser: idUser)) {
        return true;
      }
    }
    return false;
  }

  /// Follow Category
  Future<bool> followCategory(int idCategory) async {
    final prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('access_token');
    if (token != null) {
      if (await _apiServices.subscribeCategory(
        token: token,
        idCategory: idCategory,
      )) {
        return true;
      }
    }
    return false;
  }

  /// Report Thread
  Future<String> reportThread(ThreadModel threadModel, int reasonId) async {
    final prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('access_token');
    if (token != null) {
      if (await _apiServices.reportThread(token, threadModel, reasonId)) {
        return "Laporan Anda sudah dikirim. Terima kasih.";
      }
    }
    return "Laporan Anda gagal dikirim";
  }

  /// Report Reply
  Future<String> reportReply(reply.ReplyModel replyModel, int reasonId) async {
    final prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('access_token');
    if (token != null) {
      if (await _apiServices.reportReply(token, replyModel, reasonId)) {
        return "Laporan Anda sudah dikirim. Terima kasih.";
      }
    }
    return "Laporan Anda gagal dikirim";
  }
}
