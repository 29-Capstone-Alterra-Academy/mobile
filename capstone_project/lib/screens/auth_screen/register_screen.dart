import 'package:capstone_project/screens/components/button_widget.dart';
import 'package:flutter/material.dart';
import 'package:email_validator/email_validator.dart';
import 'package:capstone_project/screens/components/header.dart';
import 'package:capstone_project/screens/components/appbar.dart';

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

  @override
  void dispose() {
    email.dispose();
    password.dispose();
    confirmPassword.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
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
                userRegisterForm(),
                button(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget userRegisterForm() {
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
                controller: email,
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.white,
                  contentPadding: const EdgeInsets.all(8),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(4),
                  ),
                ),
                style: const TextStyle(
                  fontSize: 13,
                ),
                validator: (email) {
                  if (email == null || email.isEmpty) {
                    return '* Silahkan memasukkan Email';
                  } else if (!EmailValidator.validate(email)) {
                    return '* Enter a valid email';
                  }
                  return null; //form is valid
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
              TextFormField(
                controller: password,
                obscureText: true,
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.white,
                  contentPadding: const EdgeInsets.all(8),
                  suffixIcon: const Icon(Icons.remove_red_eye_outlined),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(4),
                  ),
                ),
                style: const TextStyle(
                  fontSize: 13,
                ),
                validator: (password) {
                  if (password == null || password.isEmpty) {
                    return '* Silahkan memasukkan Password';
                  } else if (password.length < 5) {
                    return '* Masukan min. 5 karakter';
                  }
                  return null; //form is valid
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
                'Konfirmasi Password',
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 14,
                ),
              ),
              const SizedBox(
                height: 8,
              ),
              TextFormField(
                controller: confirmPassword,
                obscureText: true,
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.white,
                  contentPadding: const EdgeInsets.all(8),
                  suffixIcon: const Icon(Icons.remove_red_eye_outlined),
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
                  } else if (confirm != password.text) {
                    return '* Password tidak sama';
                  }
                  return null; //form is valid
                },
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget button() {
    return Container(
      margin: const EdgeInsets.only(top: 36),
      child: Column(
        children: [
          // Register Button
          elevatedBtnLong42(
            context,
            () {
              final validateForm = formkey.currentState!.validate();
              if (validateForm) {
                Navigator.of(context).pushReplacementNamed('/login');
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
}
