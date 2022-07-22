import 'package:capstone_project/screens/components/button_widget.dart';
import 'package:flutter/material.dart';

// Verification code
class VerificationCodeScreen extends StatefulWidget {
  const VerificationCodeScreen({Key? key}) : super(key: key);

  @override
  State<VerificationCodeScreen> createState() => _VerificationCodeScreenState();
}

class _VerificationCodeScreenState extends State<VerificationCodeScreen> {
  var codeInput = TextEditingController();
  var verifiedCodekey = GlobalKey<FormState>();

  @override
  void dispose() {
    codeInput.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(
          color: Colors.black,
        ),
        title: const Text("Reset Password"),
        centerTitle: true,
        elevation: 1.0,
        backgroundColor: Colors.white,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.only(
              right: 16,
              left: 16,
            ),
            child: Form(
              key: verifiedCodekey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding: const EdgeInsets.only(
                      top: 12,
                    ),
                    child: const Text(
                      "Masukkan kode verifikasi",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.only(
                      top: 4,
                    ),
                    child: const Text(
                      "Masukkan 5 kode verifikasi yang anda terima",
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.only(
                      top: 12,
                    ),
                    child: SizedBox(
                      height: 42,
                      child: TextField(
                        controller: codeInput,
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: Colors.white,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(4),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        child: Container(
          padding: const EdgeInsets.all(16),
          child: SizedBox(
            width: double.infinity,
            height: 42,
            child: elevatedBtnLong42(
              context,
              () {
                Navigator.of(context).pushNamed('/resetpassword');
              },
              'Kirim kode verifikasi',
            ),
          ),
        ),
      ),
    );
  }
}
