import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_example/Utils/routes_names.dart';
import 'package:flutter/material.dart';

class SplashServices {
  void islogin(BuildContext context) {
    final _auth = FirebaseAuth.instance;

    final user = _auth.currentUser;

    if (user != null) {
      Timer(const Duration(seconds: 3),
          () => Navigator.pushNamed(context, RoutesNames.firestorelistview));
    } else {
      Timer(const Duration(seconds: 3),
          () => Navigator.pushNamed(context, RoutesNames.mainScreen));
    }
  }
}
