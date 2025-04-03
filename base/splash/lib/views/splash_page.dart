import 'package:flutter/material.dart';
import 'package:locale/l10n/core_localizations_extensions.dart';
import 'package:splash/data/splash_api.dart';
import 'package:splash/data/splash_view_model.dart';
import 'package:splash/widgets/splash_content.dart';
import 'package:ui/resources/assets.dart';

class SplashPage extends StatefulWidget {
  const SplashPage(this.splashViewModel, this.onComplete, {super.key});

  final SplashViewModel splashViewModel;
  final Function() onComplete;

  @override
  State<StatefulWidget> createState() => _SplashPageState();

}

class _SplashPageState extends State<SplashPage> {

  SplashResponse? _splashResponse;

  @override
  void initState() {
    super.initState();
    widget.splashViewModel.getSplash()
        .then((value) {
          _splashResponse = value;
          setState(() {});
        })
        .onError((_,error) {
          debugPrintStack(stackTrace: error);
          ScaffoldMessenger.of(context)
              .showSnackBar(SnackBar(content: Text(context.l10n.splashError)));
        });
    Future.delayed(const Duration(seconds: 6), () {
      widget.onComplete.call();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
            child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: SplashContent(_splashResponse),
            )
        )
    );
  }
}
