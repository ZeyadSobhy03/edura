
import 'package:dio/dio.dart';
import 'package:path_provider/path_provider.dart';

class FileDownloader {
  static final Dio _dio = Dio();

  static Future<void> downloadFile(
      String url,
      String fileName,
      Function(double) onProgress,
      ) async {
    try {
      final directory = await getApplicationDocumentsDirectory();

      final savePath = '${directory.path}/$fileName';

      await _dio.download(
        url,
        savePath,
        onReceiveProgress: (received, total) {
          if (total != -1) {
            final progress = received / total;
            onProgress(progress);
          }
        },
      );
    } catch (e) {
      throw Exception("Error downloading file: $e");
    }
  }
}