import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      decoration: const BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [Colors.black, Color(0xff111115)])),
      child: SafeArea(
        child: Scaffold(
          backgroundColor: Colors.transparent,
          body: SvgPicture.asset(
            "assets/home.svg",
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }
}
