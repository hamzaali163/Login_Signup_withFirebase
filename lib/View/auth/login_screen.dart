import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_example/Utils/general_utils.dart';
import 'package:firebase_example/Utils/routes_names.dart';
import 'package:firebase_example/Widgets/roundbutton.dart';
import 'package:firebase_example/components/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final emailcontroller = TextEditingController();
  final passwordcontroller = TextEditingController();
  FocusNode emailfocusnode = FocusNode();
  FocusNode passwordfocusnode = FocusNode();
  bool load = false;
  final _formkey = GlobalKey<FormState>();
  final _auth = FirebaseAuth.instance;
  // final _myrepo = GeneralUtils();
  @override
  void dispose() {
    super.dispose();
    emailcontroller.dispose();
    passwordcontroller.dispose();
  }

  void login() async {
    setState(
      () {
        load = true;
      },
    );
    await _auth
        .signInWithEmailAndPassword(
            email: emailcontroller.text.toString(),
            password: passwordcontroller.text.toString())
        .then((value) {
      GeneralUtils().successfulmessage("Logged In", context);
      Navigator.pushNamed(context, RoutesNames.firestorelistview);
      setState(() {
        load = false;
      });
    }).onError((error, stackTrace) {
      GeneralUtils().showerrormessage(error.toString(), context);
      setState(() {
        load = false;
      });
    });
    // try {
    //   await _auth.signInWithEmailAndPassword(
    //       email: emailcontroller.text.toString(),
    //       password: passwordcontroller.text.toString());
    //   GeneralUtils().successfulmessage('Logged in succesfully', context);
    // } on FirebaseAuthException catch (e) {
    //   if (e.code == 'user-not-found') {
    //     GeneralUtils().showerrormessage(' not found', context);
    //   } else if (e.code == 'wrong-password') {
    //     GeneralUtils().showerrormessage('Wrong Password', context);
    //   } else if (e.code == 'invalid-email') {
    //     GeneralUtils().showerrormessage('Emial bad format', context);
    //   }

    //}
    // if (e.code == 'user-not-found') {
    //   GeneralUtils().showerrormessage('User is not found', context);
    // } else if (e.code == 'invalid-email') {
    //   GeneralUtils().showerrormessage('Invalid email address', context);
    // } else if (e.code == 'user-disabled') {
    //   GeneralUtils().showerrormessage('Account has been disabled', context);
    // } else if (e.code == 'wrong-password') {
    //   GeneralUtils()
    //       .showerrormessage('Invalid password, try again!', context);
    // }
  }

  @override
  Widget build(BuildContext context) {
    //   final provider = Provider.of<GeneralUtils>(context, listen: false);
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        // title: const Text('Login Screen'),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: SingleChildScrollView(
          child: Column(
            // mainAxisAlignment: MainAxisAlignment.center,
            // crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Padding(
                padding: EdgeInsets.only(top: 90, bottom: 10),
                child: Align(
                  alignment: Alignment.bottomLeft,
                  child: Text(
                    'Sign In',
                    style: AppColors.heading,
                  ),
                ),
              ),
              const Align(
                alignment: Alignment.bottomLeft,
                child: Text(
                  'Please log in into your account',
                  style: AppColors.subheading,
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Form(
                key: _formkey,
                child: Column(
                  children: [
                    TextFormField(
                      focusNode: emailfocusnode,
                      controller: emailcontroller,
                      decoration: const InputDecoration(
                        fillColor: Color(0xffF5F5F5),
                        border: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.transparent)),
                        labelText: 'Email',
                        hintText: "Enter email",
                        prefixIcon: Icon(
                          Icons.email_outlined,
                          color: AppColors.mainColor,
                        ),
                      ),
                      onFieldSubmitted: ((value) {
                        GeneralUtils.focusnodechange(
                            emailfocusnode, passwordfocusnode, context);
                      }),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Enter your email address';
                        } else if (!value.contains('@')) {
                          return 'Enter a correct email, i.e hamza@gmail.com';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    TextFormField(
                      obscureText: true,
                      focusNode: passwordfocusnode,
                      controller: passwordcontroller,
                      decoration: const InputDecoration(
                          fillColor: Color(0xffF5F5F5),
                          border: OutlineInputBorder(
                              borderSide:
                                  BorderSide(color: Colors.transparent)),
                          hintText: "Enter password",
                          labelText: 'Password',
                          prefixIcon: Icon(
                            Icons.lock,
                            color: AppColors.mainColor,
                          )),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Enter password';
                        }
                        return null;
                      },
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.05,
                    ),
                    RoundButton(
                        title: 'Log In',
                        loading: load,
                        ontap: () {
                          if (_formkey.currentState!.validate()) {
                            login();
                          }
                        }),
                    Align(
                      alignment: Alignment.bottomRight,
                      child: TextButton(
                          onPressed: () {
                            Navigator.pushNamed(
                                context, RoutesNames.ForgotPasswordScreen);
                          },
                          child: const Text(
                            "Forgot Password",
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.orange,
                                fontSize: 14),
                          )),
                    ),
                    // SizedBox(
                    //   height: MediaQuery.of(context).size.height * 0.05,
                    // ),
                  ],
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              RoundButton(
                  title: 'Sign in with phone number',
                  ontap: () {
                    Navigator.pushNamed(context, RoutesNames.phoneNumberScreen);
                  }),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.03,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
