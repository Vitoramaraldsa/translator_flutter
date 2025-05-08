import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:translator/domain/domain.dart';
import 'package:translator/infrastructure/infrastructure.dart';
import 'package:translator/presentation/providers/providers.dart';
import '../components/components.dart';

class HomeScreen extends ConsumerWidget {
  HomeScreen({super.key});

  final controller = TextEditingController();
  final languages = Language.values;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var sourceLanguage = ref.watch(sourceLanguageProvider);
    var targetLanguage = ref.watch(targetLanguageProvider);
    final translateTextProviderAsync = ref.watch(translateTextProvider);
    return Scaffold(
      backgroundColor: const Color.fromARGB(242, 255, 255, 255),
      body: Center(
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.only(left: 10, right: 15, top: 20),
            child: SingleChildScrollView(
              keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
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
                      IconButton(
                        onPressed: () {},
                        icon: Icon(Icons.volume_up),
                      ),
                      IconButton(
                        onPressed: () {
                          ClipboardService.copy(controller.text);
                        },
                        icon: Icon(Icons.copy),
                      ),
                      IconButton(
                        onPressed: () {
                          ref.invalidate(translateTextProvider);
                          controller.clear();
                        },
                        icon: Icon(Icons.delete),
                      ),
                    ],
                  ),
                  translateTextProviderAsync.whenOrNull(
                    data: (data) => TranslateBox(
                      translatedText: data.translateTextEntity?.translatedText,
                      isTextField: false,
                      icons: [
                        IconButton(
                          onPressed: () {},
                          icon: Icon(Icons.volume_up),
                        ),
                        IconButton(
                          onPressed: () {
                            ClipboardService.copy(data.translateTextEntity?.translatedText ?? "");
                          },
                          icon: Icon(Icons.copy),
                        ),
                      ],
                    ),
                  )!,
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
      ),
    );
  }
}
