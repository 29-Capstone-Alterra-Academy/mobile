import 'dart:io';
// import package
// import 'package:capstone_project/model/profile_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:file_picker/file_picker.dart';

// import util
import 'package:capstone_project/utils/finite_state.dart';

// import service
import 'package:capstone_project/services/api_services.dart';

// import model
import 'package:capstone_project/model/thread_model/thread_model.dart';
import 'package:capstone_project/model/reply_model/reply_model.dart' as reply;
import 'package:shared_preferences/shared_preferences.dart';

class DetailThreadProvider extends ChangeNotifier {
  final APIServices _apiServices = APIServices();

  ThreadModel? currentThread;
  reply.ReplyModel? selectedReply;

  List<reply.ReplyModel> repliesThread = [];
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
  void loadDetailThread(int threadId) async {
    changeState(FiniteState.loading);
    await getThread(threadId);
    await getReply(threadId);
    changeState(FiniteState.none);
  }

  Future getThread(int threadId) async {
    currentThread = await _apiServices.getThreadById(threadId);
    notifyListeners();
  }

  /// Get Reply Thread
  Future getReply(int threadId) async {
    repliesThread = await _apiServices.getReply(
      scope: 'thread',
      idThread: threadId,
      limit: 30,
    );
    repliesThread.sort((a, b) => a.createdAt!.compareTo(b.createdAt!));
    notifyListeners();
  }

  /// Get Reply Child
  Future getReplyChild(int replyParentId) async {
    repliesChild = await _apiServices.getReplyChild(replyId: replyParentId);
    notifyListeners();
  }

  /// Like | Delete Like Thread
  void likeThread(int threadId) async {
    final prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('access_token');
    if (token != null) {
      if (isLikeThread) {
        if (await _apiServices.deleteLikeThread(
          token: token,
          idThread: threadId,
        )) {
          isLikeThread = false;
        }
      } else {
        if (await _apiServices.likeThread(
          token: token,
          idThread: threadId,
        )) {
          isLikeThread = true;
        }
      }
    }
    loadDetailThread(threadId);
  }

  /// Dislike | Delete Dislike Thread
  void dislikeThread(int threadId) async {
    final prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('access_token');
    if (token != null) {
      if (isLikeThread) {
        if (await _apiServices.deleteDislikeThread(
          token: token,
          idThread: threadId,
        )) {
          isLikeThread = false;
        }
      } else {
        if (await _apiServices.dislikeThread(
          token: token,
          idThread: threadId,
        )) {
          isLikeThread = true;
        }
      }
    }
    loadDetailThread(threadId);
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
      getReply(idThread);
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
      loadDetailThread(idThread);
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
      loadDetailThread(idThread);
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
