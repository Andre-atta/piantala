/// Tutte le stringhe UI e messaggi di errore di Piantala.
///
/// REGOLA: nessun widget o repository usa stringhe letterali hardcoded.
/// Usare sempre queste costanti in vista della futura localizzazione via .arb.
///
/// Le costanti sono suddivise per dominio:
///   - [AppAuthStrings]         — Brand, autenticazione, registrazione, errori auth
///   - [AppHomeStrings]         — Home screen, mensola, stanze vuote
///   - [AppGreetingStrings]     — Saluti temporali e sottotitoli contestuali
///   - [AppPlantStrings]        — Dettaglio pianta, aggiunta, cura, configurazione
///   - [AppRoomsStrings]        — Gestione e orientamento stanze
///   - [AppEncyclopediaStrings] — Ricerca e catalogo enciclopedia
///   - [AppSettingsStrings]     — Impostazioni, notifiche, info app
///   - [AppNavStrings]          — Label navigazione e routing
///   - [AppErrorsStrings]       — Errori generici di rete/database/pagine
///   - [AppCommonStrings]       — Azioni comuni (salva, chiudi, conferma)
abstract final class AppStrings {
  // Brand
  static const appName = AppAuthStrings.appName;
  static const tagline = AppAuthStrings.tagline;
  static const tosNotice = AppAuthStrings.tosNotice;

  // Namespace runtime access
  static const auth = AppAuthNamespace();
  static const home = AppHomeNamespace();
  static const greeting = AppGreetingNamespace();
  static const plant = AppPlantNamespace();
  static const rooms = AppRoomsNamespace();
  static const encyclopedia = AppEncyclopediaNamespace();
  static const settings = AppSettingsNamespace();
  static const nav = AppNavNamespace();
  static const errors = AppErrorsNamespace();
  static const common = AppCommonNamespace();
}

// ── Auth ──────────────────────────────────────────────────────────────────

abstract final class AppAuthStrings {
  // Brand
  static const appName = 'Piantala';
  static const tagline = 'Il tuo giardino tascabile';
  static const tosNotice = 'Accedendo accetti i Termini di servizio';

  // Bottoni accesso
  static const signInWithGoogle = 'Continua con Google';
  static const signInWithEmail = 'Accedi con email';

  // Bottom sheet email
  static const sheetTitleLogin = 'Accedi con email';
  static const sheetTitleRegister = 'Crea account';
  static const sheetTitleReset = 'Recupera password';

  static const sheetSubtitleReset =
      'Inserisci la tua email. Se è associata a un account, '
      'riceverai le istruzioni.';
  static const sheetSubtitleLogin =
      'Usa un indirizzo email valido e una password sicura.';

  // Label campi
  static const fieldName = 'Nome';
  static const fieldEmail = 'Email';
  static const fieldPassword = 'Password';
  static const fieldConfirmPassword = 'Conferma password';

  // Bottoni submit
  static const buttonLogin = 'Accedi';
  static const buttonRegister = 'Crea account';
  static const buttonSendReset = 'Invia istruzioni';
  static const buttonForgotPassword = 'Password dimenticata?';
  static const buttonGoToRegister = 'Non hai un account? Registrati';
  static const buttonGoToLogin = 'Hai già un account? Accedi';
  static const buttonBackToLogin = "Torna all'accesso";

  // Validazioni form
  static const validationNameEmpty = 'Inserisci il tuo nome';
  static const validationEmailInvalid = 'Inserisci un indirizzo email valido';
  static const validationPasswordTooShort = 'Usa almeno 6 caratteri';
  static const validationPasswordMismatch = 'Le password non coincidono';

  // Messaggi post-azione
  static const resetEmailSent =
      "Se l'indirizzo è associato a un account, riceverai le istruzioni.";

