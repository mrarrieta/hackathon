import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'core_localizations_es.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of CoreLocalizations
/// returned by `CoreLocalizations.of(context)`.
///
/// Applications need to include `CoreLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/core_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: CoreLocalizations.localizationsDelegates,
///   supportedLocales: CoreLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the CoreLocalizations.supportedLocales
/// property.
abstract class CoreLocalizations {
  CoreLocalizations(String locale) : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static CoreLocalizations? of(BuildContext context) {
    return Localizations.of<CoreLocalizations>(context, CoreLocalizations);
  }

  static const LocalizationsDelegate<CoreLocalizations> delegate = _CoreLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates = <LocalizationsDelegate<dynamic>>[
    delegate,
    GlobalMaterialLocalizations.delegate,
    GlobalCupertinoLocalizations.delegate,
    GlobalWidgetsLocalizations.delegate,
  ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('es')
  ];

  /// No description provided for @signupPageTitle.
  ///
  /// In es, this message translates to:
  /// **'Registrarse'**
  String get signupPageTitle;

  /// No description provided for @signup.
  ///
  /// In es, this message translates to:
  /// **'Registrarse'**
  String get signup;

  /// No description provided for @userAlreadyExists.
  ///
  /// In es, this message translates to:
  /// **'Este usuario ya existe'**
  String get userAlreadyExists;

  /// No description provided for @signupSuccessful.
  ///
  /// In es, this message translates to:
  /// **'Registro exitoso'**
  String get signupSuccessful;

  /// No description provided for @signupError.
  ///
  /// In es, this message translates to:
  /// **'Ocurrió un error al registrarse'**
  String get signupError;

  /// No description provided for @backToLogin.
  ///
  /// In es, this message translates to:
  /// **'Volver al inicio'**
  String get backToLogin;

  /// No description provided for @name.
  ///
  /// In es, this message translates to:
  /// **'Nombre'**
  String get name;

  /// No description provided for @lastname.
  ///
  /// In es, this message translates to:
  /// **'Apellido'**
  String get lastname;

  /// No description provided for @selectImage.
  ///
  /// In es, this message translates to:
  /// **'Seleccionar imagen'**
  String get selectImage;

  /// No description provided for @splashError.
  ///
  /// In es, this message translates to:
  /// **'Error al cargar la información'**
  String get splashError;

  /// No description provided for @loginPageTitle.
  ///
  /// In es, this message translates to:
  /// **'Iniciar sesión'**
  String get loginPageTitle;

  /// No description provided for @loginSuccessful.
  ///
  /// In es, this message translates to:
  /// **'Login exitoso!'**
  String get loginSuccessful;

  /// No description provided for @email.
  ///
  /// In es, this message translates to:
  /// **'Correo electrónico'**
  String get email;

  /// No description provided for @password.
  ///
  /// In es, this message translates to:
  /// **'Contraseña'**
  String get password;

  /// No description provided for @login.
  ///
  /// In es, this message translates to:
  /// **'Iniciar sesión'**
  String get login;

  /// No description provided for @skipLogin.
  ///
  /// In es, this message translates to:
  /// **'Omitir inicio de sesión'**
  String get skipLogin;

  /// No description provided for @noUserError.
  ///
  /// In es, this message translates to:
  /// **'Usuario no encontrado'**
  String get noUserError;

  /// No description provided for @wrongPasswordError.
  ///
  /// In es, this message translates to:
  /// **'Contraseña incorrecta'**
  String get wrongPasswordError;

  /// No description provided for @required.
  ///
  /// In es, this message translates to:
  /// **'Requerido'**
  String get required;

  /// No description provided for @loginError.
  ///
  /// In es, this message translates to:
  /// **'Error al iniciar sesión'**
  String get loginError;

  /// No description provided for @date.
  ///
  /// In es, this message translates to:
  /// **'Fecha'**
  String get date;

  /// No description provided for @homePageTitle.
  ///
  /// In es, this message translates to:
  /// **'Bienvenido'**
  String get homePageTitle;

  /// No description provided for @home.
  ///
  /// In es, this message translates to:
  /// **'Inicio'**
  String get home;

