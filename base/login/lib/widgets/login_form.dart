import 'package:flutter/material.dart';
import 'package:icons/font_awesome_flutter.dart';
import 'package:locale/l10n/core_localizations_extensions.dart';
import 'package:login/bloc/LoginState.dart';
import 'package:ui/dialogs/widgets/dialog_button.dart';
import 'package:ui/widgets/input_field.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginForm extends StatefulWidget {
  LoginForm({
    required this.goToSignup,
    required this.skipLogin,
    super.key
  });

  final Function() skipLogin;
  final Function() goToSignup;

  @override
  State<LoginForm> createState() => _LoginFormState();
  }

class _LoginFormState extends State<LoginForm> {

  final _formKey = GlobalKey<FormState>();
  TextEditingController userController = TextEditingController();
  TextEditingController passController = TextEditingController();

  @override
  Widget build(BuildContext context) {

    var cubit = BlocProvider.of<LoginCubit>(context);

    return Form(
      key: _formKey,
      child: Column(
        children: [
          const SizedBox(height: 20),
          Icon(FontAwesomeIcons.userAstronaut, size: 150, color: Theme
              .of(context)
              .primaryColor),
          const SizedBox(height: 30),
          Padding(padding: const EdgeInsets.symmetric(horizontal: 15),
              child: InputField(
                userController,
                TextInputType.text,
                cubit.validateField,
                label: context.l10n.email,
              )),
          const SizedBox(height: 10),
          Padding(padding: const EdgeInsets.symmetric(horizontal: 15),
              child: InputField(
                passController,
                TextInputType.text,
                cubit.validateField,
                obscureText: true,
                label: context.l10n.password,
              )),
          const SizedBox(height: 30),
          DialogButton(context.l10n.login, Theme
              .of(context)
              .primaryColor, (_) {
            if (_formKey.currentState!.validate()) {
              _formKey.currentState!.save();
              cubit.login(userController.value.text, passController.value.text);
            }
          }),
          const SizedBox(height: 15),
          DialogButton(context.l10n.signupPageTitle, Theme
              .of(context)
              .primaryColor, (_) => widget.goToSignup.call()),
          const Spacer(flex: 4),
          DialogButton(context.l10n.skipLogin, Theme
              .of(context)
              .primaryColor, (_) => widget.skipLogin.call()),
          const SizedBox(height: 20),
        ],
      ),
    );
  }
}
