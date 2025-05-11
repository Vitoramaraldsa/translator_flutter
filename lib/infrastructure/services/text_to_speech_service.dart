import 'package:flutter_tts/flutter_tts.dart';

class TextToSpeechService {
  static Future<void> speak(String text, {String? language = "pt-BR"}) async {
    if (text.isEmpty) return;
    FlutterTts tts = FlutterTts();
    tts.setLanguage(language!);
    tts.setSpeechRate(0.4);
    await tts.speak(text);
  }
}
