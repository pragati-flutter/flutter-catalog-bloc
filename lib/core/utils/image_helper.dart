import 'dart:io';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';

class ImageHelper {
  static Future<String?> downloadAndSaveImage({
    required String url,
    required int id,
  }) async {
    try {
      final dir = await getApplicationDocumentsDirectory();
      final filePath = '${dir.path}/img_$id.png';
      final file = File(filePath);

      // ✅ avoid re-download
      if (await file.exists()) {
        return filePath;
      }

      final response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
        await file.writeAsBytes(response.bodyBytes);
        return filePath;
      }

      return null;
    } catch (e) {
      print("Image download error: $e");
      return null;
    }
  }
}