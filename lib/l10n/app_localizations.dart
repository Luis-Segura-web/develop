import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_es.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
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
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale)
    : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

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
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
        delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[Locale('es')];

  /// Título de la aplicación
  ///
  /// In es, this message translates to:
  /// **'Reproductor IPTV'**
  String get appTitle;

  /// Mensaje de bienvenida
  ///
  /// In es, this message translates to:
  /// **'Bienvenido'**
  String get welcome;

  /// Botón de inicio de sesión
  ///
  /// In es, this message translates to:
  /// **'Iniciar Sesión'**
  String get login;

  /// Etiqueta para la URL del servidor
  ///
  /// In es, this message translates to:
  /// **'URL del Servidor'**
  String get serverUrl;

  /// Etiqueta para nombre de usuario
  ///
  /// In es, this message translates to:
  /// **'Usuario'**
  String get username;

  /// Etiqueta para contraseña
  ///
  /// In es, this message translates to:
  /// **'Contraseña'**
  String get password;

  /// Etiqueta para puerto
  ///
  /// In es, this message translates to:
  /// **'Puerto'**
  String get port;

  /// Etiqueta para nombre personalizado de conexión
  ///
  /// In es, this message translates to:
  /// **'Nombre de la Conexión'**
  String get connectionName;

  /// Botón para agregar nuevo servidor
  ///
  /// In es, this message translates to:
  /// **'Agregar Servidor'**
  String get addServer;

  /// Sección de canales en vivo
  ///
  /// In es, this message translates to:
  /// **'Canales en Vivo'**
  String get liveChannels;

  /// Sección de películas
  ///
  /// In es, this message translates to:
  /// **'Películas'**
  String get movies;

  /// Sección de series
  ///
  /// In es, this message translates to:
  /// **'Series'**
  String get series;

  /// Sección de favoritos
  ///
  /// In es, this message translates to:
  /// **'Favoritos'**
  String get favorites;

  /// Función de búsqueda
  ///
  /// In es, this message translates to:
  /// **'Buscar'**
  String get search;

  /// Página de configuración
  ///
  /// In es, this message translates to:
  /// **'Configuración'**
  String get settings;

  /// Perfil de usuario
  ///
  /// In es, this message translates to:
  /// **'Perfil'**
  String get profile;

  /// Historial de reproducción
  ///
  /// In es, this message translates to:
  /// **'Historial'**
  String get history;

  /// Lista de contenido para continuar viendo
  ///
  /// In es, this message translates to:
  /// **'Continuar Viendo'**
  String get continueWatching;

  /// Lista de categorías
  ///
  /// In es, this message translates to:
  /// **'Categorías'**
  String get categories;

  /// Guía electrónica de programación
  ///
  /// In es, this message translates to:
  /// **'Guía de Programación'**
  String get epg;

  /// Programa actualmente en reproducción
  ///
  /// In es, this message translates to:
  /// **'Reproduciendo Ahora'**
  String get nowPlaying;

  /// Próximo programa
  ///
  /// In es, this message translates to:
  /// **'A Continuación'**
  String get nextUp;

  /// Error de credenciales incorrectas
  ///
  /// In es, this message translates to:
  /// **'Credenciales inválidas'**
  String get invalidCredentials;

  /// Error al conectar con el servidor
  ///
  /// In es, this message translates to:
  /// **'Error de conexión'**
  String get connectionError;

  /// Botón de reintentar
  ///
  /// In es, this message translates to:
  /// **'Reintentar'**
  String get retry;

  /// Botón de cancelar
  ///
  /// In es, this message translates to:
  /// **'Cancelar'**
  String get cancel;

  /// Botón de guardar
  ///
  /// In es, this message translates to:
  /// **'Guardar'**
  String get save;

  /// Botón de eliminar
  ///
  /// In es, this message translates to:
  /// **'Eliminar'**
  String get delete;

  /// Botón de editar
  ///
  /// In es, this message translates to:
  /// **'Editar'**
  String get edit;

  /// Configuración de control parental
  ///
  /// In es, this message translates to:
  /// **'Control Parental'**
  String get parentalControl;

  /// Solicitud de ingreso de PIN
  ///
  /// In es, this message translates to:
  /// **'Ingrese PIN'**
  String get enterPin;

  /// Crear nuevo PIN
  ///
  /// In es, this message translates to:
  /// **'Crear PIN'**
  String get createPin;

  /// Configuración de calidad de video
  ///
  /// In es, this message translates to:
  /// **'Calidad'**
  String get quality;

  /// Configuración de subtítulos
  ///
  /// In es, this message translates to:
  /// **'Subtítulos'**
  String get subtitles;

  /// Selección de pista de audio
  ///
  /// In es, this message translates to:
  /// **'Pista de Audio'**
  String get audioTrack;
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) =>
      <String>['es'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'es':
      return AppLocalizationsEs();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.',
  );
}
