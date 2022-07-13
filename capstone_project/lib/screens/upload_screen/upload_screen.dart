import 'dart:io';

// import package
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:carousel_slider/carousel_slider.dart';

// import theme
import 'package:capstone_project/themes/nomizo_theme.dart';

// import component
import 'package:capstone_project/screens/components/card_widget.dart';
import 'package:capstone_project/screens/components/button_widget.dart';

// import model
import 'package:capstone_project/model/thread_model.dart';
import 'package:capstone_project/model/profile_model.dart';
import 'package:capstone_project/model/category_model.dart';

// import provider
import 'package:capstone_project/modelview/upload_provider.dart';
import 'package:capstone_project/modelview/profile_provider.dart';

class UploadScreen extends StatefulWidget {
  const UploadScreen({Key? key}) : super(key: key);

  @override
  State<UploadScreen> createState() => _UploadScreenState();
}

class _UploadScreenState extends State<UploadScreen> {
  late final GlobalKey<FormState> _formKey;
  late final TextEditingController _titleController;
  late final TextEditingController _contentController;

  ProfileModel? profileModel;
  List<String>? images;

  @override
  void initState() {
    _formKey = GlobalKey<FormState>();
    _titleController = TextEditingController();
    _contentController = TextEditingController();

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      profileModel =
          Provider.of<ProfileProvider>(context, listen: false).currentUser;
    });
    super.initState();
  }

  @override
  void dispose() {
    _titleController.dispose();
    _contentController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<UploadProvider>(context, listen: false);
    return WillPopScope(
      onWillPop: () async {
        provider.resetForm();
        return true;
      },
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          leading: IconButton(
            onPressed: () {
              provider.resetForm();
              Navigator.pop(context);
            },
            icon: Icon(
              Icons.keyboard_arrow_left,
              color: NomizoTheme.nomizoDark.shade900,
              size: 24,
            ),
          ),
          actions: [
            Consumer<UploadProvider>(builder: (context, value, _) {
              return Padding(
                padding: const EdgeInsets.all(15),
                child: elevatedBtn28(
                  context,
                  () async {
                    if (_formKey.currentState!.validate()) {
                      if (value.selectedCategory != null) {
                        buildLoading(context);

                        String msg = '';
                        await postThread(
                                provider, value.selectedCategory!, value.files)
                            .then((value) {
                          msg = value;
                          Navigator.pop(context);
                          Navigator.pop(context);
                        });

                        buildToast(msg);
                      } else {
                        buildToast('Silahkan pilih kategori');
                      }
                    }
                  },
                  'Post',
                ),
              );
            }),
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Form(
            key: _formKey,
            child: ListView(
              children: [
                // title textfield section
                TextFormField(
                  controller: _titleController,
                  decoration: const InputDecoration(
                    hintText: 'Apa judul dari diskusi kamu?',
                    border: InputBorder.none,
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Judul Tidak Boleh Kosong';
                    }
                    return null;
                  },
                ),
                // content textfield section
                TextFormField(
                  controller: _contentController,
                  minLines: 1,
                  maxLines: 10,
                  keyboardType: TextInputType.multiline,
                  decoration: const InputDecoration(
                    hintText: 'Apa yang ingin kamu diskusikan?',
                    border: InputBorder.none,
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Deskripsi Tidak Boleh Kosong';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 12),
                // image section
                Consumer<UploadProvider>(
                  builder: (context, value, child) {
                    if (value.files.isEmpty) {
                      return Container(
                        width: MediaQuery.of(context).size.width,
                        height: 175,
                        color: NomizoTheme.nomizoDark.shade50,
                      );
                    } else {
                      return CarouselSlider.builder(
                        itemCount: value.files.length,
                        itemBuilder: (context, itemIndex, pageViewIndex) {
                          return Stack(
                            children: [
                              Container(
                                width: MediaQuery.of(context).size.width,
                                height: 175,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(4),
                                ),
                                clipBehavior: Clip.hardEdge,
                                child: Image.file(
                                  value.files[itemIndex],
                                  fit: BoxFit.cover,
                                ),
                              ),
                              Positioned(
                                top: 4,
                                right: 4,
                                child: InkWell(
                                  onTap: () {
                                    provider.removeImage(itemIndex);
                                  },
                                  child: Container(
                                    width: 32,
                                    height: 32,
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: NomizoTheme.nomizoDark.shade800,
                                    ),
                                    child: Icon(Icons.close,
                                        color: NomizoTheme.nomizoDark.shade50),
                                  ),
                                ),
                              ),
                            ],
                          );
                        },
                        options: CarouselOptions(
                          enableInfiniteScroll: false,
                          viewportFraction: 1,
                        ),
                      );
                    }
                  },
                ),
              ],
            ),
          ),
        ),
        bottomNavigationBar: pickSection(provider),
      ),
    );
  }

  /// Bottom Section to Pick Images & Select Category
  Widget pickSection(UploadProvider provider) {
    return Container(
      height: 56,
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      decoration: BoxDecoration(
        border: Border(
          top: BorderSide(
            width: 1,
            color: NomizoTheme.nomizoDark.shade100,
          ),
        ),
        color: NomizoTheme.nomizoDark.shade50,
      ),
      child: Row(
        children: [
          OutlinedButton(
            onPressed: () {
              provider.pickImage();
            },
            style: Theme.of(context).outlinedButtonTheme.style?.copyWith(
                  fixedSize: MaterialStateProperty.all(
                    const Size(40, 40),
                  ),
                  shape: MaterialStateProperty.all(
                    const CircleBorder(),
                  ),
                ),
            child: const Icon(Icons.camera_alt),
          ),
          OutlinedButton(
            onPressed: () {
              Navigator.pushNamed(context, '/selectCategory');
            },
            style: Theme.of(context).outlinedButtonTheme.style?.copyWith(
                  shape: MaterialStateProperty.all(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                  textStyle: MaterialStateProperty.all(
                    Theme.of(context).textTheme.bodyMedium?.copyWith(
                          fontWeight: FontWeight.w500,
                          color: NomizoTheme.nomizoTosca.shade600,
                        ),
                  ),
                ),
            child: Consumer<UploadProvider>(
              builder: (context, value, _) {
                if (value.selectedCategory == null) {
                  return const Text('Pilih Kategori');
                }
                return Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    circlePic(24, value.selectedCategory!.profileImage!),
                    const SizedBox(width: 8),
                    Text(value.selectedCategory!.name!),
                  ],
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  /// Upload Process
  Future<String> postThread(
    UploadProvider provider,
    CategoryModel categoryModel,
    List<File> imgs,
  ) async {
    List<String> images = [];
    int index = 0;
    if (imgs.length < 5) {
      for (int i = index; i < imgs.length; i++) {
        images.add(imgs[i].path);
      }
    }
    for (var i = index; i < 5 - index; i++) {
      if (index > 0) {
        images.add('');
      } else {
        images.add(imgs[i].path);
      }
    }
    bool result = await provider.uploadThread(
      ThreadModel(
        author: Author(
          id: profileModel!.id,
          username: profileModel!.username,
          deletedAt: null,
        ),
        content: _contentController.text,
        createdAt: DateTime.now().toIso8601String(),
        image1: images[0],
        image2: images[1],
        image3: images[2],
        image4: images[3],
        image5: images[4],
        title: _titleController.text,
        topic: Topic(
          id: categoryModel.id,
          name: categoryModel.name,
          profileImage: categoryModel.profileImage,
        ),
      ),
    );
    if (result) {
      return 'Thread berhasil diupload';
    }
    return 'Thread gagal diupload';
  }
}
