enum MeetingType {
  zoom,
  googleMeet;

  static MeetingType? fromPlatformType(String platformType) {
    final normalized = platformType
        .trim()
        .toLowerCase()
        .replaceAll(RegExp(r'[_\s-]'), '');

    return switch (normalized) {
      'zoom' => MeetingType.zoom,
      'googlemeet' || 'meet' => MeetingType.googleMeet,
      _ => null,
    };
  }
}
