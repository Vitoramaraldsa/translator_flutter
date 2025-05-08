import 'package:translator/domain/repositories/translate_text_repository.dart';
import 'package:google_mlkit_translation/google_mlkit_translation.dart';
import 'package:translator/infrastructure/mappers/language_mapper.dart';

class TranslateTextRepositoryImpl implements TranslateTextRepository {
  @override
  Future<String> translate(TranslateTextParams params) async {
    final onDeviceTranslator = OnDeviceTranslator(sourceLanguage: LanguageMapper.mapToMLKit(params.sourceLanguage), targetLanguage: LanguageMapper.mapToMLKit(params.targetLanguage));
    String translatedText = await onDeviceTranslator.translateText(params.text);
    return translatedText;
  }
}
