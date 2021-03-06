import 'dart:io';

// import package
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

// import theme
import 'package:capstone_project/themes/nomizo_theme.dart';

// import component
import 'package:capstone_project/screens/components/card_widget.dart';
import 'package:capstone_project/screens/components/button_widget.dart';

// import model
import 'package:capstone_project/model/category_model/category_model.dart';

// import provider
import 'package:capstone_project/viewmodel/thread_viewmodel/upload_provider.dart';
import 'package:capstone_project/viewmodel/category_viewmodel/create_category_provider.dart';

class CreateCategoryScreen extends StatefulWidget {
  const CreateCategoryScreen({Key? key}) : super(key: key);

  @override
  State<CreateCategoryScreen> createState() => _CreateCategoryScreenState();
}

class _CreateCategoryScreenState extends State<CreateCategoryScreen> {
  late final GlobalKey<FormState> _formKey;
  late final TextEditingController _nameController;
  late final TextEditingController _bioController;
  late final TextEditingController _rulesController;

  @override
  void initState() {
    _formKey = GlobalKey<FormState>();
    _nameController = TextEditingController();
    _bioController = TextEditingController();
    _rulesController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _nameController.dispose();
    _bioController.dispose();
    _rulesController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final provider =
        Provider.of<CreateCategoryProvider>(context, listen: false);
    final category = Provider.of<UploadProvider>(context, listen: false);
    return WillPopScope(
      onWillPop: () async {
        category.getAllCategory();
        provider.resetForm();
        return true;
      },
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          leading: IconButton(
            onPressed: () {
              category.getAllCategory();
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
            Consumer<CreateCategoryProvider>(builder: (context, value, _) {
              return Padding(
                padding: const EdgeInsets.all(15),
                child: elevatedBtn28(
                  context,
                  () async {
                    if (_formKey.currentState!.validate()) {
                      _formKey.currentState!.save();

                      buildLoading(context);
                      if (await provider.checkCategoryName(
                          name: _nameController.text)) {
                        String? msg;
                        await provider
                            .createCategory(CategoryModel(
                          profileImage: value.img?.path ?? '',
                          name: _nameController.text,
                          description: _bioController.text,
                          rules: _rulesController.text,
                          activityCount: 0,
                          contributorCount: 0,
                          moderatorCount: 0,
                        ))
                            .then((value) {
                          if (value) {
                            msg = 'Kategori berhasil dibuat';
                            category.getAllCategory();
                            Navigator.pop(context);
                          } else {
                            msg = 'Kategori gagal dibuat';
                          }
                          Navigator.pop(context);
                        });
                        buildToast(msg ?? '');
                      } else {
                        Navigator.pop(context);
                        buildToast('Nama kategori sudah dipakai.');
                      }
                    }
                  },
                  'Simpan',
                ),
              );
            }),
          ],
        ),
        body: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(16, 12, 16, 0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // profile pic section
                Center(
                  child: Stack(
                    children: [
                      Consumer<CreateCategoryProvider>(
                        builder: (context, value, child) {
                          return pictureSection(value.img);
                        },
                      ),
                      Positioned(
                        bottom: 0,
                        right: 0,
                        child: cameraBtn(provider),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 32),
                // name section
                fieldLabel('Nama Kategori'),
                TextFormField(
                  controller: _nameController,
                  maxLines: 1,
                  decoration: const InputDecoration(
                    isDense: true,
                    border: OutlineInputBorder(),
                    hintText: 'Apa nama kategori yang ingin dibuat?',
                  ),
                  style: Theme.of(context).textTheme.bodyMedium,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return '* Silahkan memasukkan nama kategori';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 12),
                // bio section
                fieldLabel('Bio'),
                TextFormField(
                  controller: _bioController,
                  maxLines: 1,
                  decoration: const InputDecoration(
                    isDense: true,
                    border: OutlineInputBorder(),
                    hintText: 'Berikan penjelasan atas kategori yang dibuat',
                  ),
                  style: Theme.of(context).textTheme.bodyMedium,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return '* Silahkan memasukkan Bio kategori';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 12),
                // rules section
                fieldLabel('Rules'),
                TextFormField(
                  controller: _rulesController,
                  minLines: 1,
                  maxLines: 10,
                  keyboardType: TextInputType.multiline,
                  decoration: const InputDecoration(
                    isDense: true,
                    border: OutlineInputBorder(),
                    hintText: 'Berikan aturan terhadap kategori ini',
                  ),
                  style: Theme.of(context).textTheme.bodyMedium,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return '* Silahkan memasukkan aturan kategori';
                    }
                    return null;
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget pictureSection(File? img) {
    return Container(
      width: 120,
      height: 120,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: NomizoTheme.nomizoDark.shade50,
        border: Border.all(width: 1, color: NomizoTheme.nomizoDark.shade100),
      ),
      clipBehavior: Clip.antiAlias,
      child: img == null
          ? Padding(
              padding: const EdgeInsets.fromLTRB(8, 8, 4, 8),
              child: Image.asset(
                'assets/img/app_logo.png',
                fit: BoxFit.contain,
              ),
            )
          : Image.file(
              img,
              errorBuilder: (context, error, stackTrace) => Padding(
                padding: const EdgeInsets.fromLTRB(8, 8, 4, 8),
                child: Image.asset(
                  'assets/img/app_logo.png',
                  fit: BoxFit.contain,
                ),
              ),
              fit: BoxFit.cover,
            ),
    );
  }

  Widget cameraBtn(CreateCategoryProvider provider) {
    return OutlinedButton(
      onPressed: () {
        provider.pickImage();
      },
      style: Theme.of(context).elevatedButtonTheme.style?.copyWith(
            fixedSize: MaterialStateProperty.all(const Size(42, 42)),
            shape: MaterialStateProperty.all(const CircleBorder()),
          ),
      child: Icon(Icons.camera_alt, color: NomizoTheme.nomizoDark.shade50),
    );
  }

  Widget fieldLabel(String text) {
    return Text(
      text,
      style: Theme.of(context).textTheme.bodyLarge?.copyWith(
            fontWeight: FontWeight.w600,
          ),
    );
  }
}
