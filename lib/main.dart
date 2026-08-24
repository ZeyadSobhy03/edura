import 'package:edura/edura_app.dart';
import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Supabase.initialize(
    url: 'https://daxgkzzwfnpyqsjcpnad.supabase.co',
    publishableKey: 'sb_publishable_nY126vB7GG51e9EW2SOxew_A8wycwJY',
  );
  runApp(const EduraApp());
}
