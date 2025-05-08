import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:translator/presentation/components/components.dart';
import '../providers/providers.dart';
import '../../domain/domain.dart';

class TranslateOptions extends ConsumerWidget {
  final List<Language> languages;
  final Language? sourceLanguage;
  final Language? targetLanguage;
  const TranslateOptions({
    super.key,
    required this.languages,
    required this.sourceLanguage,
    required this.targetLanguage,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Row(
      children: [
        Expanded(
          child: CustomDropDownMenu(
            languages: languages,
            initialSelection: sourceLanguage,
            onSelected: (lang) {
              ref.read(sourceLanguageProvider.notifier).state = lang!;
            },
          ),
        ),
        Icon(Icons.arrow_forward, color: Colors.white),
        Expanded(
          child: CustomDropDownMenu(
            languages: languages,
            initialSelection: targetLanguage,
            onSelected: (lang) {
              ref.read(targetLanguageProvider.notifier).state = lang!;
            },
          ),
        ),
      ],
    );
  }
}
