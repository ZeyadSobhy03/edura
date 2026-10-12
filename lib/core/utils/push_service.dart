import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class PushService {
  static final _supabase = Supabase.instance.client;
  static final _fcm = FirebaseMessaging.instance;
  static String? _token;

  /// Call after the user logs in.
  static Future<void> init() async {
    await _fcm.requestPermission();

    _token = await _fcm.getToken();
    if (_token != null) await _save(_token!);

    _fcm.onTokenRefresh.listen(_save);
  }

  /// Call before the user logs out.
  static Future<void> clear() async {
    final t = _token ?? await _fcm.getToken();
    if (t != null) {
      try {
        await _supabase.rpc('delete_device_token', params: {'p_token': t});
      } catch (_) {}
    }
    try {
      await _fcm.deleteToken();
    } catch (_) {}
    _token = null;
  }

  static Future<void> _save(String token) async {
    if (_supabase.auth.currentUser == null) return;
    await _supabase.rpc('save_device_token',
        params: {'p_token': token, 'p_platform': 'android'});
  }
}