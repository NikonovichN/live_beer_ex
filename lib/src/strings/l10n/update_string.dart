import 'dart:io';
import 'package:translator/translator.dart';

class ArbManager {
  static final String _arbDir = 'lib/src/strings/l10n';
  static final Map<String, String> _arbFiles = {'ru': 'app_ru.arb', 'en': 'app_en.arb'};

  static Future<void> updateString(String key, String newRussianValue) async {
    try {
      // Проверяем существование ключа
      if (!await _keyExists(key)) {
        print('❌ Ключ "$key" не существует!');
        return;
      }

      // Переводим новое значение на английский
      final newEnglishValue = await _translateToEnglish(newRussianValue);

      // Обновляем в обоих файлах
      await _updateInArbFile('ru', key, newRussianValue);
      await _updateInArbFile('en', key, newEnglishValue);

      print('✅ Строка успешно обновлена:');
      print('   Ключ: $key');
      print('   Новый русский: $newRussianValue');
      print('   Новый английский: $newEnglishValue');
    } catch (e) {
      print('❌ Ошибка при обновлении строки: $e');
    }
  }

  static Future<bool> _keyExists(String key) async {
    for (final locale in _arbFiles.keys) {
      final file = File('$_arbDir/${_arbFiles[locale]}');
      if (await file.exists()) {
        final content = await file.readAsString();
        if (content.contains('"$key"')) {
          return true;
        }
      }
    }
    return false;
  }

  static Future<String> _translateToEnglish(String text) async {
    try {
      final translation = await text.translate(from: 'ru', to: 'en');
      return translation.text;
    } catch (e) {
      print('⚠️  Ошибка перевода, используется оригинальный текст');
      return text;
    }
  }

  static Future<void> _updateInArbFile(String locale, String key, String newValue) async {
    final file = File('$_arbDir/${_arbFiles[locale]}');
    if (!await file.exists()) {
      print('❌ Файл ${_arbFiles[locale]} не найден!');
      return;
    }

    var content = await file.readAsString();
    final lines = content.split('\n');
    final newLines = <String>[];
    bool updated = false;

    for (final line in lines) {
      if (line.trim().startsWith('"$key":')) {
        newLines.add('  "$key": "$newValue"');
        updated = true;
      } else {
        newLines.add(line);
      }
    }

    if (updated) {
      await file.writeAsString(newLines.join('\n'));
    } else {
      print('❌ Ключ "$key" не найден в ${_arbFiles[locale]}');
    }
  }
}

void main(List<String> args) async {
  if (args.length != 2) {
    print('Использование: dart update_string.dart <ключ> <новое_значение_на_русском>');
    print('Пример: dart update_string.dart welcome_message "Новое приветствие"');
    return;
  }

  final key = args[0];
  final newRussianValue = args[1];

  await ArbManager.updateString(key, newRussianValue);
}
