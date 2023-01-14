import 'package:auto_route/auto_route.dart';
import 'package:bartr/core/router/router.dart';
import 'package:bartr/core/utils/colors.dart';
import 'package:bartr/features/splashscreen/widgets/ripples_animation.dart';
import 'package:bartr/general_widgets/app_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class LandingPage extends StatefulWidget {
  const LandingPage({Key? key}) : super(key: key);

  @override
  State<LandingPage> createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage>
    with TickerProviderStateMixin {
  late AnimationController _controller;
  late AnimationController _controller2;
  late Animation<double> _animation;
  late Animation<double> _animation2;

  @override
  void initState() {
    super.initState();
    _initControllers();
  }

  void _initControllers() {
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
    )..addListener(() {
        setState(() {
          if (_controller.isCompleted) {
            _controller2.forward();
          }
        });
      });
    _controller2 = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
    )..addListener(() {
        setState(() {});
      });
    _animation = Tween<double>(begin: 0, end: 1).animate(_controller);
    _animation2 = Tween<double>(begin: 0, end: 1).animate(_controller2);
    _controller.forward();
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
    _controller2.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: SafeArea(
        child: Stack(
          alignment: Alignment.center,
          children: [
            Center(
              child: SizedBox(
                width: double.infinity,
                child: AnimatedOpacity(
                  opacity: _animation2.value,
                  duration: const Duration(seconds: 1),
                  child: SvgPicture.asset(
                    "assets/icons/2184.svg",
                    fit: BoxFit.fill,
                  ),
                ),
              ),
            ),
            Center(
              child: SizedBox(
                height: MediaQuery.of(context).size.height * 0.8,
                width: double.infinity,
                child: Stack(
                  alignment: Alignment.topCenter,
                  children: [
                    AnimatedOpacity(
                      opacity: _animation2.value,
                      duration: const Duration(seconds: 1),
                      child: SvgPicture.asset(
                        "assets/icons/2183.svg",
                        fit: BoxFit.fill,
                      ),
                    ),
                    Positioned(
                      top: height * 0.2,
                      child: RipplesAnimation(
                        child: AnimatedContainer(
                          height: (height * 0.21) * (_animation.value),
                          width: (height * 0.21) * _animation.value,
                          duration: const Duration(seconds: 1),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(200),
                            child: SvgPicture.asset(
                              "assets/icons/bartrlanding.svg",
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Positioned(
              left: 0,
              top: height * 0.05,
              child: AnimatedOpacity(
                opacity: _animation2.value,
                duration: const Duration(seconds: 1),
                child: Image.asset("assets/images/person1.png"),
              ),
            ),
            Positioned(
              right: 0,
              top: 70,
              child: AnimatedOpacity(
                opacity: _animation2.value,
                duration: const Duration(seconds: 1),
                child: SizedBox(
                  height: 74,
                  child: Card(
                    elevation: 4,
                    shadowColor: BartrColors.lightGrey,
                    child: SvgPicture.asset(
                      "assets/icons/abovecard.svg",
                      fit: BoxFit.fill,
                    ),
                  ),
                ),
              ),
            ),
            Positioned(
              right: 40,
              top: height * 0.055,
              child: AnimatedOpacity(
                opacity: _animation2.value,
                duration: const Duration(seconds: 1),
                child: Image.asset("assets/images/shoe.png"),
              ),
            ),
            Positioned(
              right: 40,
              top: height * 0.23,
              child: AnimatedOpacity(
                opacity: _animation2.value,
                duration: const Duration(seconds: 1),
                child: Image.asset("assets/images/person2.png"),
              ),
            ),
            Positioned(
              left: 18,
              top: height * 0.2,
              child: AnimatedOpacity(
                opacity: _animation2.value,
                duration: const Duration(seconds: 1),
                child: Image.asset("assets/images/phones.png"),
              ),
            ),
            Positioned(
              left: 10,
              top: height * 0.52,
              child: AnimatedOpacity(
                opacity: _animation2.value,
                duration: const Duration(seconds: 1),
                child: Card(
                  elevation: 4,
                  shadowColor: BartrColors.lightGrey,
                  child: SizedBox(
                    height: 60,
                    child: SvgPicture.asset(
                      "assets/icons/belowcard.svg",
                      fit: BoxFit.fill,
                    ),
                  ),
                ),
              ),
            ),
            Positioned(
              top: height * 0.52,
              child: AnimatedOpacity(
                opacity: _animation2.value,
                duration: const Duration(seconds: 1),
                child: SvgPicture.asset("assets/icons/texts.svg"),
              ),
            ),
            Positioned(
              left: 0,
              top: height * 0.49,
              child: AnimatedOpacity(
                opacity: _animation2.value,
                duration: const Duration(seconds: 1),
                child: Image.asset("assets/images/cloth.png"),
              ),
            ),
            Positioned(
              right: 0,
              top: height * 0.53,
              child: AnimatedOpacity(
                opacity: _animation2.value,
                duration: const Duration(seconds: 1),
                child: Image.asset("assets/images/watch.png"),
              ),
            ),
            Positioned(
              left: 5,
              top: height * 0.79,
              child: AnimatedOpacity(
                opacity: _animation2.value,
                duration: const Duration(seconds: 1),
                child: Image.asset("assets/images/person3.png"),
              ),
            ),
            Positioned(
              top: height * 0.65,
              child: AnimatedOpacity(
                opacity: _animation2.value,
                duration: const Duration(seconds: 1),
                child: AppButton(
                  onTap: () => context.router.replace(const RegisterRoute()),
                  text: "Get Started",
                  width: width * 0.9,
                ),
              ),
            ),
            Positioned(
              top: height * 0.73,
              child: AnimatedOpacity(
                opacity: _animation2.value,
                duration: const Duration(seconds: 1),
                child: AppButton(
                  onTap: () => context.router.replace(const LoginRoute()),
                  text: "Login",
                  color: Colors.transparent,
                  textColor: BartrColors.primary,
                  width: width * 0.7,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
