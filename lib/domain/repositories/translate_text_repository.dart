import 'package:translator/domain/enums/language.dart';

abstract class TranslateTextRepository {
  Future<String> translate(TranslateTextParams params);
}

class TranslateTextParams {
  String text;
  Language sourceLanguage;
  Language targetLanguage;

  TranslateTextParams({required this.text, required this.sourceLanguage, required this.targetLanguage});
}
