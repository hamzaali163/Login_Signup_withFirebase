import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_example/Utils/general_utils.dart';
import 'package:firebase_example/View/auth/verify_screen.dart';
import 'package:firebase_example/Widgets/roundbutton.dart';
import 'package:firebase_example/components/colors.dart';
import 'package:flutter/material.dart';

class PhoneNumberScreen extends StatefulWidget {
  const PhoneNumberScreen({super.key});

  @override
  State<PhoneNumberScreen> createState() => _PhoneNumberScreenState();
}

class _PhoneNumberScreenState extends State<PhoneNumberScreen> {
  final auth = FirebaseAuth.instance;
  final phoneNumberController = TextEditingController();
  bool load = false;

  void login() async {
    setState(
      () {
        load = true;
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
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
                    'Phone Number',
                    style: AppColors.heading,
                  ),
                ),
              ),
              const Align(
                alignment: Alignment.bottomLeft,
                child: Text(
                  'Please enter your phone number',
                  style: AppColors.subheading,
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              TextFormField(
                controller: phoneNumberController,
                keyboardType: TextInputType.phone,
                decoration: const InputDecoration(
                  hintText: "+92 312 405 0222",
                  labelText: 'Phone number',
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Color(0xffF5F5F5),
                    ),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Color(0xffF5F5F5),
                    ),
                  ),
                ),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Enter phone number';
                  }
                  return null;
                },
              ),
              const SizedBox(
                height: 35,
              ),
              RoundButton(
                  title: 'Login',
                  loading: load,
                  ontap: () async {
                    setState(() {
                      load = true;
                    });
                    await auth.verifyPhoneNumber(
                      phoneNumber: phoneNumberController.text,
                      verificationCompleted: (_) {},
                      verificationFailed: (e) {
                        debugPrint('Verification failed');

                        GeneralUtils().showerrormessage(e.toString(), context);
                        setState(() {
                          load = false;
                        });
                      },
                      codeSent: (String verificationId, int? token) {
                        {
                          debugPrint('code sent');

                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => VerifyScreen(
                                        verificationid: verificationId,
                                      )));
                          setState(() {
                            load = false;
                          });
                        }
                      },
                      codeAutoRetrievalTimeout: (e) {
                        debugPrint('codeAutoRetrievalTimeout');
                        GeneralUtils().showerrormessage(e.toString(), context);
                        setState(() {
                          load = false;
                        });
                      },
                    );
                  })
            ],
          ),
        ),
      ),
    );
  }
}
