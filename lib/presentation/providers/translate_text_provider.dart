import 'dart:async';

import 'package:riverpod/riverpod.dart';
import 'package:translator/infrastructure/translate_text_repository_impl.dart';
import '../../domain/domain.dart';

class TranslateTextState {
  final TranslateTextEntity? translateTextEntity;
  final bool isDownloading;

  TranslateTextState({this.translateTextEntity, required this.isDownloading});

  TranslateTextState copyWith({TranslateTextEntity? translateTextEntity, bool? isDownloading}) {
    return TranslateTextState(translateTextEntity: translateTextEntity ?? this.translateTextEntity, isDownloading: isDownloading ?? this.isDownloading);
  }
}

class TranslateTextNotifier extends StateNotifier<AsyncValue<TranslateTextState>> {
  final TranslateTextUsecase translateTextUsecase;

  //estado inicial da aplicação.
  TranslateTextNotifier(this.translateTextUsecase) : super(AsyncValue.data(TranslateTextState(translateTextEntity: null, isDownloading: false)));

  //invoca o método de converter e altera o estado.
  Future<void> translate(TranslateTextParams params) async {
    state = AsyncData(state.value!.copyWith(isDownloading: true));
    final translatedText = await translateTextUsecase(params).catchError((onError) {
      return "Algo errado aconteceu $onError";
    });

    state = AsyncData(state.value!.copyWith(isDownloading: false, translateTextEntity: TranslateTextEntity(translatedText: translatedText)));
  }
}

/* forma moderna de trabalhar com riveropod
class ClasseQualquer extends AsyncNotifier<TranslateTextState> {
  final TranslateTextUsecase translateTextUsecase;
  ClasseQualquer({required this.translateTextUsecase});

  @override
  FutureOr<TranslateTextState> build() {
    return TranslateTextState(translateTextEntity: null, isDownloading: false);
  }

  Future<void> translate(TranslateTextParams params) async {
    state = AsyncLoading();
    state = await AsyncValue.guard<TranslateTextState>(
      () async {
        final translatedText = await translateTextUsecase(params);
        return state.value!.copyWith(isDownloading: false, translateTextEntity: TranslateTextEntity(translatedText: translatedText));
      },
    );
  }
}*/
//final qualquerCoisaProvider = AsyncNotifierProvider<ClasseQualquer, TranslateTextState>(() => ClasseQualquer(translateTextUsecase: TranslateTextUsecase(TranslateTextRepositoryImpl())));

final translateTextProvider = StateNotifierProvider<TranslateTextNotifier, AsyncValue<TranslateTextState>>((ref) => TranslateTextNotifier(TranslateTextUsecase(TranslateTextRepositoryImpl())));
