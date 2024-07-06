import 'package:flutter/material.dart';

class AppImages {
  static const String kingqueen = 'assets/kingqueen.png';
  static const String logo = 'assets/kobotr-logo-square.png';
  static const String letter = 'assets/letter.png';
  static const String logoTextWhite = 'assets/kabotr-text-white.png';
  static const String aboveLogo = 'assets/kobotr-logo-square-transparent.png';
}
class PatrPageLogo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Image.asset(
      'assets/kobotr-logo-square-transparent.png',
      fit: BoxFit.fill,
      height: 60,
      width: 60,
    );
  }
}
