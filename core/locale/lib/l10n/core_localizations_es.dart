import 'core_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Spanish Castilian (`es`).
class CoreLocalizationsEs extends CoreLocalizations {
  CoreLocalizationsEs([String locale = 'es']) : super(locale);

  @override
  String get splashError => 'Error al cargar la información';

  @override
  String get loginPageTitle => 'Iniciar sesión';

  @override
  String get loginSuccessful => 'Login exitoso!';

  @override
  String get email => 'Correo electrónico';

  @override
  String get password => 'Contraseña';

  @override
  String get login => 'Iniciar sesión';

  @override
  String get noUserError => 'Usuario no encontrado';

  @override
  String get wrongPasswordError => 'Contraseña incorrecta';

  @override
  String get required => 'Requerido';

  @override
  String get homePageTitle => 'Bienvenido';

  @override
  String get home => 'Inicio';

  @override
  String get profile => 'Perfil';

  @override
  String get logout => 'Cerrar sesión';

  @override
  String get yes => 'Si';

  @override
  String get no => 'No';

  @override
  String get unauthenticatedErrorMessage => 'Inicia sesión para acceder a esta funcionalidad';

  @override
  String get genericErrorMessage => 'Ocurrió un error. Intenta de nuevo más tarde.';

  @override
  String get networkFailure => 'Revisa tu conexión a internet e intenta de nuevo';
}
