import 'dart:io';

// import package
import 'package:capstone_project/model/user_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

// import theme
import 'package:capstone_project/themes/nomizo_theme.dart';

// import component
import 'package:capstone_project/screens/components/card_widget.dart';
import 'package:capstone_project/screens/components/button_widget.dart';

// import model

// import provider
import 'package:capstone_project/modelview/profile_provider.dart';
import 'package:capstone_project/modelview/edit_profile_provider.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({Key? key}) : super(key: key);

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  late final GlobalKey<FormState> _formKey;
  late final TextEditingController _usernameController;
  late final TextEditingController _fullnameController;
  late final TextEditingController _bioController;

  @override
  void initState() {
    _formKey = GlobalKey<FormState>();
    _usernameController = TextEditingController();
    _fullnameController = TextEditingController();
    _bioController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _usernameController.dispose();
    _fullnameController.dispose();
    _bioController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<EditProfileProvider>(context, listen: false);
    final profile = Provider.of<ProfileProvider>(context, listen: false);
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
            Consumer<EditProfileProvider>(builder: (context, value, _) {
              return Padding(
                padding: const EdgeInsets.all(15),
                child: elevatedBtn28(
                  context,
                  () async {
                    if (_formKey.currentState!.validate()) {
                      _formKey.currentState!.save();

                      buildLoading(context);

                      String? msg;
                      bool isValid = false;
                      await provider
                          .checkUsername(_usernameController.text)
                          .then((value) {
                        isValid = value;
                        if (!value) {
                          Navigator.pop(context);
                        }
                      });
                      if (!isValid) {
                        buildToast('Username telah digunakan');
                      } else {
                        await provider
                            .editProfile(UserModel(
                          birthDate: profile.currentUser!.birthDate,
                          email: profile.currentUser!.email,
                          gender: profile.currentUser!.gender,
                          id: profile.currentUser!.id,
                          profileImage: value.profilePic,
                          username: _usernameController.text,
                        ))
                            .then((value) {
                          if (value) {
                            msg = 'Profil berhasil diubah';
                            Navigator.pop(context);
                            Navigator.pop(context);
                          } else {
                            msg = 'Profil gagal diubah';
                            Navigator.pop(context);
                          }
                        });
                        buildToast(msg ?? '');
                      }
                    }
                  },
                  'Simpan',
                ),
              );
            }),
          ],
        ),
        body: Consumer<ProfileProvider>(builder: (context, value, child) {
          _usernameController.text = value.currentUser!.username!;
          // _fullnameController.text = '';
          // _bioController.text = '';
          return SingleChildScrollView(
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
                        Consumer<EditProfileProvider>(
                            builder: (context, value, child) {
                          return pictureSection(value.img);
                        }),
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
                  fieldLabel('Username'),
                  TextFormField(
                    controller: _usernameController,
                    maxLines: 1,
                    style: Theme.of(context).textTheme.bodyMedium,
                    decoration: InputDecoration(
                      isDense: true,
                      border: const OutlineInputBorder(),
                      hintText: 'Username Anda',
                      hintStyle:
                          Theme.of(context).textTheme.bodyMedium?.copyWith(
                                color: NomizoTheme.nomizoDark.shade500,
                              ),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return '* Silahkan memasukkan username anda';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 12),
                  // bio section
                  fieldLabel('Fullname'),
                  TextFormField(
                    controller: _fullnameController,
                    maxLines: 1,
                    style: Theme.of(context).textTheme.bodyMedium,
                    decoration: InputDecoration(
                      isDense: true,
                      border: const OutlineInputBorder(),
                      hintText: 'Nama lengkap Anda',
                      hintStyle:
                          Theme.of(context).textTheme.bodyMedium?.copyWith(
                                color: NomizoTheme.nomizoDark.shade500,
                              ),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return '* Silahkan memasukkan nama lengkap anda';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 12),
                  // rules section
                  fieldLabel('Bio'),
                  TextFormField(
                    controller: _bioController,
                    minLines: 1,
                    maxLines: null,
                    style: Theme.of(context).textTheme.bodyMedium,
                    keyboardType: TextInputType.multiline,
                    decoration: InputDecoration(
                      isDense: true,
                      border: const OutlineInputBorder(),
                      hintText: 'Berikan deskripsi pada profil Anda',
                      hintStyle:
                          Theme.of(context).textTheme.bodyMedium?.copyWith(
                                color: NomizoTheme.nomizoDark.shade500,
                              ),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return '* Silahkan memasukkan deskripsi anda';
                      }
                      return null;
                    },
                  ),
                ],
              ),
            ),
          );
        }),
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

  Widget cameraBtn(EditProfileProvider provider) {
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
