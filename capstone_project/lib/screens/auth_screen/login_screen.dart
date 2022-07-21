import 'package:capstone_project/screens/components/button_widget.dart';
import 'package:capstone_project/screens/components/card_widget.dart';
import 'package:capstone_project/viewmodel/authentication_viewmodel/login_provider.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:capstone_project/screens/components/header.dart';
import 'package:capstone_project/screens/components/appbar.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  var email = TextEditingController();
  var password = TextEditingController();

  var formkey = GlobalKey<FormState>();
  var emailKey = GlobalKey<FormFieldState>();
  var passwordKey = GlobalKey<FormFieldState>();

  @override
  void dispose() {
    email.dispose();
    password.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<LoginProvider>(context, listen: false);
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
                  height: 35,
                ),
                userLoginForm(),
                resetPassword(provider),
                button(provider),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget userLoginForm() {
    final provider = Provider.of<LoginProvider>(context, listen: false);
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
              const SizedBox(
                height: 8,
              ),
              TextFormField(
                key: emailKey,
                controller: email,
                onChanged: (value) => emailKey.currentState!.validate(),
                decoration: InputDecoration(
                  filled: true,
                  contentPadding: const EdgeInsets.all(8),
                  fillColor: Colors.white,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(4),
                  ),
                ),
                style: const TextStyle(
                  fontSize: 13,
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return '* Silahkan memasukkan Email';
                  }
                  if (!EmailValidator.validate(value)) {
                    return '* Masukkan email yang valid';
                  }
                  return null;
                },
              ),
            ],
          ),
          const SizedBox(
            height: 8,
          ),
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
              const SizedBox(
                height: 8,
              ),
              Consumer<LoginProvider>(
                builder: (context, value, _) {
                  return TextFormField(
                    key: passwordKey,
                    controller: password,
                    onChanged: (value) => passwordKey.currentState!.validate(),
                    obscureText: value.obscurePassword,
                    decoration: InputDecoration(
                      filled: true,
                      contentPadding: const EdgeInsets.all(8),
                      fillColor: Colors.white,
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
                    style: const TextStyle(
                      fontSize: 13,
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return '* Silahkan memasukkan Password';
                      } else if (value.length < 8) {
                        return '* Password harus minimal 8 karakter';
                      }
                      return null;
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

  Widget resetPassword(LoginProvider provider) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text(
          'Kamu lupa password?',
          style: TextStyle(
            fontSize: 11,
            fontWeight: FontWeight.w400,
          ),
        ),
        TextButton(
          onPressed: () {
            provider.resetObscure();
            Navigator.of(context).pushNamed('/verifiedEmail');
          },
          child: const Text(
            'Reset Password',
            style: TextStyle(
              fontSize: 11,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
        ),
      ],
    );
  }

  Widget button(LoginProvider provider) {
    return Container(
      margin: const EdgeInsets.only(top: 32),
      child: Column(
        children: [
          // Login Button
          elevatedBtnLong42(
            context,
            () async {
              final loginValid = formkey.currentState!.validate();
              if (loginValid) {
                // action
                buildLoading(context);
                await provider.loginUser(email.text, password.text).then(
                  (value) {
                    Navigator.pop(context);
                    if (value) {
                      buildToast('Login Berhasil');
                      provider.resetObscure();
                      Navigator.pushNamedAndRemoveUntil(
                          context, '/navbar', (route) => false);
                    } else {
                      buildToast('Login Gagal');
                    }
                  },
                );
              } else {
                // action
              }
            },
            'Masuk',
          ),
          Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                'Belum memiliki akun?',
                style: TextStyle(
                  fontSize: 11,
                  fontWeight: FontWeight.w400,
                ),
              ),
              TextButton(
                onPressed: () {
                  provider.resetObscure();
                  Navigator.of(context).pushNamed('/register');
                },
                child: const Text(
                  'Daftar',
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
}