  // Errori repository (da AuthException)
  static const errInvalidCredential = 'Email o password non validi.';
  static const errInvalidEmail = 'Inserisci un indirizzo email valido.';
  static const errWeakPassword =
      'Scegli una password più sicura, di almeno 6 caratteri.';
  static const errEmailInUse =
      'Non è possibile completare la registrazione con questi dati.';
  static const errUserDisabled =
      'Non è possibile accedere con questo account.';
  static const errTooManyRequests = 'Troppi tentativi. Riprova più tardi.';
  static const errNetworkFailed =
      'Connessione assente o instabile. Riprova.';
  static const errEmailProviderDisabledReg =
      'La registrazione con email non è attualmente disponibile.';
  static const errEmailProviderDisabledLogin =
      "L'accesso con email non è attualmente disponibile.";
  static const errRegistrationFallback =
      'Registrazione non disponibile. Riprova più tardi.';
  static const errLoginFallback =
      'Accesso non disponibile. Riprova più tardi.';
  static const errGoogleSignIn =
      'Accesso con Google non disponibile. Riprova più tardi.';
  static const errGoogleSignInNetwork =
      'Connessione assente o instabile. Riprova.';
  static const errAuthFallback =
      'Autenticazione non disponibile. Riprova più tardi.';
  static const errLogout = 'Logout non disponibile. Riprova più tardi.';
  static const errEmailRequired = 'Inserisci email e password.';
  static const errAllFieldsRequired = 'Inserisci nome, email e password.';
  static const errEmailRequiredForReset =
      'Inserisci un indirizzo email valido.';
  static const errUserNotFound =
      'Utente non trovato. Prova a effettuare nuovamente il login.';
}

class AppAuthNamespace {
  const AppAuthNamespace();
  String get appName => AppAuthStrings.appName;
  String get tagline => AppAuthStrings.tagline;
  String get tosNotice => AppAuthStrings.tosNotice;
  String get signInWithGoogle => AppAuthStrings.signInWithGoogle;
  String get signInWithEmail => AppAuthStrings.signInWithEmail;
  String get sheetTitleLogin => AppAuthStrings.sheetTitleLogin;
  String get sheetTitleRegister => AppAuthStrings.sheetTitleRegister;
  String get sheetTitleReset => AppAuthStrings.sheetTitleReset;
  String get sheetSubtitleReset => AppAuthStrings.sheetSubtitleReset;
  String get sheetSubtitleLogin => AppAuthStrings.sheetSubtitleLogin;
  String get fieldName => AppAuthStrings.fieldName;
  String get fieldEmail => AppAuthStrings.fieldEmail;
  String get fieldPassword => AppAuthStrings.fieldPassword;
  String get fieldConfirmPassword => AppAuthStrings.fieldConfirmPassword;
  String get buttonLogin => AppAuthStrings.buttonLogin;
  String get buttonRegister => AppAuthStrings.buttonRegister;
  String get buttonSendReset => AppAuthStrings.buttonSendReset;
  String get buttonForgotPassword => AppAuthStrings.buttonForgotPassword;
  String get buttonGoToRegister => AppAuthStrings.buttonGoToRegister;
  String get buttonGoToLogin => AppAuthStrings.buttonGoToLogin;
  String get buttonBackToLogin => AppAuthStrings.buttonBackToLogin;
  String get validationNameEmpty => AppAuthStrings.validationNameEmpty;
  String get validationEmailInvalid => AppAuthStrings.validationEmailInvalid;
  String get validationPasswordTooShort =>
      AppAuthStrings.validationPasswordTooShort;
  String get validationPasswordMismatch =>
      AppAuthStrings.validationPasswordMismatch;
  String get resetEmailSent => AppAuthStrings.resetEmailSent;
  String get errInvalidCredential => AppAuthStrings.errInvalidCredential;
  String get errInvalidEmail => AppAuthStrings.errInvalidEmail;
  String get errWeakPassword => AppAuthStrings.errWeakPassword;
  String get errEmailInUse => AppAuthStrings.errEmailInUse;
  String get errUserDisabled => AppAuthStrings.errUserDisabled;
  String get errTooManyRequests => AppAuthStrings.errTooManyRequests;
  String get errNetworkFailed => AppAuthStrings.errNetworkFailed;
  String get errEmailProviderDisabledReg =>
      AppAuthStrings.errEmailProviderDisabledReg;
  String get errEmailProviderDisabledLogin =>
      AppAuthStrings.errEmailProviderDisabledLogin;
  String get errRegistrationFallback => AppAuthStrings.errRegistrationFallback;
  String get errLoginFallback => AppAuthStrings.errLoginFallback;
  String get errGoogleSignIn => AppAuthStrings.errGoogleSignIn;
  String get errGoogleSignInNetwork => AppAuthStrings.errGoogleSignInNetwork;
  String get errAuthFallback => AppAuthStrings.errAuthFallback;
  String get errLogout => AppAuthStrings.errLogout;
  String get errEmailRequired => AppAuthStrings.errEmailRequired;
  String get errAllFieldsRequired => AppAuthStrings.errAllFieldsRequired;
  String get errEmailRequiredForReset => AppAuthStrings.errEmailRequiredForReset;
  String get errUserNotFound => AppAuthStrings.errUserNotFound;
}

