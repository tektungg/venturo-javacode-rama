import 'package:http/http.dart' as http;

class NetworkService {
  static Future<bool> checkImageUrl(String? url) async {
    if (url == null || url.isEmpty) return false;

    Uri? uri;
    try {
      uri = Uri.parse(url);
    } catch (e) {
      return false;
    }

    try {
      final response = await http.head(uri);

      // Pastikan status code 200 (OK) dan konten adalah gambar
      if (response.statusCode == 200) {
        String? contentType = response.headers['content-type'];
        if (contentType != null && contentType.startsWith('image/')) {
          return true; // Jika URL mengarah ke gambar
        }
      }
    } catch (e) {
      // Jika terjadi error, misalnya tidak bisa terhubung ke server
      return false;
    }
    return false; // Jika URL tidak valid atau bukan gambar
  }
}
