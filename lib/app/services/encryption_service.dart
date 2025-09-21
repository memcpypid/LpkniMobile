import 'dart:convert';
import 'dart:typed_data';
import 'package:encrypt/encrypt.dart' as encrypt;
// import 'package:flutter_dotenv/flutter_dotenv.dart';
// import 'package:pointycastle/export.dart';

// Ganti sesuai dengan secret key di .env (harus 16, 24, atau 32 karakter)
// const String keyString = String.fromEnvironment("AES_SECRET_KEY");
const String keyString = "12345678901234567890123456789012";

// Helper Base64
String toBase64(Uint8List bytes) => base64Encode(bytes);
Uint8List fromBase64(String base64Str) => base64Decode(base64Str);

/// Ambil key AES dari string
encrypt.Key getKey() {
  final keyBytes = utf8.encode(keyString);
  return encrypt.Key(Uint8List.fromList(keyBytes));
}

/// Encrypt data (map ke AES-GCM)
Future<String> encryptAES(Map<String, dynamic> dataObj) async {
  final plainText = jsonEncode(dataObj);

  // Buat IV random 12 byte (AES-GCM standard)
  final iv = encrypt.IV.fromSecureRandom(12);

  final key = getKey();
  final encrypter = encrypt.Encrypter(
    encrypt.AES(
      key,
      mode: encrypt.AESMode.gcm,
    ),
  );

  final encrypted = encrypter.encrypt(plainText, iv: iv);

  // Gabungkan iv + cipher
  final combined = Uint8List(iv.bytes.length + encrypted.bytes.length);
  combined.setAll(0, iv.bytes);
  combined.setAll(iv.bytes.length, encrypted.bytes);

  return toBase64(combined);
}

/// Decrypt data dari base64
Future<Map<String, dynamic>?> decryptAES(String base64Str) async {
  try {
    final combined = fromBase64(base64Str);
    final iv = combined.sublist(0, 12);
    final encrypted = combined.sublist(12);

    final key = getKey();
    final encrypter = encrypt.Encrypter(
      encrypt.AES(
        key,
        mode: encrypt.AESMode.gcm,
      ),
    );

    final decrypted = encrypter.decrypt(
      encrypt.Encrypted(encrypted),
      iv: encrypt.IV(iv),
    );

    return jsonDecode(decrypted);
  } catch (e) {
    print("❌ Decryption failed: $e");
    return null;
  }
}