// ── Saluti Temporali ──────────────────────────────────────────────────────

abstract final class AppGreetingStrings {
  static const night = 'Buonanotte';
  static const dawn = 'Buongiorno';
  static const day = 'Ciao';
  static const dusk = 'Buon pomeriggio';
  static const evening = 'Buonasera';

  static const subtitleNight = 'Anche di notte le tue piante crescono 🌙';
  static const subtitleDawn = 'Buon inizio giornata con le tue piante';
  static const subtitleDay = 'Come stanno le tue piante oggi?';
  static const subtitleDusk = 'Ottimo momento per controllare le tue piante';
  static const subtitleEvening = 'Pianifica la cura di domani';
}

class AppGreetingNamespace {
  const AppGreetingNamespace();
  String get night => AppGreetingStrings.night;
  String get dawn => AppGreetingStrings.dawn;
  String get day => AppGreetingStrings.day;
  String get dusk => AppGreetingStrings.dusk;
  String get evening => AppGreetingStrings.evening;

  String get subtitleNight => AppGreetingStrings.subtitleNight;
  String get subtitleDawn => AppGreetingStrings.subtitleDawn;
  String get subtitleDay => AppGreetingStrings.subtitleDay;
  String get subtitleDusk => AppGreetingStrings.subtitleDusk;
  String get subtitleEvening => AppGreetingStrings.subtitleEvening;
}

// ── Home ──────────────────────────────────────────────────────────────────

abstract final class AppHomeStrings {
  static const tooltipProfile = 'Profilo';
  static const tooltipLogout = 'Logout';

  // Placeholder mensola vuota
  static const emptyShelfTitle = 'La tua mensola è vuota';
  static const emptyShelfSubtitle =
      'Aggiungi la tua prima pianta\ncon il bottone +';

  // Placeholder stanza vuota
  static String emptyRoomTitle(String roomName) => '$roomName è vuota';
  static const emptyRoomSubtitle =
      'Aggiungi una pianta e assegnala\na questa stanza';

  // Pulsanti
  static const buttonAddPlant = 'Aggiungi pianta';

  // Sezioni dinamiche
  static const labelUnassigned = 'Senza stanza';
  static const labelAllPlants = 'Tutte le piante';

  // Errore generico lista
  static String errorLoading(Object error) => 'Errore: $error';
}

class AppHomeNamespace {
  const AppHomeNamespace();
  String get tooltipProfile => AppHomeStrings.tooltipProfile;
  String get tooltipLogout => AppHomeStrings.tooltipLogout;
  String get emptyShelfTitle => AppHomeStrings.emptyShelfTitle;
  String get emptyShelfSubtitle => AppHomeStrings.emptyShelfSubtitle;
  String emptyRoomTitle(String roomName) =>
      AppHomeStrings.emptyRoomTitle(roomName);
  String get emptyRoomSubtitle => AppHomeStrings.emptyRoomSubtitle;
  String get buttonAddPlant => AppHomeStrings.buttonAddPlant;
  String get labelUnassigned => AppHomeStrings.labelUnassigned;
  String get labelAllPlants => AppHomeStrings.labelAllPlants;
  String errorLoading(Object error) => AppHomeStrings.errorLoading(error);
}

// ── Piante ────────────────────────────────────────────────────────────────

abstract final class AppPlantStrings {
  static const screenTitleAdd = 'Aggiungi pianta';
  static const screenTitleEdit = 'Modifica pianta';
  static const screenTitleDetail = 'Dettaglio pianta';

