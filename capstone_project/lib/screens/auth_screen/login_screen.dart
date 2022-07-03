import 'dart:developer';

import 'package:capstone_project/screens/components/button_widget.dart';
import 'package:flutter/material.dart';
import 'package:capstone_project/screens/components/header.dart';
import 'package:capstone_project/screens/components/appbar.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  var email = TextEditingController();
  var password = TextEditingController();
  var formkey = GlobalKey<FormState>();

  @override
  void dispose() {
    email.dispose();
    password.dispose();
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
                  height: 35,
                ),
                userLoginForm(),
                resetPassword(),
                button(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget userLoginForm() {
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
              TextFormField(
                controller: password,
                obscureText: true,
                decoration: InputDecoration(
                  filled: true,
                  contentPadding: const EdgeInsets.all(8),
                  fillColor: Colors.white,
                  suffixIcon: const Icon(Icons.remove_red_eye_outlined),
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
                  }
                  return null;
                },
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget resetPassword() {
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

  Widget button() {
    return Container(
      margin: const EdgeInsets.only(top: 32),
      child: Column(
        children: [
          // Login Button
          elevatedBtnLong42(
            context,
            () {
              final loginValid = formkey.currentState!.validate();
              if (loginValid) {
                // action
                log('login success');
                Navigator.pushNamedAndRemoveUntil(
                    context, '/navbar', (route) => false);
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
