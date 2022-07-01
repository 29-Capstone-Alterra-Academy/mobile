//import 'dart:ui';
//import 'package:flutter/cupertino.dart';
// import 'package:flutter/widgets.dart';
// import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter/material.dart';
import 'package:capstone_project/screen/components/appbar.dart';
import 'package:capstone_project/screen/components/header.dart';

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
              SizedBox(
                height: 42,
                child: TextFormField(
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
                ),
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
              SizedBox(
                height: 42,
                child: TextFormField(
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
                ),
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
          SizedBox(
            width: double.infinity,
            height: 42,
            child: ElevatedButton(
              onPressed: () {
                final loginValid = formkey.currentState!.validate();
                if (loginValid) {
                  // action
                } else {
                  // action
                }
              },
              style: ButtonStyle(
                shape: MaterialStateProperty.all(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(21.0),
                  ),
                ),
                backgroundColor:
                    MaterialStateProperty.all<Color?>(Colors.blueGrey),
              ),
              child: const Text(
                'Masuk',
                style: TextStyle(fontSize: 14),
              ),
            ),
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
                // style: TextButton.styleFrom(
                //   padding: EdgeInsets.zero,
                //   minimumSize: Size.zero,
                // ),
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
