import 'package:flutter/material.dart';
import 'package:capstone_project/screen/components/appbar.dart';
import 'package:capstone_project/screen/components/header.dart';
import 'package:email_validator/email_validator.dart';

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
              SizedBox(
                height: 42,
                child: TextFormField(
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
                    if (email != null && !EmailValidator.validate(email)) {
                      return 'Enter a valid email';
                    } else {
                      return null; //form is valid
                    }
                  },
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
                    if (password != null && password.length < 5) {
                      return 'masukan min. 5 characters';
                    } else {
                      return null;
                    }
                  },
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
                'Konfirmasi Password',
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
                    // ignore: unrelated_type_equality_checks
                    if (confirm != null && confirm == password) {
                      return 'password tidak sama';
                    } else {
                      return null;
                    }
                  },
                ),
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
          SizedBox(
            width: double.infinity,
            height: 42,
            child: ElevatedButton(
              onPressed: () {
                final validateForm = formkey.currentState!.validate();
                if (validateForm) {
                  Navigator.of(context).pushReplacementNamed('/login');
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
                'Daftar',
                style: TextStyle(fontSize: 14),
              ),
            ),
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
                  Navigator.of(context).pushReplacementNamed('/login');
                },
                // style: TextButton.styleFrom(
                //   padding: EdgeInsets.zero,
                //   minimumSize: Size.zero,
                // ),
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
