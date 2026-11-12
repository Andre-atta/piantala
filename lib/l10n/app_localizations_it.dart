// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Italian (`it`).
class AppLocalizationsIt extends AppLocalizations {
  AppLocalizationsIt([String locale = 'it']) : super(locale);

  @override
  String get appName => 'Piantala';

  @override
  String get appTagline => 'Il tuo giardino tascabile';

  @override
  String get loginTagline => 'Le tue piante, una mensola alla volta.';

  @override
  String get loginPrivacyNotice => 'Continuando accetti';

  @override
  String get loginPrivacyLink => 'l\'Informativa sulla privacy';

  @override
  String get loginPrivacyOpenError =>
      'Impossibile aprire l\'informativa sulla privacy.';

  @override
  String get appTosNotice => 'Accedendo accetti i Termini di servizio';

  @override
  String get authSignInWithGoogle => 'Continua con Google';

  @override
  String get authSignInWithEmail => 'Accedi con email';

  @override
  String get authSheetTitleLogin => 'Accedi con email';

  @override
  String get authSheetTitleRegister => 'Crea account';

  @override
  String get authSheetTitleReset => 'Recupera password';

  @override
  String get authSheetSubtitleReset =>
      'Inserisci la tua email. Se è associata a un account, riceverai le istruzioni.';

  @override
  String get authSheetSubtitleLogin =>
      'Usa un indirizzo email valido e una password sicura.';

  @override
  String get authFieldName => 'Nome';

  @override
  String get authFieldEmail => 'Email';

  @override
  String get authFieldPassword => 'Password';

  @override
  String get authFieldConfirmPassword => 'Conferma password';

  @override
  String get authButtonLogin => 'Accedi';

  @override
  String get authButtonRegister => 'Crea account';

  @override
  String get authButtonSendReset => 'Invia istruzioni';

  @override
  String get authButtonForgotPassword => 'Password dimenticata?';

  @override
  String get authButtonGoToRegister => 'Non hai un account? Registrati';

  @override
  String get authButtonGoToLogin => 'Hai già un account? Accedi';

  @override
  String get authButtonBackToLogin => 'Torna all\'accesso';

  @override
  String get authValidationNameEmpty => 'Inserisci il tuo nome';

  @override
  String get authValidationEmailInvalid =>
      'Inserisci un indirizzo email valido';

  @override
  String get authValidationPasswordTooShort => 'Usa almeno 6 caratteri';

  @override
  String get authValidationPasswordMismatch => 'Le password non coincidono';

  @override
  String get paperTextFieldShowPassword => 'Mostra password';

  @override
  String get paperTextFieldHidePassword => 'Nascondi password';

  @override
  String get authResetEmailSent =>
      'Se l\'indirizzo è associata a un account, riceverai le istruzioni.';

  @override
  String get homeEmptyShelfTitle => 'La tua mensola è vuota';

  @override
  String get homeEmptyShelfSubtitle =>
      'Aggiungi la tua prima pianta\ncon il bottone +';

  @override
  String homeEmptyRoomTitle(String roomName) {
    return '$roomName è vuota';
  }

  @override
  String get homeEmptyRoomSubtitle =>
      'Aggiungi una pianta e assegnala\na questa stanza';

  @override
  String get homeButtonAddPlant => 'Aggiungi pianta';

  @override
  String get homeLabelUnassigned => 'Senza stanza';

  @override
  String get homeLabelAllPlants => 'Tutte le piante';

  @override
  String get homeTooltipLogout => 'Logout';

