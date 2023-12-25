import 'package:firebase_example/components/colors.dart';
import 'package:flutter/material.dart';

class RoundButton extends StatelessWidget {
  final String title;
  final VoidCallback ontap;
  final bool loading;
  const RoundButton(
      {super.key,
      required this.title,
      required this.ontap,
      this.loading = false});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: ontap,
      child: Container(
        height: 48,
        width: 342,
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(10)),
          color: AppColors.mainColor,
        ),
        child: Center(
          child: loading
              ? const CircularProgressIndicator(
                  color: Colors.white,
                )
              : Text(
                  title,
                  style: const TextStyle(color: Colors.white),
                ),
        ),
      ),
    );
  }
}
