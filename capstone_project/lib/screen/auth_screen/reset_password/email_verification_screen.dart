import 'package:flutter/material.dart';

// Email Verification
class VerificationEmailScreen extends StatefulWidget {
  const VerificationEmailScreen({Key? key}) : super(key: key);

  @override
  State<VerificationEmailScreen> createState() =>
      _VerificationEmailScreenState();
}

class _VerificationEmailScreenState extends State<VerificationEmailScreen> {
  var emailInput = TextEditingController();
  var verifiedEmailkey = GlobalKey<FormState>();

  @override
  void dispose() {
    emailInput.dispose();
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
          child: Container(
            padding: const EdgeInsets.only(
              right: 16,
              left: 16,
            ),
            child: Form(
              key: verifiedEmailkey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding: const EdgeInsets.only(
                      top: 12,
                    ),
                    child: const Text(
                      "Silahkan masukan email anda",
                      style: TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.only(
                      top: 4,
                    ),
                    child: const Text(
                      "Gunakan email yang telah anda daftarkan",
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.only(
                      top: 8,
                    ),
                    child: SizedBox(
                      height: 42,
                      child: TextField(
                        controller: emailInput,
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
            child: ElevatedButton(
              onPressed: () {
                Navigator.of(context).pushNamed('/verifiedCode');
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
                'Kirim kode verifikasi',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