  @override
  String homeRoomMeta(int count, String exposure) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count piante',
      one: '1 pianta',
    );
    return '$_temp0 · Esposizione $exposure';
  }

  @override
  String homeRoomPageSemantics(int current, int total) {
    return 'Stanza $current di $total';
  }

  @override
  String get homeWindowAccessibility => 'Indicatore del momento della giornata';

  @override
  String get homePlantNameFallback => 'Pianta';

  @override
  String get homeCareWateringSemantics => 'Da annaffiare';

  @override
  String get homeCareFertilizingSemantics => 'Da concimare';

  @override
  String homeErrorLoading(Object error) {
    return 'Errore: $error';
  }

  @override
  String get greetingNight => 'Buonanotte';

  @override
  String get greetingDawn => 'Buongiorno';

  @override
  String get greetingDay => 'Ciao';

  @override
  String get greetingDusk => 'Buon pomeriggio';

  @override
  String get greetingEvening => 'Buonasera';

  @override
  String get greetingSubtitleNight =>
      'Anche di notte le tue piante crescono 🌙';

  @override
  String get greetingSubtitleDawn => 'Buon inizio giornata con le tue piante';

  @override
  String get greetingSubtitleDay => 'Come stanno le tue piante oggi?';

  @override
  String get greetingSubtitleDusk =>
      'Ottimo momento per controllare le tue piante';

  @override
  String get greetingSubtitleEvening => 'Pianifica la cura di domani';

  @override
  String get roomsEmptyTitle => 'Nessuna stanza creata.';

  @override
  String get roomsEmptyHint => 'Tocca \"nuova stanza\" per cominciare.';

  @override
  String roomsOptionsSemantics(String roomName) {
    return 'Opzioni stanza $roomName';
  }

  @override
  String roomsExposure(String exposure) {
    return 'Esposizione: $exposure';
  }

  @override
  String roomsPlants(int count) {
    return 'Piante: $count';
  }

  @override
  String get roomsDeleteDialogTitle => 'Elimina Stanza';

  @override
  String roomsDeleteWarning(int count) {
    return 'Questa stanza contiene $count piante! Eliminandola, le piante diventeranno \"Senza Stanza\". Vuoi procedere?';
  }

  @override
  String roomsDeleteConfirm(String roomName) {
    return 'Sei sicuro di voler eliminare la stanza \"$roomName\"?';
  }

  @override
  String get roomDialogNewTitle => 'Nuova stanza';

  @override
  String get roomDialogEditTitle => 'Modifica stanza';

  @override
  String get roomDialogNameLabel => 'Nome della stanza';

  @override
  String get roomDialogNameValidation => 'Inserisci un nome';

  @override
  String get roomDialogNameHint => 'Scrivi il nome';

  @override
  String get roomDialogNotesLabel => 'Note (opzionali)';

  @override
  String get roomDialogNotesHint => 'Aggiungi una nota';

  @override
  String get roomDialogExposureLabel => 'Esposizione';

  @override
  String get roomDialogCompassSemantics =>
      'Rileva l\'esposizione con la bussola';

  @override
  String get compassTitle => 'Rilevamento esposizione';

  @override
  String get compassPointHint => 'Punta verso la finestra';

  @override
  String get compassLocked => 'Direzione rilevata';

  @override
  String compassHold(int seconds) {
    return 'Tieni fermo per: $seconds s';
  }

  @override
  String get compassDone => 'Esposizione rilevata';

  @override
  String get compassRetry => 'Riprova';

  @override
  String get compassUnavailable => 'Bussola non disponibile';

  @override
  String compassDialSemantics(String direction) {
    return 'Bussola, direzione $direction';
  }

  @override
  String get compassLetterNorth => 'N';

  @override
  String get compassLetterEast => 'E';

  @override
  String get compassLetterSouth => 'S';

  @override
  String get compassLetterWest => 'O';

  @override
  String get exposureNorthEast => 'Nord-Est';

  @override
  String get exposureSouthEast => 'Sud-Est';

  @override
  String get exposureSouthWest => 'Sud-Ovest';

  @override
  String get exposureNorthWest => 'Nord-Ovest';

  @override
  String get encyclopediaTitle => 'Enciclopedia';

  @override
  String get encyclopediaSearchHint => 'Cerca per nome comune o scientifico...';

  @override
  String get encyclopediaEmptyTitle => 'Esplora migliaia di piante';

  @override
  String get encyclopediaEmptySubtitle =>
      'Cerca una specie per visualizzarne i dettagli';

  @override
  String get encyclopediaNoResults => 'Nessuna specie trovata.';

  @override
  String encyclopediaError(Object error) {
    return 'Errore: $error';
  }

  @override
  String get settingsScreenTitle => 'Impostazioni';

  @override
  String get settingsLogout => 'Esci dall\'account';

  @override
  String get settingsSectionGeneral => 'Generale';

  @override
  String get settingsLanguageTitle => 'Lingua';

  @override
  String get settingsLanguageSubtitle => 'Scegli la lingua dell\'app';

  @override
  String get settingsLanguageItalian => 'Italiano';

  @override
  String get settingsLanguageEnglish => 'Inglese';

  @override
  String get settingsSectionNotifications => 'Notifiche';

  @override
  String get settingsSectionAbout => 'Informazioni';

  @override
  String get settingsNotifPermissionTitle => 'Permesso Notifiche';

  @override
  String get settingsNotifPermissionSubtitle =>
      'Concedi il permesso per ricevere avvisi sulle piante che necessitano attenzione.';

  @override
  String get settingsNotifPermissionButton => 'Richiedi Permesso';

  @override
  String get settingsNotifPermissionGranted => '✅ Permesso concesso!';

  @override
  String get settingsNotifPermissionDenied => '❌ Permesso negato.';

  @override
  String get settingsReminderTitle => 'Orario promemoria mattutino';

  @override
  String settingsReminderSubtitle(String time) {
    return 'Ogni mattina alle $time';
  }

  @override
  String settingsReminderUpdated(String time) {
    return '⏰ Promemoria aggiornato: $time';
  }

  @override
  String get settingsReminderPickerHelpText => 'Scegli orario promemoria';

  @override
  String get settingsAboutVersion => 'Versione';

  @override
  String get settingsAboutVersionNumber => '0.1.0';

  @override
  String get settingsAboutDataSource => 'Dati specie';

  @override
  String get settingsAboutDataSourceSubtitle =>
      'Forniti da Perenual API (piano gratuito)';

  @override
  String get navHome => 'Mensola';

  @override
  String get navRooms => 'Stanze';

  @override
  String get navEncyclopedia => 'Enciclopedia';

  @override
  String get navSettings => 'Impostazioni';

  @override
  String get navProfile => 'Profilo';

  @override
  String get navNewPlant => 'nuova pianta';

  @override
  String get navNewRoom => 'nuova stanza';

  @override
  String get errPageNotFound => 'Pagina non trovata';

  @override
  String get errPageNotFoundBody => 'Oops, questa pagina non esiste';

  @override
  String get errNetworkUnavailable =>
      'Nessuna connessione disponibile. I dati saranno sincronizzati al ritorno online.';

  @override
  String get commonButtonConfirm => 'Conferma';

  @override
  String get commonButtonClose => 'Chiudi';

  @override
  String get commonButtonRetry => 'Riprova';

  @override
  String get commonButtonAdd => 'Aggiungi';

  @override
  String get commonEdit => 'Modifica';

  @override
  String get commonDelete => 'Elimina';

  @override
  String get commonCancel => 'Annulla';

  @override
  String get commonSave => 'Salva';

  @override
  String get commonUnknown => 'Sconosciuto';

  @override
  String get commonLoading => 'Caricamento...';

  @override
  String get exposureNorth => 'Nord';

  @override
  String get exposureSouth => 'Sud';

  @override
  String get exposureEast => 'Est';

  @override
  String get exposureWest => 'Ovest';

  @override
  String get exposureUnknown => 'Sconosciuta';
}
