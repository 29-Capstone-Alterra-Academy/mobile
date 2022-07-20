import 'package:capstone_project/modelview/authentication/register_provider.dart';
import 'package:capstone_project/screens/components/button_widget.dart';
import 'package:capstone_project/screens/components/card_widget.dart';
import 'package:capstone_project/themes/nomizo_theme.dart';
import 'package:flutter/material.dart';
import 'package:email_validator/email_validator.dart';
import 'package:capstone_project/screens/components/header.dart';
import 'package:capstone_project/screens/components/appbar.dart';
import 'package:provider/provider.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  var email = TextEditingController();
  var password = TextEditingController();
  var confirmPassword = TextEditingController();

  var formkey = GlobalKey<FormState>();
  var emailKey = GlobalKey<FormFieldState>();
  var passwordKey = GlobalKey<FormFieldState>();
  var confirmKey = GlobalKey<FormFieldState>();

  @override
  void dispose() {
    email.dispose();
    password.dispose();
    confirmPassword.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<RegisterProvider>(context, listen: false);
    return Scaffold(
      appBar: const AppBarComponent(
        logoImage: "assets/images/nomizo-icon.png",
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.only(
              left: 16,
              right: 16,
              top: 32,
            ),
            child: Column(
              children: [
                const HeaderComponets(),
                const SizedBox(
                  height: 18,
                ),
                userRegisterForm(provider),
                button(provider),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget userRegisterForm(RegisterProvider provider) {
    return Form(
      key: formkey,
      child: Column(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Email',
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 14,
                ),
              ),
              const SizedBox(height: 8),
              // Email Field
              TextFormField(
                key: emailKey,
                controller: email,
                onChanged: (value) => emailKey.currentState!.validate(),
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.white,
                  contentPadding: const EdgeInsets.all(8),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(4),
                  ),
                ),
                style: const TextStyle(fontSize: 13),
                validator: (email) {
                  if (email == null || email.isEmpty) {
                    return '* Silahkan memasukkan Email';
                  } else if (!EmailValidator.validate(email)) {
                    return '* Masukkan email yang valid';
                  }
                  return null; //form is valid
                },
              ),
            ],
          ),
          const SizedBox(height: 8),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Password',
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 14,
                ),
              ),
              const SizedBox(height: 8),
              // Password Field
              Consumer<RegisterProvider>(
                builder: (context, value, _) {
                  return TextFormField(
                    key: passwordKey,
                    controller: password,
                    obscureText: value.obscurePassword,
                    onChanged: (value) => passwordKey.currentState!.validate(),
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.white,
                      contentPadding: const EdgeInsets.all(8),
                      suffixIcon: InkWell(
                        onTap: () => provider.changeObscurePassword(),
                        child: value.obscurePassword
                            ? const Icon(Icons.remove_red_eye_outlined)
                            : const Icon(Icons.remove_red_eye),
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(4),
                      ),
                    ),
                    style: const TextStyle(fontSize: 13),
                    validator: (password) {
                      if (password == null || password.isEmpty) {
                        return '* Silahkan memasukkan Password';
                      }
                      if (password.length < 8) {
                        return '* Password harus minimal 8 karakter';
                      }
                      if (!password.contains(RegExp(r'^[a-zA-Z0-9]+$'))) {
                        return '* Password hanya boleh berupa karakter alphanumeric';
                      }
                      return null; //form is valid
                    },
                  );
                },
              ),
            ],
          ),
          const SizedBox(height: 8),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Konfirmasi Password',
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 14,
                ),
              ),
              const SizedBox(height: 8),
              // Confirm Password Field
              Consumer<RegisterProvider>(
                builder: (context, value, _) {
                  return TextFormField(
                    key: confirmKey,
                    controller: confirmPassword,
                    obscureText: value.obscureConfirm,
                    onChanged: (value) => confirmKey.currentState!.validate(),
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.white,
                      contentPadding: const EdgeInsets.all(8),
                      suffixIcon: InkWell(
                        onTap: () => provider.changeObscureConfirm(),
                        child: value.obscureConfirm
                            ? const Icon(Icons.remove_red_eye_outlined)
                            : const Icon(Icons.remove_red_eye),
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(4),
                      ),
                    ),
                    style: const TextStyle(
                      fontSize: 13,
                    ),
                    validator: (confirm) {
                      if (confirm == null || confirm.isEmpty) {
                        return '* Silahkan memasukkan Password';
                      }
                      if (confirm != password.text) {
                        return '* Password tidak sama';
                      }
                      return null; //form is valid
                    },
                  );
                },
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget button(RegisterProvider provider) {
    return Container(
      margin: const EdgeInsets.only(top: 36),
      child: Column(
        children: [
          // Register Button
          elevatedBtnLong42(
            context,
            () async {
              final validateForm = formkey.currentState!.validate();
              if (validateForm) {
                buildLoading(context);
                await provider
                    .registerUser(
                  email: email.text,
                  password: password.text,
                )
                    .then((value) {
                  Navigator.pop(context);
                  // error email already used
                  if (value == 'usedEmail') {
                    alertDialog(isSuccess: false, errorType: 'usedEmail');
                  }
                  // success
                  else if (value == 'success') {
                    alertDialog(isSuccess: true);
                    provider.resetObscure();
                  }
                  // something wrong
                  else {
                    alertDialog(isSuccess: false);
                  }
                });
              }
            },
            'Daftar',
          ),
          Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                'Sudah memiliki akun?',
                style: TextStyle(
                  fontSize: 11,
                  fontWeight: FontWeight.w400,
                ),
              ),
              TextButton(
                onPressed: () {
                  provider.resetObscure();
                  Navigator.pop(context);
                },
                child: const Text(
                  'Masuk',
                  style: TextStyle(
                    fontSize: 11,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Future alertDialog({required bool isSuccess, String? errorType}) {
    String imgAsset =
        isSuccess ? 'assets/img/success.png' : 'assets/img/not_found.png';

    String title = isSuccess
        ? 'Selamat, Registrasi berhasil!'
        : 'Oops, Gagal registrasi !';

    String message = '';
    if (isSuccess) {
      message =
          'Kamu telah berhasil terdaftar pada\naplikasi nomizo, Silahkan masuk\nuntuk mulai berdiskusi!';
    } else if (!isSuccess && errorType == 'usedEmail') {
      message = 'Email yang kamu masukkan telah\nterdaftar di nomizo.';
    } else {
      message = 'Something Wrong!!!';
    }
    return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 16,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                height: 24,
                width: MediaQuery.of(context).size.width,
                alignment: Alignment.centerRight,
                child: InkWell(
                  onTap: () => Navigator.pop(context),
                  child: const Icon(Icons.close),
                ),
              ),
              const SizedBox(height: 18),
              Image.asset(
                imgAsset,
                width: 168,
                height: 120,
              ),
              const SizedBox(height: 18),
              Text(
                title,
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.w600,
                      color: isSuccess
                          ? NomizoTheme.nomizoTosca.shade600
                          : NomizoTheme.nomizoRed.shade600,
                    ),
              ),
              Text(
                message,
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.bodyMedium,
              ),
              const SizedBox(height: 18),
            ],
          ),
          actions: [
            Center(
              child: elevatedBtn42(
                context,
                isSuccess
                    ? () {
                        Navigator.pop(context);
                        Navigator.of(context).pushNamedAndRemoveUntil(
                          '/login',
                          (route) => false,
                        );
                      }
                    : () => Navigator.pop(context),
                'Mengerti',
              ),
            ),
          ],
        );
      },
    );
  }
}
