// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get appName => 'Piantala';

  @override
  String get appTagline => 'Your pocket garden';

  @override
  String get appTosNotice => 'By signing in you accept the Terms of Service';

  @override
  String get authSignInWithGoogle => 'Continue with Google';

  @override
  String get authSignInWithEmail => 'Sign in with email';

  @override
  String get authSheetTitleLogin => 'Sign in with email';

  @override
  String get authSheetTitleRegister => 'Create account';

  @override
  String get authSheetTitleReset => 'Reset password';

  @override
  String get authSheetSubtitleReset =>
      'Enter your email. If it\'s linked to an account, you\'ll receive instructions.';

  @override
  String get authSheetSubtitleLogin =>
      'Use a valid email address and a secure password.';

  @override
  String get authFieldName => 'Name';

  @override
  String get authFieldEmail => 'Email';

  @override
  String get authFieldPassword => 'Password';

  @override
  String get authFieldConfirmPassword => 'Confirm password';

  @override
  String get authButtonLogin => 'Sign in';

  @override
  String get authButtonRegister => 'Create account';

  @override
  String get authButtonSendReset => 'Send instructions';

  @override
  String get authButtonForgotPassword => 'Forgot password?';

  @override
  String get authButtonGoToRegister => 'Don\'t have an account? Sign up';

  @override
  String get authButtonGoToLogin => 'Already have an account? Sign in';

  @override
  String get authButtonBackToLogin => 'Back to sign in';

  @override
  String get authValidationNameEmpty => 'Enter your name';

  @override
  String get authValidationEmailInvalid => 'Enter a valid email address';

  @override
  String get authValidationPasswordTooShort => 'Use at least 6 characters';

  @override
  String get authValidationPasswordMismatch => 'Passwords do not match';

  @override
  String get paperTextFieldShowPassword => 'Show password';

  @override
  String get paperTextFieldHidePassword => 'Hide password';

  @override
  String get authResetEmailSent =>
      'If the address is linked to an account, you\'ll receive instructions.';

  @override
  String get homeEmptyShelfTitle => 'Your shelf is empty';

  @override
  String get homeEmptyShelfSubtitle =>
      'Add your first plant\nusing the + button';

  @override
  String homeEmptyRoomTitle(String roomName) {
    return '$roomName is empty';
  }

  @override
  String get homeEmptyRoomSubtitle => 'Add a plant and assign it\nto this room';

  @override
  String get homeButtonAddPlant => 'Add plant';

  @override
  String get homeLabelUnassigned => 'Unassigned';

  @override
  String get homeLabelAllPlants => 'All plants';

  @override
  String get homeTooltipLogout => 'Logout';

  @override
  String homeRoomMeta(int count, String exposure) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count plants',
      one: '1 plant',
    );
    return '$_temp0 · Exposure $exposure';
  }

  @override
  String homeRoomPageSemantics(int current, int total) {
    return 'Room $current of $total';
  }

  @override
  String get homeWindowAccessibility => 'Time of day indicator';

  @override
  String get homePlantNameFallback => 'Plant';

  @override
  String get homeCareWateringSemantics => 'Needs watering';

  @override
  String get homeCareFertilizingSemantics => 'Needs fertilizing';

  @override
  String homeErrorLoading(Object error) {
    return 'Error: $error';
  }

  @override
  String get greetingNight => 'Good night';

  @override
  String get greetingDawn => 'Good morning';

  @override
  String get greetingDay => 'Hello';

  @override
  String get greetingDusk => 'Good afternoon';

  @override
  String get greetingEvening => 'Good evening';

  @override
  String get greetingSubtitleNight =>
      'Even at night your plants keep growing 🌙';

  @override
  String get greetingSubtitleDawn =>
      'A great start to the day with your plants';

  @override
  String get greetingSubtitleDay => 'How are your plants doing today?';

  @override
  String get greetingSubtitleDusk => 'Great time to check on your plants';

  @override
  String get greetingSubtitleEvening => 'Plan tomorrow\'s plant care';

  @override
  String get roomsEmptyTitle => 'No rooms created yet.';

  @override
  String get roomsEmptyHint => 'Tap \"new room\" to get started.';

  @override
  String roomsOptionsSemantics(String roomName) {
    return 'Room options for $roomName';
  }

  @override
  String roomsExposure(String exposure) {
    return 'Exposure: $exposure';
  }

  @override
  String roomsPlants(int count) {
    return 'Plants: $count';
  }

  @override
  String get roomsDeleteDialogTitle => 'Delete Room';

  @override
  String roomsDeleteWarning(int count) {
    return 'This room contains $count plants! Deleting it will make the plants \"Unassigned\". Do you want to proceed?';
  }

  @override
  String roomsDeleteConfirm(String roomName) {
    return 'Are you sure you want to delete the room \"$roomName\"?';
  }

  @override
  String get roomDialogNewTitle => 'New room';

  @override
  String get roomDialogEditTitle => 'Edit room';

  @override
  String get roomDialogNameLabel => 'Room name';

  @override
  String get roomDialogNameValidation => 'Please enter a name';

  @override
  String get roomDialogNameHint => 'Write the name';

  @override
  String get roomDialogNotesLabel => 'Notes (optional)';

  @override
  String get roomDialogNotesHint => 'Add a note';

  @override
  String get roomDialogExposureLabel => 'Exposure';

  @override
  String get roomDialogCompassSemantics => 'Detect exposure with the compass';

  @override
  String get compassTitle => 'Detect exposure';

  @override
  String get compassPointHint => 'Point toward the window';

  @override
  String get compassLocked => 'Direction detected';

  @override
  String compassHold(int seconds) {
    return 'Hold steady for: $seconds s';
  }

  @override
  String get compassDone => 'Exposure detected';

  @override
  String get compassRetry => 'Retry';

  @override
  String get compassUnavailable => 'Compass unavailable';

  @override
  String compassDialSemantics(String direction) {
    return 'Compass, direction $direction';
  }

  @override
  String get compassLetterNorth => 'N';

  @override
  String get compassLetterEast => 'E';

  @override
  String get compassLetterSouth => 'S';

  @override
  String get compassLetterWest => 'W';

  @override
  String get exposureNorthEast => 'Northeast';

  @override
  String get exposureSouthEast => 'Southeast';

  @override
  String get exposureSouthWest => 'Southwest';

  @override
  String get exposureNorthWest => 'Northwest';

  @override
  String get encyclopediaTitle => 'Encyclopedia';

  @override
  String get encyclopediaSearchHint => 'Search by common or scientific name...';

  @override
  String get encyclopediaEmptyTitle => 'Explore thousands of plants';

  @override
  String get encyclopediaEmptySubtitle =>
      'Search for a species to view its details';

  @override
  String get encyclopediaNoResults => 'No species found.';

  @override
  String encyclopediaError(Object error) {
    return 'Error: $error';
  }

  @override
  String get settingsScreenTitle => 'Settings';

  @override
  String get settingsLogout => 'Sign out';

  @override
  String get settingsSectionGeneral => 'General';

  @override
  String get settingsLanguageTitle => 'Language';

  @override
  String get settingsLanguageSubtitle => 'Choose the app language';

  @override
  String get settingsLanguageItalian => 'Italian';

  @override
  String get settingsLanguageEnglish => 'English';

  @override
  String get settingsSectionNotifications => 'Notifications';

  @override
  String get settingsSectionAbout => 'About';

  @override
  String get settingsNotifPermissionTitle => 'Notification Permission';

  @override
  String get settingsNotifPermissionSubtitle =>
      'Grant permission to receive alerts about plants that need attention.';

  @override
  String get settingsNotifPermissionButton => 'Request Permission';

  @override
  String get settingsNotifPermissionGranted => '✅ Permission granted!';

  @override
  String get settingsNotifPermissionDenied => '❌ Permission denied.';

  @override
  String get settingsReminderTitle => 'Morning reminder time';

  @override
  String settingsReminderSubtitle(String time) {
    return 'Every morning at $time';
  }

  @override
  String settingsReminderUpdated(String time) {
    return '⏰ Reminder updated: $time';
  }

  @override
  String get settingsReminderPickerHelpText => 'Choose reminder time';

  @override
  String get settingsAboutVersion => 'Version';

  @override
  String get settingsAboutVersionNumber => '0.1.0';

  @override
  String get settingsAboutDataSource => 'Species data';

  @override
  String get settingsAboutDataSourceSubtitle =>
      'Provided by Perenual API (free plan)';

  @override
  String get navHome => 'Shelf';

  @override
  String get navRooms => 'Rooms';

  @override
  String get navEncyclopedia => 'Encyclopedia';

  @override
  String get navSettings => 'Settings';

  @override
  String get navProfile => 'Profile';

  @override
  String get navNewPlant => 'new plant';

  @override
  String get navNewRoom => 'new room';

  @override
  String get errPageNotFound => 'Page not found';

  @override
  String get errPageNotFoundBody => 'Oops, this page doesn\'t exist';

  @override
  String get errNetworkUnavailable =>
      'No connection available. Data will sync when you\'re back online.';

  @override
  String get commonButtonConfirm => 'Confirm';

  @override
  String get commonButtonClose => 'Close';

  @override
  String get commonButtonRetry => 'Retry';

  @override
  String get commonButtonAdd => 'Add';

  @override
  String get commonEdit => 'Edit';

  @override
  String get commonDelete => 'Delete';

  @override
  String get commonCancel => 'Cancel';

  @override
  String get commonSave => 'Save';

  @override
  String get commonUnknown => 'Unknown';

  @override
  String get commonLoading => 'Loading...';

  @override
  String get exposureNorth => 'North';

  @override
  String get exposureSouth => 'South';

  @override
  String get exposureEast => 'East';

  @override
  String get exposureWest => 'West';

  @override
  String get exposureUnknown => 'Unknown';
}
