import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_en.dart';
import 'app_localizations_it.dart';

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
  static const List<Locale> supportedLocales = <Locale>[
    Locale('en'),
    Locale('it')
  ];

  /// Nome dell'applicazione
  ///
  /// In it, this message translates to:
  /// **'Piantala'**
  String get appName;

  /// Sottotitolo nella schermata di login
  ///
  /// In it, this message translates to:
  /// **'Il tuo giardino tascabile'**
  String get appTagline;

  /// Avviso ToS nella login
  ///
  /// In it, this message translates to:
  /// **'Accedendo accetti i Termini di servizio'**
  String get appTosNotice;

  /// No description provided for @authSignInWithGoogle.
  ///
  /// In it, this message translates to:
  /// **'Continua con Google'**
  String get authSignInWithGoogle;

  /// No description provided for @authSignInWithEmail.
  ///
  /// In it, this message translates to:
  /// **'Accedi con email'**
  String get authSignInWithEmail;

  /// No description provided for @authSheetTitleLogin.
  ///
  /// In it, this message translates to:
  /// **'Accedi con email'**
  String get authSheetTitleLogin;

  /// No description provided for @authSheetTitleRegister.
  ///
  /// In it, this message translates to:
  /// **'Crea account'**
  String get authSheetTitleRegister;

  /// No description provided for @authSheetTitleReset.
  ///
  /// In it, this message translates to:
  /// **'Recupera password'**
  String get authSheetTitleReset;

  /// No description provided for @authSheetSubtitleReset.
  ///
  /// In it, this message translates to:
  /// **'Inserisci la tua email. Se è associata a un account, riceverai le istruzioni.'**
  String get authSheetSubtitleReset;

  /// No description provided for @authSheetSubtitleLogin.
  ///
  /// In it, this message translates to:
  /// **'Usa un indirizzo email valido e una password sicura.'**
  String get authSheetSubtitleLogin;

  /// No description provided for @authFieldName.
  ///
  /// In it, this message translates to:
  /// **'Nome'**
  String get authFieldName;

  /// No description provided for @authFieldEmail.
  ///
  /// In it, this message translates to:
  /// **'Email'**
  String get authFieldEmail;

  /// No description provided for @authFieldPassword.
  ///
  /// In it, this message translates to:
  /// **'Password'**
  String get authFieldPassword;

  /// No description provided for @authFieldConfirmPassword.
  ///
  /// In it, this message translates to:
  /// **'Conferma password'**
  String get authFieldConfirmPassword;

  /// No description provided for @authButtonLogin.
  ///
  /// In it, this message translates to:
  /// **'Accedi'**
  String get authButtonLogin;

  /// No description provided for @authButtonRegister.
  ///
  /// In it, this message translates to:
  /// **'Crea account'**
  String get authButtonRegister;

  /// No description provided for @authButtonSendReset.
  ///
  /// In it, this message translates to:
  /// **'Invia istruzioni'**
  String get authButtonSendReset;

  /// No description provided for @authButtonForgotPassword.
  ///
  /// In it, this message translates to:
  /// **'Password dimenticata?'**
  String get authButtonForgotPassword;

  /// No description provided for @authButtonGoToRegister.
  ///
  /// In it, this message translates to:
  /// **'Non hai un account? Registrati'**
  String get authButtonGoToRegister;

  /// No description provided for @authButtonGoToLogin.
  ///
  /// In it, this message translates to:
  /// **'Hai già un account? Accedi'**
  String get authButtonGoToLogin;

  /// No description provided for @authButtonBackToLogin.
  ///
  /// In it, this message translates to:
  /// **'Torna all\'accesso'**
  String get authButtonBackToLogin;

  /// No description provided for @authValidationNameEmpty.
  ///
  /// In it, this message translates to:
  /// **'Inserisci il tuo nome'**
  String get authValidationNameEmpty;

  /// No description provided for @authValidationEmailInvalid.
  ///
  /// In it, this message translates to:
  /// **'Inserisci un indirizzo email valido'**
  String get authValidationEmailInvalid;

  /// No description provided for @authValidationPasswordTooShort.
  ///
  /// In it, this message translates to:
  /// **'Usa almeno 6 caratteri'**
  String get authValidationPasswordTooShort;

  /// No description provided for @authValidationPasswordMismatch.
  ///
  /// In it, this message translates to:
  /// **'Le password non coincidono'**
  String get authValidationPasswordMismatch;

  /// No description provided for @authResetEmailSent.
  ///
  /// In it, this message translates to:
  /// **'Se l\'indirizzo è associata a un account, riceverai le istruzioni.'**
  String get authResetEmailSent;

  /// No description provided for @homeEmptyShelfTitle.
  ///
  /// In it, this message translates to:
  /// **'La tua mensola è vuota'**
  String get homeEmptyShelfTitle;

  /// No description provided for @homeEmptyShelfSubtitle.
  ///
  /// In it, this message translates to:
  /// **'Aggiungi la tua prima pianta\ncon il bottone +'**
  String get homeEmptyShelfSubtitle;

  /// No description provided for @homeEmptyRoomTitle.
  ///
  /// In it, this message translates to:
  /// **'{roomName} è vuota'**
  String homeEmptyRoomTitle(String roomName);

  /// No description provided for @homeEmptyRoomSubtitle.
  ///
  /// In it, this message translates to:
  /// **'Aggiungi una pianta e assegnala\na questa stanza'**
  String get homeEmptyRoomSubtitle;

  /// No description provided for @homeButtonAddPlant.
  ///
  /// In it, this message translates to:
  /// **'Aggiungi pianta'**
  String get homeButtonAddPlant;

  /// No description provided for @homeLabelUnassigned.
  ///
  /// In it, this message translates to:
  /// **'Senza stanza'**
  String get homeLabelUnassigned;

  /// No description provided for @homeLabelAllPlants.
  ///
  /// In it, this message translates to:
  /// **'Tutte le piante'**
  String get homeLabelAllPlants;

  /// No description provided for @homeTooltipLogout.
  ///
  /// In it, this message translates to:
  /// **'Logout'**
  String get homeTooltipLogout;

  /// No description provided for @homeRoomMeta.
  ///
  /// In it, this message translates to:
  /// **'{count, plural, one{1 pianta} other{{count} piante}} · Esposizione {exposure}'**
  String homeRoomMeta(int count, String exposure);

  /// No description provided for @homeRoomPageSemantics.
  ///
  /// In it, this message translates to:
  /// **'Stanza {current} di {total}'**
  String homeRoomPageSemantics(int current, int total);

  /// No description provided for @homeWindowAccessibility.
  ///
  /// In it, this message translates to:
  /// **'Indicatore del momento della giornata'**
  String get homeWindowAccessibility;

  /// No description provided for @homePlantNameFallback.
  ///
  /// In it, this message translates to:
  /// **'Pianta'**
  String get homePlantNameFallback;

  /// No description provided for @homeCareWateringSemantics.
  ///
  /// In it, this message translates to:
  /// **'Da annaffiare'**
  String get homeCareWateringSemantics;

  /// No description provided for @homeCareFertilizingSemantics.
  ///
  /// In it, this message translates to:
  /// **'Da concimare'**
  String get homeCareFertilizingSemantics;

  /// No description provided for @homeErrorLoading.
  ///
  /// In it, this message translates to:
  /// **'Errore: {error}'**
  String homeErrorLoading(Object error);

  /// No description provided for @greetingNight.
  ///
  /// In it, this message translates to:
  /// **'Buonanotte'**
  String get greetingNight;

  /// No description provided for @greetingDawn.
  ///
  /// In it, this message translates to:
  /// **'Buongiorno'**
  String get greetingDawn;

  /// No description provided for @greetingDay.
  ///
  /// In it, this message translates to:
  /// **'Ciao'**
  String get greetingDay;

  /// No description provided for @greetingDusk.
  ///
  /// In it, this message translates to:
  /// **'Buon pomeriggio'**
  String get greetingDusk;

  /// No description provided for @greetingEvening.
  ///
  /// In it, this message translates to:
  /// **'Buonasera'**
  String get greetingEvening;

  /// No description provided for @greetingSubtitleNight.
  ///
  /// In it, this message translates to:
  /// **'Anche di notte le tue piante crescono 🌙'**
  String get greetingSubtitleNight;

  /// No description provided for @greetingSubtitleDawn.
  ///
  /// In it, this message translates to:
  /// **'Buon inizio giornata con le tue piante'**
  String get greetingSubtitleDawn;

  /// No description provided for @greetingSubtitleDay.
  ///
  /// In it, this message translates to:
  /// **'Come stanno le tue piante oggi?'**
  String get greetingSubtitleDay;

  /// No description provided for @greetingSubtitleDusk.
  ///
  /// In it, this message translates to:
  /// **'Ottimo momento per controllare le tue piante'**
  String get greetingSubtitleDusk;

  /// No description provided for @greetingSubtitleEvening.
  ///
  /// In it, this message translates to:
  /// **'Pianifica la cura di domani'**
  String get greetingSubtitleEvening;

  /// No description provided for @roomsEmptyTitle.
  ///
  /// In it, this message translates to:
  /// **'Nessuna stanza creata.'**
  String get roomsEmptyTitle;

  /// No description provided for @roomsEmptyHint.
  ///
  /// In it, this message translates to:
  /// **'Tocca \"nuova stanza\" per cominciare.'**
  String get roomsEmptyHint;

  /// No description provided for @roomsOptionsSemantics.
  ///
  /// In it, this message translates to:
  /// **'Opzioni stanza {roomName}'**
  String roomsOptionsSemantics(String roomName);

  /// No description provided for @roomsExposure.
  ///
  /// In it, this message translates to:
  /// **'Esposizione: {exposure}'**
  String roomsExposure(String exposure);

  /// No description provided for @roomsPlants.
  ///
  /// In it, this message translates to:
  /// **'Piante: {count}'**
  String roomsPlants(int count);

  /// No description provided for @roomsDeleteDialogTitle.
  ///
  /// In it, this message translates to:
  /// **'Elimina Stanza'**
  String get roomsDeleteDialogTitle;

  /// No description provided for @roomsDeleteWarning.
  ///
  /// In it, this message translates to:
  /// **'Questa stanza contiene {count} piante! Eliminandola, le piante diventeranno \"Senza Stanza\". Vuoi procedere?'**
  String roomsDeleteWarning(int count);

  /// No description provided for @roomsDeleteConfirm.
  ///
  /// In it, this message translates to:
  /// **'Sei sicuro di voler eliminare la stanza \"{roomName}\"?'**
  String roomsDeleteConfirm(String roomName);

  /// No description provided for @roomDialogNewTitle.
  ///
  /// In it, this message translates to:
  /// **'Nuova stanza'**
  String get roomDialogNewTitle;

  /// No description provided for @roomDialogEditTitle.
  ///
  /// In it, this message translates to:
  /// **'Modifica stanza'**
  String get roomDialogEditTitle;

  /// No description provided for @roomDialogNameLabel.
  ///
  /// In it, this message translates to:
  /// **'Nome della stanza'**
  String get roomDialogNameLabel;

  /// No description provided for @roomDialogNameValidation.
  ///
  /// In it, this message translates to:
  /// **'Inserisci un nome'**
  String get roomDialogNameValidation;

  /// No description provided for @roomDialogNameHint.
  ///
  /// In it, this message translates to:
  /// **'Scrivi il nome'**
  String get roomDialogNameHint;

  /// No description provided for @roomDialogNotesLabel.
  ///
  /// In it, this message translates to:
  /// **'Note (opzionali)'**
  String get roomDialogNotesLabel;

  /// No description provided for @roomDialogNotesHint.
  ///
  /// In it, this message translates to:
  /// **'Aggiungi una nota'**
  String get roomDialogNotesHint;

  /// No description provided for @roomDialogExposureLabel.
  ///
  /// In it, this message translates to:
  /// **'Esposizione'**
  String get roomDialogExposureLabel;

  /// No description provided for @roomDialogCompassSemantics.
  ///
  /// In it, this message translates to:
  /// **'Rileva l\'esposizione con la bussola'**
  String get roomDialogCompassSemantics;

  /// No description provided for @compassTitle.
  ///
  /// In it, this message translates to:
  /// **'Rilevamento esposizione'**
  String get compassTitle;

  /// No description provided for @compassPointHint.
  ///
  /// In it, this message translates to:
  /// **'Punta verso la finestra'**
  String get compassPointHint;

  /// No description provided for @compassLocked.
  ///
  /// In it, this message translates to:
  /// **'Direzione rilevata'**
  String get compassLocked;

  /// No description provided for @compassHold.
  ///
  /// In it, this message translates to:
  /// **'Tieni fermo per: {seconds} s'**
  String compassHold(int seconds);

  /// No description provided for @compassDone.
  ///
  /// In it, this message translates to:
  /// **'Esposizione rilevata'**
  String get compassDone;

  /// No description provided for @compassRetry.
  ///
  /// In it, this message translates to:
  /// **'Riprova'**
  String get compassRetry;

  /// No description provided for @compassUnavailable.
  ///
  /// In it, this message translates to:
  /// **'Bussola non disponibile'**
  String get compassUnavailable;

  /// No description provided for @compassDialSemantics.
  ///
  /// In it, this message translates to:
  /// **'Bussola, direzione {direction}'**
  String compassDialSemantics(String direction);

  /// No description provided for @compassLetterNorth.
  ///
  /// In it, this message translates to:
  /// **'N'**
  String get compassLetterNorth;

  /// No description provided for @compassLetterEast.
  ///
  /// In it, this message translates to:
  /// **'E'**
  String get compassLetterEast;

  /// No description provided for @compassLetterSouth.
  ///
  /// In it, this message translates to:
  /// **'S'**
  String get compassLetterSouth;

  /// No description provided for @compassLetterWest.
  ///
  /// In it, this message translates to:
  /// **'O'**
  String get compassLetterWest;

  /// No description provided for @exposureNorthEast.
  ///
  /// In it, this message translates to:
  /// **'Nord-Est'**
  String get exposureNorthEast;

  /// No description provided for @exposureSouthEast.
  ///
  /// In it, this message translates to:
  /// **'Sud-Est'**
  String get exposureSouthEast;

  /// No description provided for @exposureSouthWest.
  ///
  /// In it, this message translates to:
  /// **'Sud-Ovest'**
  String get exposureSouthWest;

  /// No description provided for @exposureNorthWest.
  ///
  /// In it, this message translates to:
  /// **'Nord-Ovest'**
  String get exposureNorthWest;

  /// No description provided for @encyclopediaTitle.
  ///
  /// In it, this message translates to:
  /// **'Enciclopedia'**
  String get encyclopediaTitle;

  /// No description provided for @encyclopediaSearchHint.
  ///
  /// In it, this message translates to:
  /// **'Cerca per nome comune o scientifico...'**
  String get encyclopediaSearchHint;

  /// No description provided for @encyclopediaEmptyTitle.
  ///
  /// In it, this message translates to:
  /// **'Esplora migliaia di piante'**
  String get encyclopediaEmptyTitle;

  /// No description provided for @encyclopediaEmptySubtitle.
  ///
  /// In it, this message translates to:
  /// **'Cerca una specie per visualizzarne i dettagli'**
  String get encyclopediaEmptySubtitle;

  /// No description provided for @encyclopediaNoResults.
  ///
  /// In it, this message translates to:
  /// **'Nessuna specie trovata.'**
  String get encyclopediaNoResults;

  /// No description provided for @encyclopediaError.
  ///
  /// In it, this message translates to:
  /// **'Errore: {error}'**
  String encyclopediaError(Object error);

  /// No description provided for @settingsScreenTitle.
  ///
  /// In it, this message translates to:
  /// **'Impostazioni'**
  String get settingsScreenTitle;

  /// No description provided for @settingsLogout.
  ///
  /// In it, this message translates to:
  /// **'Esci dall\'account'**
  String get settingsLogout;

  /// No description provided for @settingsSectionGeneral.
  ///
  /// In it, this message translates to:
  /// **'Generale'**
  String get settingsSectionGeneral;

  /// No description provided for @settingsLanguageTitle.
  ///
  /// In it, this message translates to:
  /// **'Lingua'**
  String get settingsLanguageTitle;

  /// No description provided for @settingsLanguageSubtitle.
  ///
  /// In it, this message translates to:
  /// **'Scegli la lingua dell\'app'**
  String get settingsLanguageSubtitle;

  /// No description provided for @settingsLanguageItalian.
  ///
  /// In it, this message translates to:
  /// **'Italiano'**
  String get settingsLanguageItalian;

  /// No description provided for @settingsLanguageEnglish.
  ///
  /// In it, this message translates to:
  /// **'Inglese'**
  String get settingsLanguageEnglish;

  /// No description provided for @settingsSectionNotifications.
  ///
  /// In it, this message translates to:
  /// **'Notifiche'**
  String get settingsSectionNotifications;

  /// No description provided for @settingsSectionAbout.
  ///
  /// In it, this message translates to:
  /// **'Informazioni'**
  String get settingsSectionAbout;

  /// No description provided for @settingsNotifPermissionTitle.
  ///
  /// In it, this message translates to:
  /// **'Permesso Notifiche'**
  String get settingsNotifPermissionTitle;

  /// No description provided for @settingsNotifPermissionSubtitle.
  ///
  /// In it, this message translates to:
  /// **'Concedi il permesso per ricevere avvisi sulle piante che necessitano attenzione.'**
  String get settingsNotifPermissionSubtitle;

  /// No description provided for @settingsNotifPermissionButton.
  ///
  /// In it, this message translates to:
  /// **'Richiedi Permesso'**
  String get settingsNotifPermissionButton;

  /// No description provided for @settingsNotifPermissionGranted.
  ///
  /// In it, this message translates to:
  /// **'✅ Permesso concesso!'**
  String get settingsNotifPermissionGranted;

  /// No description provided for @settingsNotifPermissionDenied.
  ///
  /// In it, this message translates to:
  /// **'❌ Permesso negato.'**
  String get settingsNotifPermissionDenied;

  /// No description provided for @settingsReminderTitle.
  ///
  /// In it, this message translates to:
  /// **'Orario promemoria mattutino'**
  String get settingsReminderTitle;

  /// No description provided for @settingsReminderSubtitle.
  ///
  /// In it, this message translates to:
  /// **'Ogni mattina alle {time}'**
  String settingsReminderSubtitle(String time);

  /// No description provided for @settingsReminderUpdated.
  ///
  /// In it, this message translates to:
  /// **'⏰ Promemoria aggiornato: {time}'**
  String settingsReminderUpdated(String time);

  /// No description provided for @settingsReminderPickerHelpText.
  ///
  /// In it, this message translates to:
  /// **'Scegli orario promemoria'**
  String get settingsReminderPickerHelpText;

  /// No description provided for @settingsAboutVersion.
  ///
  /// In it, this message translates to:
  /// **'Versione'**
  String get settingsAboutVersion;

  /// No description provided for @settingsAboutVersionNumber.
  ///
  /// In it, this message translates to:
  /// **'0.1.0'**
  String get settingsAboutVersionNumber;

  /// No description provided for @settingsAboutDataSource.
  ///
  /// In it, this message translates to:
  /// **'Dati specie'**
  String get settingsAboutDataSource;

  /// No description provided for @settingsAboutDataSourceSubtitle.
  ///
  /// In it, this message translates to:
  /// **'Forniti da Perenual API (piano gratuito)'**
  String get settingsAboutDataSourceSubtitle;

  /// No description provided for @navHome.
  ///
  /// In it, this message translates to:
  /// **'Mensola'**
  String get navHome;

  /// No description provided for @navRooms.
  ///
  /// In it, this message translates to:
  /// **'Stanze'**
  String get navRooms;

  /// No description provided for @navEncyclopedia.
  ///
  /// In it, this message translates to:
  /// **'Enciclopedia'**
  String get navEncyclopedia;

  /// No description provided for @navSettings.
  ///
  /// In it, this message translates to:
  /// **'Impostazioni'**
  String get navSettings;

  /// No description provided for @navProfile.
  ///
  /// In it, this message translates to:
  /// **'Profilo'**
  String get navProfile;

  /// No description provided for @navNewPlant.
  ///
  /// In it, this message translates to:
  /// **'nuova pianta'**
  String get navNewPlant;

  /// No description provided for @navNewRoom.
  ///
  /// In it, this message translates to:
  /// **'nuova stanza'**
  String get navNewRoom;

  /// No description provided for @errPageNotFound.
  ///
  /// In it, this message translates to:
  /// **'Pagina non trovata'**
  String get errPageNotFound;

  /// No description provided for @errPageNotFoundBody.
  ///
  /// In it, this message translates to:
  /// **'Oops, questa pagina non esiste'**
  String get errPageNotFoundBody;

  /// No description provided for @errNetworkUnavailable.
  ///
  /// In it, this message translates to:
  /// **'Nessuna connessione disponibile. I dati saranno sincronizzati al ritorno online.'**
  String get errNetworkUnavailable;

  /// No description provided for @commonButtonConfirm.
  ///
  /// In it, this message translates to:
  /// **'Conferma'**
  String get commonButtonConfirm;

  /// No description provided for @commonButtonClose.
  ///
  /// In it, this message translates to:
  /// **'Chiudi'**
  String get commonButtonClose;

  /// No description provided for @commonButtonRetry.
  ///
  /// In it, this message translates to:
  /// **'Riprova'**
  String get commonButtonRetry;

  /// No description provided for @commonButtonAdd.
  ///
  /// In it, this message translates to:
  /// **'Aggiungi'**
  String get commonButtonAdd;

  /// No description provided for @commonEdit.
  ///
  /// In it, this message translates to:
  /// **'Modifica'**
  String get commonEdit;

  /// No description provided for @commonDelete.
  ///
  /// In it, this message translates to:
  /// **'Elimina'**
  String get commonDelete;

  /// No description provided for @commonCancel.
  ///
  /// In it, this message translates to:
  /// **'Annulla'**
  String get commonCancel;

  /// No description provided for @commonSave.
  ///
  /// In it, this message translates to:
  /// **'Salva'**
  String get commonSave;

  /// No description provided for @commonUnknown.
  ///
  /// In it, this message translates to:
  /// **'Sconosciuto'**
  String get commonUnknown;

  /// No description provided for @commonLoading.
  ///
  /// In it, this message translates to:
  /// **'Caricamento...'**
  String get commonLoading;

  /// No description provided for @exposureNorth.
  ///
  /// In it, this message translates to:
  /// **'Nord'**
  String get exposureNorth;

  /// No description provided for @exposureSouth.
  ///
  /// In it, this message translates to:
  /// **'Sud'**
  String get exposureSouth;

  /// No description provided for @exposureEast.
  ///
  /// In it, this message translates to:
  /// **'Est'**
  String get exposureEast;

  /// No description provided for @exposureWest.
  ///
  /// In it, this message translates to:
  /// **'Ovest'**
  String get exposureWest;

  /// No description provided for @exposureUnknown.
  ///
  /// In it, this message translates to:
  /// **'Sconosciuta'**
  String get exposureUnknown;
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
      <String>['en', 'it'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'en':
      return AppLocalizationsEn();
    case 'it':
      return AppLocalizationsIt();
  }

  throw FlutterError(
      'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
      'an issue with the localizations generation tool. Please file an issue '
      'on GitHub with a reproducible sample app and the gen-l10n configuration '
      'that was used.');
}
