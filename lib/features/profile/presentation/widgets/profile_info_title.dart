import 'package:al_mobdea/core/style/textstyles.dart';
import 'package:flutter/material.dart';

class ProfileInfoTitle extends StatelessWidget {
  const ProfileInfoTitle({super.key, required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: AlignmentDirectional.centerEnd,
      child: Text(
        title,
        textDirection: TextDirection.rtl,
        style: AppTextStyle.font18TextPrimarySemiBoldKufam(),
      ),
    );
  }
}
