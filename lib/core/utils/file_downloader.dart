
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:path_provider/path_provider.dart';

class FileDownloader {
  FileDownloader._();

  static final Dio _dio = Dio();

  static Future<String> download({
    required String url,
    required String fileName,
    void Function(double progress)? onProgress,
    CancelToken? cancelToken,
  }) async {
    final dir = await getApplicationDocumentsDirectory();

    final safeName = fileName.replaceAll(RegExp(r'[\\/:*?"<>|]'), '_');
    final savePath = '${dir.path}${Platform.pathSeparator}$safeName';

    await _dio.download(
      url,
      savePath,
      cancelToken: cancelToken,
      onReceiveProgress: (received, total) {
        if (total > 0) onProgress?.call(received / total);
      },
    );

    return savePath;
  }
}