abstract interface class FirebaseRemoteConfigService {
  Future<void> initialize();
  Future<void> fetchAndActivate();
  String getString(String key);
  bool getBool(String key);
  int getInt(String key);
  double getDouble(String key);
}
