import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesUtil {
  static const String _keyUserId = 'userId';
  static const String locationSaved = 'locationSaved';

  // Save the user ID
  static Future<void> setUserId(String userId) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString(_keyUserId, userId);
  }

  // Retrieve the user ID
  static Future<String?> getUserId() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(_keyUserId);
  }

  // Check if the location is saved
  static Future<bool> isLocationSaved() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getBool(locationSaved) ?? false; // Default to false if not set
  }

  // Set the location saved flag
  static Future<void> setLocationSavedFlag(bool isSaved) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool(locationSaved, isSaved);
  }

  // Remove the user ID
  static Future<void> removeUserId() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove(_keyUserId);
  }

  // Clear all shared preferences
  static Future<void> clearPreferences() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.clear();
  }
}