  /// No description provided for @profile.
  ///
  /// In es, this message translates to:
  /// **'Perfil'**
  String get profile;

  /// No description provided for @logout.
  ///
  /// In es, this message translates to:
  /// **'Cerrar sesión'**
  String get logout;

  /// No description provided for @aiGallery.
  ///
  /// In es, this message translates to:
  /// **'Galería'**
  String get aiGallery;

  /// No description provided for @aiCamera.
  ///
  /// In es, this message translates to:
  /// **'Cámara'**
  String get aiCamera;

  /// No description provided for @save.
  ///
  /// In es, this message translates to:
  /// **'Guardar'**
  String get save;

  /// No description provided for @createChild.
  ///
  /// In es, this message translates to:
  /// **'Crear Hijo '**
  String get createChild;

  /// No description provided for @create.
  ///
  /// In es, this message translates to:
  /// **'Crear '**
  String get create;

  /// No description provided for @edit.
  ///
  /// In es, this message translates to:
  /// **'Editar '**
  String get edit;

  /// No description provided for @execution.
  ///
  /// In es, this message translates to:
  /// **'Ejecución'**
  String get execution;

  /// No description provided for @record.
  ///
  /// In es, this message translates to:
  /// **'Registro'**
  String get record;

  /// No description provided for @description.
  ///
  /// In es, this message translates to:
  /// **'Descripción'**
  String get description;

  /// No description provided for @amount.
  ///
  /// In es, this message translates to:
  /// **'Cantidad'**
  String get amount;

  /// No description provided for @invalidDescription.
  ///
  /// In es, this message translates to:
  /// **'Descripción Invalida'**
  String get invalidDescription;

  /// No description provided for @invalidNumber.
  ///
  /// In es, this message translates to:
  /// **'Numero Invalido'**
  String get invalidNumber;

  /// No description provided for @invalidDate.
  ///
  /// In es, this message translates to:
  /// **'Invalid Date'**
  String get invalidDate;

  /// No description provided for @yearOfBirth.
  ///
  /// In es, this message translates to:
  /// **'Año de nacimiento'**
  String get yearOfBirth;

  /// No description provided for @yes.
  ///
  /// In es, this message translates to:
  /// **'Si'**
  String get yes;

  /// No description provided for @no.
  ///
  /// In es, this message translates to:
  /// **'No'**
  String get no;

  /// No description provided for @ok.
  ///
  /// In es, this message translates to:
  /// **'Ok'**
  String get ok;

  /// No description provided for @deleteRecord.
  ///
  /// In es, this message translates to:
  /// **'Eliminar Registro'**
  String get deleteRecord;

  /// No description provided for @areYouSureDeleteRecord.
  ///
  /// In es, this message translates to:
  /// **'Esta seguro de querer eliminar este Registro? \n\nLa información se perderá para siempre.'**
  String get areYouSureDeleteRecord;

  /// No description provided for @unauthenticatedErrorMessage.
  ///
  /// In es, this message translates to:
  /// **'Inicia sesión para acceder a esta funcionalidad'**
  String get unauthenticatedErrorMessage;

  /// No description provided for @genericErrorMessage.
  ///
  /// In es, this message translates to:
  /// **'Ocurrió un error. Intenta de nuevo más tarde.'**
  String get genericErrorMessage;

  /// No description provided for @networkFailure.
  ///
  /// In es, this message translates to:
  /// **'Revisa tu conexión a internet e intenta de nuevo'**
  String get networkFailure;
}

class _CoreLocalizationsDelegate extends LocalizationsDelegate<CoreLocalizations> {
  const _CoreLocalizationsDelegate();

  @override
  Future<CoreLocalizations> load(Locale locale) {
    return SynchronousFuture<CoreLocalizations>(lookupCoreLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) => <String>['es'].contains(locale.languageCode);

  @override
  bool shouldReload(_CoreLocalizationsDelegate old) => false;
}

CoreLocalizations lookupCoreLocalizations(Locale locale) {


  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'es': return CoreLocalizationsEs();
  }

  throw FlutterError(
    'CoreLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.'
  );
}
