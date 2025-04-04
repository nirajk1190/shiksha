import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesService {
  static SharedPreferencesService? _instance;
  static SharedPreferences? _preferences;

  static Future<SharedPreferencesService?> getInstance() async {
    _instance ??= SharedPreferencesService();
    _preferences ??= await SharedPreferences.getInstance();
    return _instance;
  }

  String? getString(String key) {
    return _preferences?.getString(key);
  }

  int? getInt(String key) {
    return _preferences?.getInt(key);
  }

  static Future<void> clearAllPreferences() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.clear(); // Clears all preferences
    print("All preferences have been cleared.");
  }
  Future<void> saveLoginData(Map<String, dynamic> responseData) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    // Save top-level keys, checking for null and providing defaults
    await prefs.setString('access_token', responseData['access_token'] ?? '');
    await prefs.setString('token_type', responseData['token_type'] ?? '');
    await prefs.setInt('expires_in', responseData['expires_in'] ?? 0);
    await prefs.setString('message', responseData['message'] ?? '');

    // Extract 'users' and 'plans' objects
    final Map<String, dynamic> user = responseData['user']?['users'] ?? {};
    final Map<String, dynamic> plan = responseData['user']?['plans'] ?? {};

    // Save user details
    await prefs.setInt('user_id', user['id'] ?? 0);
    await prefs.setString('user_name', user['name'] ?? '');
    await prefs.setString('user_email', user['email'] ?? '');
    await prefs.setString('user_photo', user['photo'] ?? '');
    await prefs.setString('user_phone', user['phone_number'] ?? '');
    await prefs.setString('user_address', user['address'] ?? '');
    await prefs.setString('user_city', user['city'] ?? '');
    await prefs.setString('user_state', user['state'] ?? '');
    await prefs.setString('user_pincode', user['pincode'] ?? '');
    await prefs.setInt('standard_id', user['standard_id'] ?? 0);
    await prefs.setString('gender', user['gender'] ?? '');
    await prefs.setInt('plan_id', user['plan_id'] ?? 0);
    await prefs.setString('status', user['status'] ?? '');
    await prefs.setString('created_at', user['created_at'] ?? '');
    await prefs.setString('updated_at', user['updated_at'] ?? '');

    // Save plan details
    await prefs.setInt('plan_id', plan['id'] ?? 0);
    await prefs.setString('plan_name', plan['name'] ?? '');
    await prefs.setInt('plan_amount', plan['amount'] ?? 0);
    await prefs.setString('plan_created_at', plan['created_at'] ?? '');
    await prefs.setString('plan_updated_at', plan['updated_at'] ?? '');
  }
}
