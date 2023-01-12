import 'package:flutter/material.dart';
import 'package:movies/Commons/kf_extensions.dart';
import 'package:movies/Screens/Auth/auth_home_screen.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class KFOnboardingScreen extends StatefulWidget {
  const KFOnboardingScreen({super.key});

  @override
  State<KFOnboardingScreen> createState() => _KFOnboardingScreenState();
}

class _KFOnboardingScreenState extends State<KFOnboardingScreen> {
  late PageController _controller;
  @override
  void initState() {
    _controller = PageController();
    super.initState();
  }

  final List<Widget> _children = [Container(), Container(), Container()];

  int idx = 0;
  void onPageChanged(idx) => setState(() => this.idx = idx);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.only(bottom: 80),
        child: PageView(
          controller: _controller,
          children: _children,
          onPageChanged: (idx) => onPageChanged(idx),
        ),
      ),
      bottomSheet: FutureBuilder<void>(
          future: 0.seconds.delay,
          builder: (context, snapshot) {
            bool onboard = idx == _children.length - 1;
            if (snapshot.ready) {
              return Container(
                width: double.infinity,
                color: Colors.black,
                alignment: Alignment.center,
                height: 80,
                padding:
                    const EdgeInsets.symmetric(horizontal: 8, vertical: 12),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SmoothPageIndicator(
                      controller: _controller,
                      count: _children.length,
                      effect: const WormEffect(
                          activeDotColor: Colors.white,
                          dotWidth: 12,
                          dotHeight: 12),
                    ),
                    InkWell(
                        onTap: () => onboard
                            ? const AuthHomeScreen()
                                .launch(context, isNewTask: true)
                            : _controller.nextPage(
                                duration: 500.milliseconds,
                                curve: Curves.easeIn),
                        child: Container(
                          decoration: const BoxDecoration(
                              color: white,
                              borderRadius:
                                  BorderRadius.all(Radius.elliptical(16, 18))),
                          padding: const EdgeInsets.symmetric(
                              horizontal: 18, vertical: 12),
                          child: Text(
                              style: boldTextStyle(color: Colors.black),
                              onboard ? "Get Started" : "Next"),
                        )),
                  ],
                ),
              );
            }
            return Container();
          }),
    );
  }
}
