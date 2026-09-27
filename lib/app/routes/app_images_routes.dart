class AppImage {
  static AppImage? _instance;

  factory AppImage() {
    _instance ??= AppImage._internal();
    return _instance!;
  }

  AppImage._internal();

  // Base paths
  final String baseImages = 'assets/images/';
  final String baseIcons = 'assets/icons/';

  // ===== images =====
  late final String alMobdea = '${baseImages}al_mobdea.png';
  late final String logoApp = alMobdea;
  late final String splashLogo = '${baseImages}splash_logo.png';
  late final String splashBackground = '${baseImages}splash_background.png';

  // ===== icons =====
  late final String homeIcon = '${baseIcons}home.svg';
  late final String search = '${baseIcons}Search.svg';
  late final String exam = '${baseIcons}exam.svg';
  late final String lessons = '${baseIcons}lessons.svg';
  late final String studyNotes = '${baseIcons}study_notes.svg';
  late final String profile = '${baseIcons}profile.svg';
  late final String notifications = '${baseIcons}notifications.svg';
  late final String emptySession = '${baseIcons}empty_session.svg';
  late final String arrowBack = '${baseIcons}arrow_back.svg';
}
