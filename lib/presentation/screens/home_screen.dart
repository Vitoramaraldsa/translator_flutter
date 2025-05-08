import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:translator/domain/domain.dart';
import 'package:translator/presentation/providers/providers.dart';
import '../components/components.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final controller = TextEditingController();
    final languages = Language.values;
    var sourceLanguage = ref.watch(sourceLanguageProvider);
    var targetLanguage = ref.watch(targetLanguageProvider);
    final translateTextProviderAsync = ref.watch(translateTextProvider);
    return Scaffold(
      backgroundColor: const Color.fromARGB(242, 255, 255, 255),
      body: Center(
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.only(left: 10, right: 15, top: 20),
            child: Column(
              spacing: 40,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(15),
                  child: ColoredBox(
                    color: Colors.blue,
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 15),
                      child: TranslateOptions(
                        languages: languages,
                        sourceLanguage: sourceLanguage,
                        targetLanguage: targetLanguage,
                      ),
                    ),
                  ),
                ),
                TranslateBox(
                  labelText: "Escreva algo",
                  controller: controller,
                  icons: [
                    Icon(Icons.volume_up),
                    Icon(Icons.copy),
                    Icon(Icons.delete),
                  ],
                ),
                translateTextProviderAsync.when(
                  data: (data) => TranslateBox(
                    translatedText: data.translateTextEntity?.translatedText,
                    isTextField: false,
                    icons: [
                      Icon(Icons.volume_up),
                      Icon(Icons.copy),
                    ],
                  ),
                  loading: () => TranslateBox(
                    isTextField: false,
                    translatedText: "Traduzindo.",
                    icons: [],
                  ),
                  error: (error, stackTrace) => TranslateBox(
                    isTextField: false,
                    translatedText: "Não foi possível traduzir.",
                    icons: [],
                  ),
                ),
                FilledButton(
                  onPressed: () {
                    ref.read(translateTextProvider.notifier).translate(
                          TranslateTextParams(
                            text: controller.text,
                            sourceLanguage: ref.read(sourceLanguageProvider),
                            targetLanguage: ref.read(targetLanguageProvider),
                          ),
                        );
                  },
                  style: FilledButton.styleFrom(backgroundColor: Colors.blue),
                  child: Text("Traduzir"),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
