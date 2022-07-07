import 'dart:io';
// import package
import 'package:flutter/cupertino.dart';
import 'package:file_picker/file_picker.dart';

// import util
import 'package:capstone_project/utils/finite_state.dart';

// import service
import 'package:capstone_project/services/api_services.dart';

// import model
import 'package:capstone_project/model/user_model.dart';
import 'package:capstone_project/model/thread_model.dart';
import 'package:capstone_project/model/reply_model.dart' as reply;

class DetailThreadProvider extends ChangeNotifier {
  final APIServices _apiServices = APIServices();

  ThreadModel? currentThread;
  reply.ReplyModel? selectedReply;

  List<reply.ReplyModel>? repliesThread;
  List<reply.ReplyModel>? repliesChild;

  FiniteState state = FiniteState.none;
  bool expandReply = false;

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
  void loadDetailThread(int idThread) async {
    changeState(FiniteState.loading);
    currentThread = await _apiServices.getThreadById(idThread);
    repliesThread = await _apiServices.getReply(replyId: 9, relation: 'parent');
    changeState(FiniteState.none);
  }

  /// Get Reply Child
  void getReplyChild() async {
    changeState(FiniteState.loading);
    repliesThread = await _apiServices.getReply(replyId: 9, relation: 'child');
    // repliesChild = repliesThread;
    changeState(FiniteState.none);
  }

  /// Like | Delete Like Thread
  void likeThread(ThreadModel threadModel) async {
    await _apiServices.likeThread(threadModel.id ?? 1);
    // await _apiServices.deleteLikeThread(threadModel.id ?? 1);
  }

  /// Dislike | Delete Dislike Thread
  void dislikeThread(ThreadModel threadModel) async {
    await _apiServices.dislikeThread(threadModel.id ?? 1);
    // await _apiServices.deleteunLikeThread(threadModel.id ?? 1);
  }

  /// Post Comment | Reply
  Future postReplyThread({
    required UserModel author,
    required ThreadModel thread,
    required String content,
  }) async {
    await _apiServices.replyThread(
      reply.ReplyModel(
        author: reply.Author(
          id: author.id,
          profileImage: author.profileImage,
          username: author.username,
        ),
        childCount: 0,
        childExist: true,
        content: content,
        createdAt: DateTime.now().toIso8601String(),
        dislike: 0,
        id: 9,
        like: 0,
        parentExist: true,
        thread: reply.Thread.fromJson(thread.toJson()),
        updatedAt: DateTime.now().toIso8601String(),
      ),
    );
  }

  /// Like | Delete Like Thread
  void likeReply(reply.ReplyModel replyModel) async {
    await _apiServices.likeReply(replyModel.id ?? 1);
    // await _apiServices.deleteLikeThread(threadModel.id ?? 1);
  }

  /// Dislike | Delete Dislike Thread
  void dislikeReply(reply.ReplyModel replyModel) async {
    await _apiServices.dislikeThread(replyModel.id ?? 1);
    // await _apiServices.deleteunLikeThread(threadModel.id ?? 1);
  }

  /// Post Reply Child / Reply from reply
  Future postReplyChild({
    required UserModel author,
    required reply.ReplyModel replyParent,
    required String content,
  }) async {
    await _apiServices.replyChild(
      author: author,
      replyParent: replyParent,
      content: content,
    );
  }

  /// Follow User
  Future<bool> followUser(int idUser) async {
    if (await _apiServices.followUser(idUser)) {
      return true;
    }
    return false;
  }

  /// Follow Category
  Future<bool> followCategory(int idCategory) async {
    if (await _apiServices.subscribeCategory(idCategory)) {
      return true;
    }
    return false;
  }

  /// Report Thread
  Future<String> reportThread(ThreadModel threadModel, String reason) async {
    if (await _apiServices.reportThread(threadModel, reason)) {
      return "Laporan Anda sudah dikirim. Terima kasih.";
    }
    return "Laporan Anda gagal dikirim";
  }

  /// Report Reply
  Future<String> reportReply(
    reply.ReplyModel replyModel,
    String reason,
    UserModel reporter,
  ) async {
    if (await _apiServices.reportReply(replyModel, reason, reporter)) {
      return "Laporan Anda sudah dikirim. Terima kasih.";
    }
    return "Laporan Anda gagal dikirim";
  }
}
