import 'package:hive_ce/hive.dart';

class LoginHiveDataSource {
  static const String boxName = 'login_session_box';
  static const String roleKey = 'role';
  static const String userIdKey = 'user_id';
  static const String emailKey = 'email';

  Future<Box<dynamic>> _box() async {
	if (Hive.isBoxOpen(boxName)) {
	  return Hive.box<dynamic>(boxName);
	}

	return Hive.openBox<dynamic>(boxName);
  }

  Future<void> saveSession({
	required String userId,
	required String role,
	String? email,
  }) async {
	final box = await _box();
	await box.put(userIdKey, userId);
	await box.put(roleKey, role);

	if (email == null || email.isEmpty) {
	  await box.delete(emailKey);
	} else {
	  await box.put(emailKey, email);
	}
  }

  Future<String?> getRole() async {
	final box = await _box();
	return box.get(roleKey) as String?;
  }

  Future<String?> getUserId() async {
	final box = await _box();
	return box.get(userIdKey) as String?;
  }

  Future<String?> getEmail() async {
	final box = await _box();
	return box.get(emailKey) as String?;
  }

  Future<bool> hasSession() async {
	final box = await _box();
	return box.containsKey(roleKey) && box.containsKey(userIdKey);
  }

  Future<void> clearSession() async {
	final box = await _box();
	await box.clear();
  }
}

