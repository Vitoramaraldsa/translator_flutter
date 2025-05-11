import 'package:translator/domain/domain.dart';

extension LanguageExtension on Language {
  String getLanguageCode() {
    switch (this) {
      case Language.english:
        return "en-US";
      case Language.portuguese:
        return "pt-BR";
      case Language.spanish:
        return "es-ES";
      case Language.french:
        return "fr-FR";
    }
  }
}