  static const labelWatering = 'Irrigazione';
  static const labelFertilizing = 'Concimazione';
  static const labelNotes = 'Note';
  static const labelRoom = 'Stanza';
  static const labelSpecies = 'Specie';
  static const labelCustomName = 'Nome personalizzato';
  static const labelAcquisitionDate = 'Data di acquisizione';
  static const labelCultivationMethod = 'Metodo di coltivazione';
  static const labelMethodSoil = 'Terra';
  static const labelMethodWater = 'Acqua';

  static const buttonWater = 'Annaffia';
  static const buttonFertilize = 'Concima';
  static const buttonEdit = 'Modifica';
  static const buttonDelete = 'Elimina';
  static const buttonSave = 'Salva';
  static const buttonCancel = 'Annulla';

  // Messaggi
  static const confirmDeleteTitle = 'Elimina pianta';
  static const confirmDeleteBody =
      'Questa azione è irreversibile. Sei sicuro?';
  static const errNotFound = 'Pianta non trovata.';
  static const errAdd = "Errore durante l'aggiunta della pianta";
  static const errUpdate = "Errore durante l'aggiornamento della pianta";
  static const errDelete = "Errore durante l'eliminazione della pianta";
  static const errUnauthorized =
      "Operazione non autorizzata per l'utente corrente.";
}

class AppPlantNamespace {
  const AppPlantNamespace();
  String get screenTitleAdd => AppPlantStrings.screenTitleAdd;
  String get screenTitleEdit => AppPlantStrings.screenTitleEdit;
  String get screenTitleDetail => AppPlantStrings.screenTitleDetail;
  String get labelWatering => AppPlantStrings.labelWatering;
  String get labelFertilizing => AppPlantStrings.labelFertilizing;
  String get labelNotes => AppPlantStrings.labelNotes;
  String get labelRoom => AppPlantStrings.labelRoom;
  String get labelSpecies => AppPlantStrings.labelSpecies;
  String get labelCustomName => AppPlantStrings.labelCustomName;
  String get labelAcquisitionDate => AppPlantStrings.labelAcquisitionDate;
  String get labelCultivationMethod => AppPlantStrings.labelCultivationMethod;
  String get labelMethodSoil => AppPlantStrings.labelMethodSoil;
  String get labelMethodWater => AppPlantStrings.labelMethodWater;
  String get buttonWater => AppPlantStrings.buttonWater;
  String get buttonFertilize => AppPlantStrings.buttonFertilize;
  String get buttonEdit => AppPlantStrings.buttonEdit;
  String get buttonDelete => AppPlantStrings.buttonDelete;
  String get buttonSave => AppPlantStrings.buttonSave;
  String get buttonCancel => AppPlantStrings.buttonCancel;
  String get confirmDeleteTitle => AppPlantStrings.confirmDeleteTitle;
  String get confirmDeleteBody => AppPlantStrings.confirmDeleteBody;
  String get errNotFound => AppPlantStrings.errNotFound;
  String get errAdd => AppPlantStrings.errAdd;
  String get errUpdate => AppPlantStrings.errUpdate;
  String get errDelete => AppPlantStrings.errDelete;
  String get errUnauthorized => AppPlantStrings.errUnauthorized;
}

// ── Stanze ────────────────────────────────────────────────────────────────

abstract final class AppRoomsStrings {
  static const screenTitle = 'Stanze';
  static const buttonAddRoom = 'Aggiungi stanza';
  static const labelRoomName = 'Nome stanza';
  static const labelExposure = 'Esposizione';
  static const placeholderNoRooms = 'Nessuna stanza configurata';

  static const exposureNorth = 'Nord';
  static const exposureSouth = 'Sud';
  static const exposureEast = 'Est';
  static const exposureWest = 'Ovest';
  static const exposureUnknown = 'Sconosciuta';

  static const errAdd = "Errore durante l'aggiunta della stanza";
  static const errUpdate = "Errore durante l'aggiornamento della stanza";
  static const errDelete = "Errore durante l'eliminazione della stanza";
  static const errRead = 'Errore durante la lettura delle stanze';
}

