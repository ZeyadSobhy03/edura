import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_ce/hive.dart';

class LanguageCubit extends Cubit<Locale> {
  static const String _boxName = 'settings';
  static const String _key = 'languageCode';


  LanguageCubit({Locale? initialLocale}) : super(initialLocale ?? const Locale('en')) {
    _loadSavedLanguage();
  }

  Future<void> _loadSavedLanguage() async {
    try {
      if (!Hive.isBoxOpen(_boxName)) await Hive.openBox(_boxName);
      final box = Hive.box(_boxName);
      final saved = box.get(_key) as String?;
      if (saved != null && saved.isNotEmpty && saved != state.languageCode) {
        emit(Locale(saved));
      }
    } catch (_) {
    }
  }

  Future<void> setLanguage(Locale locale) async {
    if (locale.languageCode == state.languageCode) return;
    try {
      if (!Hive.isBoxOpen(_boxName)) await Hive.openBox(_boxName);
      final box = Hive.box(_boxName);
      await box.put(_key, locale.languageCode);
      emit(locale);
    } catch (_) {
      emit(locale);
    }
  }

  Future<String?> getSavedLanguageCode() async {
    try {
      if (!Hive.isBoxOpen(_boxName)) await Hive.openBox(_boxName);
      final box = Hive.box(_boxName);
      return box.get(_key) as String?;
    } catch (_) {
      return null;
    }
  }
}