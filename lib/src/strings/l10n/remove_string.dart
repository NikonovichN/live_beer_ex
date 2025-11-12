import 'dart:io';

class ArbManager {
  static final String _arbDir = 'lib/src/strings/l10n';
  static final Map<String, String> _arbFiles = {'ru': 'app_ru.arb', 'en': 'app_en.arb'};

  static Future<void> removeString(String key) async {
    try {
      bool removed = false;

      for (final locale in _arbFiles.keys) {
        final file = File('$_arbDir/${_arbFiles[locale]}');
        if (await file.exists()) {
          final content = await file.readAsString();
          final lines = content.split('\n');
          final newLines = <String>[];
          bool found = false;

          for (final line in lines) {
            if (line.trim().startsWith('"$key":')) {
              found = true;
              removed = true;
              continue; // Пропускаем эту строку
            }
            newLines.add(line);
          }

          if (found) {
            await file.writeAsString(newLines.join('\n'));
            print('✅ Ключ "$key" удален из ${_arbFiles[locale]}');
          }
        }
      }

      if (!removed) {
        print('❌ Ключ "$key" не найден в ARB файлах');
      }
    } catch (e) {
      print('❌ Ошибка при удалении ключа: $e');
    }
  }
}

void main(List<String> args) async {
  if (args.length != 1) {
    print('Использование: dart remove_string.dart <ключ>');
    print('Пример: dart remove_string.dart welcome_message');
    return;
  }

  final key = args[0];
  await ArbManager.removeString(key);
}
