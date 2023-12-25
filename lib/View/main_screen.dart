import 'package:firebase_example/Utils/routes_names.dart';
import 'package:firebase_example/Widgets/roundbutton.dart';
import 'package:firebase_example/components/colors.dart';
import 'package:flutter/material.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      child: Scaffold(
        body: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Padding(
              padding: EdgeInsets.only(top: 90, left: 20, bottom: 10),
              child: Text(
                "Welcome",
                style: AppColors.heading,
              ),
            ),
            const Padding(
              padding: EdgeInsets.symmetric(
                horizontal: 22,
              ),
              child: Text(
                "Lets get started",
                style: AppColors.subheading,
              ),
            ),
            const SizedBox(
              height: 250,
            ),
            const Padding(
              padding: EdgeInsets.only(left: 20, bottom: 20),
              child: Text(
                "Existing  customer / Get started ",
                style: AppColors.subheading,
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: RoundButton(
                  title: 'Sign in',
                  ontap: () {
                    Navigator.pushNamed(context, RoutesNames.loginscreen);
                  }),
            ),
            const SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                children: [
                  const Text(
                    "New customer?",
                    style: AppColors.subheading,
                  ),
                  const SizedBox(
                    width: 5,
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.pushNamed(context, RoutesNames.signUpScreen);
                    },
                    child: const Text(
                      'Create new account',
                      style: TextStyle(
                          fontFamily: 'Plus Jakarta Sans',
                          color: AppColors.mainColor,
                          fontSize: 16,
                          fontWeight: FontWeight.normal),
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
