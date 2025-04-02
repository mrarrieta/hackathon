import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:home/data/record_repository.dart';
import 'package:home/tools/record_validator.dart';
import 'package:home/widgets/home_content.dart';
import 'package:locale/l10n/core_localizations_extensions.dart';
import 'package:ui/widgets/app_bottom_sheet.dart';

class HomePage extends StatelessWidget {
  const HomePage({
    required this.recordRepository,
    required this.recordValidatorProvider,
    required this.goToLogin,
    required this.goToProfile,
    super.key
  });

  final RecordRepository recordRepository;
  final RecordValidatorProvider recordValidatorProvider;
  final Function() goToLogin;
  final Function() goToProfile;

  @override
  Widget build(BuildContext context) {

    dotenv.load(fileName: ".env");

    return Scaffold(
        appBar: AppBar(title: Text(context.l10n.homePageTitle)),
        body: SafeArea(
            child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: HomeContent(
                  recordValidatorProvider: recordValidatorProvider,
                  recordRepository: recordRepository,
                  goToLogin: goToLogin,
                  goToProfile: goToProfile,
                )
            )
        ),
      bottomNavigationBar: AppBottomSheet(
        goToHome: null,
        goToProfile: goToProfile,
        goToLogout: goToLogin,
      ),
    );
  }
}
