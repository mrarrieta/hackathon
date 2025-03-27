import 'package:flutter/material.dart';
import 'package:ui/resources/assets.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen(this.onComplete, {super.key});

  final Function() onComplete;

  @override
  State<StatefulWidget> createState() => _SplashScreenState();

}

class _SplashScreenState extends State<SplashScreen> {

  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 2), () {
      widget.onComplete.call();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
            child: Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Spacer(flex: 1,),
                  AppAsset.logo(),
                  const Spacer(flex: 1,),
                ],
              )
            )
        )
    );
  }
}
