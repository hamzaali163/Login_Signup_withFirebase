import 'package:firebase_example/Firestore/firestore_add_data.dart';
import 'package:firebase_example/Firestore/firestore_list_view.dart';
import 'package:firebase_example/Utils/routes_names.dart';
import 'package:firebase_example/View/UI/add_post.dart';
import 'package:firebase_example/View/UI/forgot_password.dart';
import 'package:firebase_example/View/UI/postscreen.dart';
import 'package:firebase_example/View/UI/upload_image.dart';
import 'package:firebase_example/View/auth/login_screen.dart';
import 'package:firebase_example/View/auth/phone_number_screen.dart';
import 'package:firebase_example/View/auth/sign_up_screen.dart';
import 'package:firebase_example/View/main_screen.dart';
import 'package:firebase_example/View/splash_screen.dart';
import 'package:flutter/material.dart';

class Routes {
  static Route<dynamic> generateroutes(RouteSettings settings) {
    switch (settings.name) {
      case RoutesNames.splashscreen:
        return MaterialPageRoute(
            builder: (BuildContext context) => const SplashScreen());

      case RoutesNames.loginscreen:
        return MaterialPageRoute(
            builder: (BuildContext context) => const LoginScreen());

      case RoutesNames.signUpScreen:
        return MaterialPageRoute(
            builder: (BuildContext context) => const SignUpScreen());

      case RoutesNames.postscreen:
        return MaterialPageRoute(
            builder: (BuildContext context) => const PostScreen());

      case RoutesNames.phoneNumberScreen:
        return MaterialPageRoute(
            builder: (BuildContext context) => const PhoneNumberScreen());

      case RoutesNames.addpostScreen:
        return MaterialPageRoute(
            builder: (BuildContext context) => const AddPosts());

      case RoutesNames.firestorelistview:
        return MaterialPageRoute(
            builder: (BuildContext context) => const FireBaseListView());

      case RoutesNames.firestoreladdData:
        return MaterialPageRoute(
            builder: (BuildContext context) => const FireStoreAddData());

      case RoutesNames.uploadimae:
        return MaterialPageRoute(
            builder: (BuildContext context) => const UploadImageScreen());

      case RoutesNames.ForgotPasswordScreen:
        return MaterialPageRoute(
            builder: (BuildContext context) => const ForgotPassword());

      case RoutesNames.mainScreen:
        return MaterialPageRoute(
            builder: (BuildContext context) => const MainScreen());

      default:
        return MaterialPageRoute(builder: (_) {
          return const Scaffold(
            body: Column(
              children: [
                Center(
                  child: Text('No relevant screen found'),
                )
              ],
            ),
          );
        });
    }
  }
}