class AppRoomsNamespace {
  const AppRoomsNamespace();
  String get screenTitle => AppRoomsStrings.screenTitle;
  String get buttonAddRoom => AppRoomsStrings.buttonAddRoom;
  String get labelRoomName => AppRoomsStrings.labelRoomName;
  String get labelExposure => AppRoomsStrings.labelExposure;
  String get placeholderNoRooms => AppRoomsStrings.placeholderNoRooms;
  String get exposureNorth => AppRoomsStrings.exposureNorth;
  String get exposureSouth => AppRoomsStrings.exposureSouth;
  String get exposureEast => AppRoomsStrings.exposureEast;
  String get exposureWest => AppRoomsStrings.exposureWest;
  String get exposureUnknown => AppRoomsStrings.exposureUnknown;
  String get errAdd => AppRoomsStrings.errAdd;
  String get errUpdate => AppRoomsStrings.errUpdate;
  String get errDelete => AppRoomsStrings.errDelete;
  String get errRead => AppRoomsStrings.errRead;
}

// ── Enciclopedia ──────────────────────────────────────────────────────────

abstract final class AppEncyclopediaStrings {
  static const screenTitle = 'Enciclopedia';
  static const searchHint = 'Cerca per nome comune o scientifico...';
  static const emptyTitle = 'Esplora migliaia di piante';
  static const emptySubtitle = 'Cerca una specie per visualizzarne i dettagli';
  static const noResults = 'Nessuna specie trovata.';
  static String error(Object error) => 'Errore: $error';
}

class AppEncyclopediaNamespace {
  const AppEncyclopediaNamespace();
  String get screenTitle => AppEncyclopediaStrings.screenTitle;
  String get searchHint => AppEncyclopediaStrings.searchHint;
  String get emptyTitle => AppEncyclopediaStrings.emptyTitle;
  String get emptySubtitle => AppEncyclopediaStrings.emptySubtitle;
  String get noResults => AppEncyclopediaStrings.noResults;
  String error(Object error) => AppEncyclopediaStrings.error(error);
}

// ── Settings ──────────────────────────────────────────────────────────────

abstract final class AppSettingsStrings {
  static const screenTitle = 'Impostazioni';
  static const sectionGeneral = 'Generale';
  static const languageTitle = 'Lingua';
  static const languageSubtitle = "Scegli la lingua dell'app";
  static const languageItalian = 'Italiano';
  static const languageEnglish = 'Inglese';
  static const sectionNotifications = 'Notifiche';
  static const sectionAbout = 'Informazioni';

  static const notifPermissionTitle = 'Permesso Notifiche';
  static const notifPermissionSubtitle =
      'Concedi il permesso per ricevere avvisi '
      'sulle piante che necessitano attenzione.';
  static const notifPermissionButton = 'Richiedi Permesso';
  static const notifPermissionGranted = '✅ Permesso concesso!';
  static const notifPermissionDenied = '❌ Permesso negato.';

  static const reminderTitle = 'Orario promemoria mattutino';
  static String reminderSubtitle(String time) => 'Ogni mattina alle $time';
  static String reminderUpdated(String time) =>
      '⏰ Promemoria aggiornato: $time';
  static const reminderPickerHelpText = 'Scegli orario promemoria';

  static const aboutVersion = 'Versione';
  static const aboutVersionNumber = '0.1.0';
  static const aboutDataSource = 'Dati specie';
  static const aboutDataSourceSubtitle =
      'Forniti da Perenual API (piano gratuito)';
}

class AppSettingsNamespace {
  const AppSettingsNamespace();
  String get screenTitle => AppSettingsStrings.screenTitle;
  String get sectionGeneral => AppSettingsStrings.sectionGeneral;
  String get languageTitle => AppSettingsStrings.languageTitle;
  String get languageSubtitle => AppSettingsStrings.languageSubtitle;
  String get languageItalian => AppSettingsStrings.languageItalian;
  String get languageEnglish => AppSettingsStrings.languageEnglish;
  String get sectionNotifications => AppSettingsStrings.sectionNotifications;
  String get sectionAbout => AppSettingsStrings.sectionAbout;
  String get notifPermissionTitle => AppSettingsStrings.notifPermissionTitle;
  String get notifPermissionSubtitle =>
      AppSettingsStrings.notifPermissionSubtitle;
  String get notifPermissionButton => AppSettingsStrings.notifPermissionButton;
  String get notifPermissionGranted =>
      AppSettingsStrings.notifPermissionGranted;
  String get notifPermissionDenied => AppSettingsStrings.notifPermissionDenied;
  String get reminderTitle => AppSettingsStrings.reminderTitle;
  String reminderSubtitle(String time) =>
      AppSettingsStrings.reminderSubtitle(time);
  String reminderUpdated(String time) =>
      AppSettingsStrings.reminderUpdated(time);
  String get reminderPickerHelpText =>
      AppSettingsStrings.reminderPickerHelpText;
  String get aboutVersion => AppSettingsStrings.aboutVersion;
  String get aboutVersionNumber => AppSettingsStrings.aboutVersionNumber;
  String get aboutDataSource => AppSettingsStrings.aboutDataSource;
  String get aboutDataSourceSubtitle =>
      AppSettingsStrings.aboutDataSourceSubtitle;
}

