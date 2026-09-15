import 'dart:async';
import 'dart:io';

import 'package:supabase_flutter/supabase_flutter.dart';

import 'app_error.dart';

Never rethrowAsAppError(Object error) {
  if (error is AppError) throw error;
  if (error is SocketException) throw const NoInternetError();
  if (error is TimeoutException) throw const TimeoutError();
  if (error is PostgrestException || error is StorageException) {
    throw const ServerError();
  }
  throw const UnknownServerError();
}
