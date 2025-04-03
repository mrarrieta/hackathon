import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:locale/l10n/core_localizations_extensions.dart';
import 'package:splash/bloc/splash_state.dart';
import 'package:splash/data/splash_api.dart';
import 'package:splash/widgets/splash_content.dart';

class SplashPage extends StatelessWidget {
  const SplashPage(this.splashClient, this.onComplete, {super.key});

  final SplashClient splashClient;
  final Function() onComplete;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (context) {
          Future.delayed(const Duration(seconds: 6), () => onComplete.call());
          return SplashCubit(splashClient)..getSplashData();
        },
        child: BlocConsumer<SplashCubit,SplashState>(
            listener: (context, state) {
              if(state.error != null) {
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(context.l10n.splashError)));
                debugPrint(state.error);
              }
            },
            builder: (context,state) => Scaffold(
                body: SafeArea(
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: SplashContent(state),
                    )
                )
            )
        ),
    );
  }
}