// ── Navigazione ───────────────────────────────────────────────────────────

abstract final class AppNavStrings {
  static const home = 'Mensola';
  static const rooms = 'Stanze';
  static const encyclopedia = 'Enciclopedia';
  static const settings = 'Impostazioni';
}

class AppNavNamespace {
  const AppNavNamespace();
  String get home => AppNavStrings.home;
  String get rooms => AppNavStrings.rooms;
  String get encyclopedia => AppNavStrings.encyclopedia;
  String get settings => AppNavStrings.settings;
}

// ── Errori generici ───────────────────────────────────────────────────────

abstract final class AppErrorsStrings {
  static const networkUnavailable =
      'Nessuna connessione disponibile. '
      'I dati saranno sincronizzati al ritorno online.';
  static const pageNotFound = 'Pagina non trovata';
  static const pageNotFoundBody = 'Oops, questa pagina non esiste';
  static const pageNotFoundEmoji = '🌵';
  static const localDatabaseGeneric = 'Errore database locale.';
  static const syncFailed =
      'Sincronizzazione temporaneamente non disponibile.';
}

class AppErrorsNamespace {
  const AppErrorsNamespace();
  String get networkUnavailable => AppErrorsStrings.networkUnavailable;
  String get pageNotFound => AppErrorsStrings.pageNotFound;
  String get pageNotFoundBody => AppErrorsStrings.pageNotFoundBody;
  String get pageNotFoundEmoji => AppErrorsStrings.pageNotFoundEmoji;
  String get localDatabaseGeneric => AppErrorsStrings.localDatabaseGeneric;
  String get syncFailed => AppErrorsStrings.syncFailed;
}

// ── Comune ────────────────────────────────────────────────────────────────

abstract final class AppCommonStrings {
  static const buttonConfirm = 'Conferma';
  static const buttonClose = 'Chiudi';
  static const buttonRetry = 'Riprova';
  static const buttonAdd = 'Aggiungi';
  static const edit = 'Modifica';
  static const delete = 'Elimina';
  static const cancel = 'Annulla';
  static const save = 'Salva';
  static const unknown = 'Sconosciuto';
  static const loading = 'Caricamento...';
  static const appEmoji = '🌿';
}

class AppCommonNamespace {
  const AppCommonNamespace();
  String get buttonConfirm => AppCommonStrings.buttonConfirm;
  String get buttonClose => AppCommonStrings.buttonClose;
  String get buttonRetry => AppCommonStrings.buttonRetry;
  String get buttonAdd => AppCommonStrings.buttonAdd;
  String get edit => AppCommonStrings.edit;
  String get delete => AppCommonStrings.delete;
  String get cancel => AppCommonStrings.cancel;
  String get save => AppCommonStrings.save;
  String get unknown => AppCommonStrings.unknown;
  String get loading => AppCommonStrings.loading;
  String get appEmoji => AppCommonStrings.appEmoji;
}

// Aliases
typedef AuthStrings = AppAuthStrings;
typedef GreetingStrings = AppGreetingStrings;
typedef HomeStrings = AppHomeStrings;
typedef PlantStrings = AppPlantStrings;
typedef RoomsStrings = AppRoomsStrings;
typedef EncyclopediaStrings = AppEncyclopediaStrings;
typedef SettingsStrings = AppSettingsStrings;
typedef NavStrings = AppNavStrings;
typedef ErrorsStrings = AppErrorsStrings;
typedef CommonStrings = AppCommonStrings;
