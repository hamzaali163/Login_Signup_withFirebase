import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_example/Utils/general_utils.dart';
import 'package:firebase_example/Widgets/roundbutton.dart';
import 'package:firebase_example/components/colors.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ForgotPassword extends StatefulWidget {
  const ForgotPassword({super.key});

  @override
  State<ForgotPassword> createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  final forgotpasswordcontroller = TextEditingController();
  final auth = FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<GeneralUtils>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text("Forgot Password"),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: SingleChildScrollView(
          child: Column(
            children: [
              const Padding(
                padding: EdgeInsets.only(top: 90, bottom: 10),
                child: Align(
                  alignment: Alignment.bottomLeft,
                  child: Text(
                    'Forgot Password?',
                    style: AppColors.heading,
                  ),
                ),
              ),
              const Align(
                alignment: Alignment.bottomLeft,
                child: Text(
                  'Enter your email for verification process, we will send code to your email',
                  style: AppColors.subheading,
                ),
              ),
              const SizedBox(
                height: 25,
              ),
              Form(
                  child: Column(
                children: [
                  TextFormField(
                    controller: forgotpasswordcontroller,
                    decoration: const InputDecoration(
                      hintText: "Enter email",
                      border: OutlineInputBorder(),
                    ),
                  )
                ],
              )),
              const SizedBox(
                height: 25,
              ),
              RoundButton(
                  title: "Continue",
                  loading: provider.load,
                  ontap: () async {
                    provider.progressindic(true);
                    await auth
                        .sendPasswordResetEmail(
                            email: forgotpasswordcontroller.text.toString())
                        .then((value) {
                      provider.progressindic(false);
                      GeneralUtils().successfulmessage("Email sent", context);
                    }).onError((error, stackTrace) {
                      provider.progressindic(false);
                      GeneralUtils()
                          .showerrormessage(error.toString(), context);
                    });
                  })
            ],
          ),
        ),
      ),
    );
  }
}
