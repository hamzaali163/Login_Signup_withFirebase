import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_example/Utils/general_utils.dart';
import 'package:firebase_example/Utils/routes_names.dart';
import 'package:firebase_example/Widgets/roundbutton.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:pin_code_text_field/pin_code_text_field.dart';

class VerifyScreen extends StatefulWidget {
  final String verificationid;
  const VerifyScreen({super.key, required this.verificationid});

  @override
  State<VerifyScreen> createState() => _VerifyScreenState();
}

class _VerifyScreenState extends State<VerifyScreen> {
  final _auth = FirebaseAuth.instance;
  final codecontroller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final providerverify = Provider.of<GeneralUtils>(context);
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: SingleChildScrollView(
          child: Column(
            children: [
              const Align(
                alignment: Alignment.bottomLeft,
                child: Padding(
                  padding: const EdgeInsets.only(top: 90),
                  child: Text(
                    'Enter 6 digit code',
                    style: TextStyle(
                        fontFamily: 'Plus Jakarta Sans',
                        color: Colors.black,
                        fontSize: 18,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              const Text(
                'A 6 digit code has been sent to your phone number',
                style: TextStyle(
                    fontFamily: 'Plus Jakarta Sans',
                    color: Colors.black,
                    fontSize: 14,
                    fontWeight: FontWeight.w600),
              ),
              const SizedBox(
                height: 30,
              ),
              PinCodeTextField(
                controller: codecontroller,
                maxLength: 6,
                pinBoxHeight: 50,
                pinBoxWidth: 45,
                defaultBorderColor: Colors.black,
              ),
              const SizedBox(
                height: 35,
              ),
              RoundButton(
                  title: 'Confirm',
                  loading: providerverify.load,
                  ontap: () async {
                    providerverify.progressindic(true);
                    final credentials = PhoneAuthProvider.credential(
                        verificationId: widget.verificationid,
                        smsCode: codecontroller.text);

                    try {
                      await _auth.signInWithCredential(credentials);
                      providerverify.progressindic(false);

                      // ignore: use_build_context_synchronously
                      Navigator.pushNamed(context, RoutesNames.postscreen);
                    } catch (e) {
                      providerverify.progressindic(false);

                      // ignore: use_build_context_synchronously
                      GeneralUtils().showerrormessage(e.toString(), context);
                    }
                  }),
            ],
          ),
        ),
      ),
    );
  }
}
