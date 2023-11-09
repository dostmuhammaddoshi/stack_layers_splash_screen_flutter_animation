import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/route_manager.dart';
import 'package:splash_screen_animation/home_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});
  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late Animation<double> opacityAnim;
  late AnimationController layerAnimController;
  bool isLayerCompleted = false;

  double layerHeight = 70;
  @override
  void initState() {
    layerAnimController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 1150));

    opacityAnim = Tween<double>(begin: 0, end: 1).animate(layerAnimController);

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      layerAnimController.forward().then((value) {
        setState(() {
          Future.delayed(const Duration(milliseconds: 700)).then((value) {
            setState(() {
              isLayerCompleted = true;
            });
            Future.delayed(const Duration(milliseconds: 2100)).then((value) {
              Get.to(const HomeScreen(), transition: Transition.fadeIn);
            });
          });
        });
      });
    });
    super.initState();
  }

  @override
  void dispose() {
    layerAnimController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [Colors.black, Color(0xff111115)])),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: SafeArea(
          child: Center(
            child: Container(
              alignment: Alignment.center,
              padding: const EdgeInsets.symmetric(horizontal: 30),
              child: SizedBox(
                width: 300,
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    AnimatedAlign(
                      duration: const Duration(milliseconds: 500),
                      alignment: layerAnimController.isCompleted
                          ? Alignment.centerLeft
                          : Alignment.center,
                      child: LayersWidget(
                          opacity: opacityAnim,
                          height: layerHeight,
                          layerAnimController: layerAnimController),
                    ),
                    Visibility(
                      visible: isLayerCompleted,
                      replacement: const SizedBox.shrink(),
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: Padding(
                          padding: const EdgeInsets.only(left: 90.0),
                          child: AnimatedTextKit(
                            isRepeatingAnimation: false,
                            animatedTexts: [
                              TyperAnimatedText("AirdropToken",
                                  speed: const Duration(milliseconds: 50),
                                  textStyle: const TextStyle(
                                      color: Colors.white,
                                      fontFamily: "Arial",
                                      fontSize: 32,
                                      fontWeight: FontWeight.w700)),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ).animate().fadeOut(
                delay: const Duration(milliseconds: 2800),
                duration: const Duration(seconds: 1)),
          ),
        ),
      ),
    );
  }
}

class LayersWidget extends StatelessWidget {
  const LayersWidget({
    super.key,
    required this.opacity,
    required this.height,
    required this.layerAnimController,
  });

  final Animation<double> opacity;
  final double height;
  final AnimationController layerAnimController;

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        FadeTransition(
          opacity: opacity,
          child: SvgPicture.asset(
            "assets/bottom_layer.svg",
            height: height,
          ),
        ),
        FadeTransition(
          opacity: Tween<double>(begin: opacity.value - 0.9, end: 1)
              .animate(layerAnimController),
          child: SvgPicture.asset(
            "assets/first_layer.svg",
            height: height,
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(bottom: 10),
          child: FadeTransition(
            opacity: Tween<double>(begin: opacity.value - 2, end: 1)
                .animate(layerAnimController),
            child: SvgPicture.asset(
              "assets/second_layer.svg",
              height: height - 27,
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(bottom: 0),
          child: FadeTransition(
            opacity: Tween<double>(begin: opacity.value - 10, end: 1)
                .animate(layerAnimController),
            child: SvgPicture.asset(
              "assets/last_layer.svg",
              height: height,
            ),
          ),
        ),
      ],
    );
  }
}
