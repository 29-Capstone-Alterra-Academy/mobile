import 'package:flutter/material.dart';

class ResetPasswordScreen extends StatefulWidget {
  const ResetPasswordScreen({Key? key}) : super(key: key);

  @override
  State<ResetPasswordScreen> createState() => _ResetPasswordScreenState();
}

class _ResetPasswordScreenState extends State<ResetPasswordScreen> {
  final _resetPassword = TextEditingController();
  final _confirmReset = TextEditingController();
  var formResetKey = GlobalKey<FormState>();

  @override
  void dispose() {
    _resetPassword.dispose();
    _confirmReset.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(
          color: Colors.black,
        ),
        title: const Text(
          "Reset Password",
          style: TextStyle(
            color: Colors.black,
            fontSize: 18,
            fontWeight: FontWeight.w600,
          ),
        ),
        centerTitle: true,
        elevation: 1.0,
        backgroundColor: Colors.white,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.only(
              left: 16,
              right: 16,
              top: 12,
            ),
            child: Column(
              children: [
                title(),
                const SizedBox(
                  height: 8,
                ),
                resetForm(),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: confirmButton(),
    );
  }

  Widget title() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: const EdgeInsets.only(
            top: 12,
          ),
          child: const Text(
            "Ubah Password",
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
        Container(
          padding: const EdgeInsets.only(
            top: 4,
          ),
          child: const Text(
            "Masukkan password yang belum pernah digunakan",
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ],
    );
  }

  Widget resetForm() {
    return Form(
      key: formResetKey,
      child: Column(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Password Baru',
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
                child: TextField(
                  controller: _resetPassword,
                  obscureText: true,
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.white,
                    suffixIcon: const Icon(Icons.remove_red_eye_outlined),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(4),
                    ),
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
                'Konfirmasi Password Baru',
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
                child: TextField(
                  controller: _confirmReset,
                  obscureText: true,
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.white,
                    suffixIcon: const Icon(Icons.remove_red_eye_outlined),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(4),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget confirmButton() {
    return BottomAppBar(
      child: Container(
        padding: const EdgeInsets.all(16),
        child: SizedBox(
          width: double.infinity,
          height: 42,
          child: ElevatedButton(
            onPressed: () {
              // Navigator.of(context).pushNamed('/verifiedCode');
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
              'Ubah Password',
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
