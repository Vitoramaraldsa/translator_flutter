import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:translator/domain/enums/language.dart';

final sourceLanguageProvider = StateProvider.autoDispose<Language>((ref) {
  return Language.portuguese;
});

final targetLanguageProvider = StateProvider.autoDispose<Language>((ref) {
  return Language.english;
});
