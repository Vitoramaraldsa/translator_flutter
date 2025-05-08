import 'package:clipboard/clipboard.dart';
import 'package:translator/infrastructure/infrastructure.dart';

class ClipboardService {
  static Future<void> copy(String text) async {
    if (text.isEmpty) {
      return;
    }
    FlutterClipboard.copy(text).then(
      (value) {
        MessageService.showMessage("Texto copiado");
      },
    );
  }
}
