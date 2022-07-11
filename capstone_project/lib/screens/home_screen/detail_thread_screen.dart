import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:capstone_project/utils/finite_state.dart';
import 'package:capstone_project/themes/nomizo_theme.dart';

import 'package:capstone_project/screens/components/reply_component.dart';
import 'package:capstone_project/screens/components/thread_component.dart';
import 'package:capstone_project/screens/components/card_widget.dart';

import 'package:capstone_project/model/thread_model.dart';

import 'package:capstone_project/modelview/profile_provider.dart';
import 'package:capstone_project/modelview/detail_thread_provider.dart';

class DetailThreadScreen extends StatefulWidget {
  final int? idThread;
  const DetailThreadScreen({Key? key, this.idThread}) : super(key: key);

  @override
  State<DetailThreadScreen> createState() => _DetailThreadScreenState();
}

class _DetailThreadScreenState extends State<DetailThreadScreen> {
  late final GlobalKey<FormState> _formKey;
  late final TextEditingController _commentController;

  @override
  void initState() {
    _formKey = GlobalKey<FormState>();
    _commentController = TextEditingController();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      Provider.of<DetailThreadProvider>(context, listen: false)
          .loadDetailThread(widget.idThread!);
    });
    super.initState();
  }

  @override
  void dispose() {
    _commentController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<DetailThreadProvider>(context, listen: false);
    return WillPopScope(
      onWillPop: () async {
        provider.reset();
        return true;
      },
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          leading: IconButton(
            onPressed: () {
              provider.reset();
              Navigator.pop(context);
            },
            icon: const Icon(Icons.keyboard_arrow_left),
          ),
          title: const Text('Postingan'),
        ),
        body: Consumer<DetailThreadProvider>(
          builder: (context, value, _) {
            if (value.state == FiniteState.loading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            if (value.state == FiniteState.failed) {
              return const Center(
                child: Text('Something Wrong!!!'),
              );
            } else {
              if (value.currentThread == null) {
                return const Center(
                  child: Text('Thread Tidak Ada'),
                );
              } else {
                return Stack(
                  children: [
                    Container(
                      height: MediaQuery.of(context).size.height,
                      margin: const EdgeInsets.only(bottom: 70),
                      child: ListView(
                        shrinkWrap: true,
                        children: [
                          // post
                          ThreadComponent(
                            threadModel: value.currentThread!,
                            isOpened: true,
                          ),
                          buildDivider(),
                          // comment & reply section
                          if (value.repliesThread != null)
                            ListView.separated(
                              itemCount: value.repliesThread!.length,
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              separatorBuilder: (context, index) =>
                                  buildDivider(),
                              itemBuilder: (context, index) => ReplyComponent(
                                  replyModel: value.repliesThread![index]),
                            ),
                        ],
                      ),
                    ),
                    // Comment Field
                    Positioned(
                      bottom: 0,
                      child: commentField(value.currentThread!),
                    ),
                  ],
                );
              }
            }
          },
        ),
      ),
    );
  }

  // Comment Field
  Widget commentField(ThreadModel thread) {
    final provider = Provider.of<DetailThreadProvider>(context, listen: false);
    final profile = Provider.of<ProfileProvider>(context, listen: false);
    return Consumer<DetailThreadProvider>(builder: (context, value, _) {
      return Container(
        width: MediaQuery.of(context).size.width,
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          border: Border(
            top: BorderSide(
              width: 1,
              color: NomizoTheme.nomizoDark.shade100,
            ),
          ),
          color: NomizoTheme.nomizoDark.shade50,
        ),
        child: Form(
          key: _formKey,
          child: Row(
            children: [
              circlePic(42, profile.currentUser!.profileImage ?? ''),
              const SizedBox(width: 4),
              Expanded(
                child: Stack(
                  children: [
                    TextFormField(
                      controller: _commentController,
                      minLines: 1,
                      maxLines: 5,
                      style: Theme.of(context).textTheme.bodyMedium,
                      decoration: InputDecoration(
                        isDense: true,
                        contentPadding: const EdgeInsets.fromLTRB(6, 12, 12, 4),
                        // attach file
                        prefix: InkWell(
                          onTap: () => provider.pickImage(),
                          child: Icon(
                            Icons.attach_file,
                            color: NomizoTheme.nomizoDark.shade900,
                            size: 16,
                          ),
                        ),
                        prefixIconConstraints: const BoxConstraints(
                          maxHeight: 0,
                          maxWidth: 0,
                        ),
                        // clear comment
                        suffix: InkWell(
                          onTap: () => _commentController.clear(),
                          child: Icon(
                            Icons.close,
                            color: NomizoTheme.nomizoDark.shade900,
                            size: 16,
                          ),
                        ),
                        suffixIconConstraints: const BoxConstraints(
                          maxHeight: 0,
                          maxWidth: 0,
                        ),
                        hintText: value.selectedReply == null
                            ? 'Tambahkan Komentar'
                            : '@ ${value.selectedReply!.author!.username} ',
                        hintStyle:
                            Theme.of(context).textTheme.bodyMedium?.copyWith(
                                  color: NomizoTheme.nomizoDark.shade500,
                                ),
                        border: const OutlineInputBorder(),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Komentar Kosong';
                        }
                        return null;
                      },
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 4),
              IconButton(
                onPressed: () async {
                  if (_formKey.currentState!.validate()) {
                    log('Komentar dikirim');
                    buildLoading(context);
                    // if reply to reply
                    if (value.selectedReply != null) {
                      await provider
                          .postReplyChild(
                            author: profile.currentUser!,
                            replyParent: value.selectedReply!,
                            content: _commentController.text,
                          )
                          .then((value) => Navigator.pop(context));
                    } else {
                      // if reply to thread
                      await provider
                          .postReplyThread(
                            author: profile.currentUser!,
                            thread: value.currentThread!,
                            content: _commentController.text,
                          )
                          .then((value) => Navigator.pop(context));
                    }
                    _commentController.clear();
                  }
                },
                icon: Icon(Icons.send, color: NomizoTheme.nomizoTosca.shade600),
              ),
            ],
          ),
        ),
      );
    });
  }
}
