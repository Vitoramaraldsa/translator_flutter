import 'package:translator/domain/repositories/translate_text_repository.dart';

class TranslateTextUsecase {
  final TranslateTextRepository _translateTextRepository;
  TranslateTextUsecase(this._translateTextRepository);

  Future<String> call(TranslateTextParams params) async {
    String translatedText = await _translateTextRepository.translate(params);
    return translatedText;
  }
}
