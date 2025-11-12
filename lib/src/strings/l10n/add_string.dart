import 'dart:convert';
import 'dart:io';
import 'package:translator/translator.dart';

class ArbManager {
  static final Map<String, String> _arbFiles = {'ru': 'app_ru.arb', 'en': 'app_en.arb'};

  static Future<void> addString(String key, String russianValue) async {
    try {
      if (await _keyExists(key)) {
        print('❌ Ключ "$key" уже существует!');
        return;
      }

      final englishValue = await _translate(russianValue, 'ru', 'en');

      await _addToArbFile('ru', key, russianValue);
      await _addToArbFile('en', key, englishValue);

      print('✅ Строка успешно добавлена:');
      print('   Ключ: $key');
      print('   Русский: $russianValue');
      print('   Английский: $englishValue');
    } catch (e) {
      print('❌ Ошибка при добавлении строки: $e');
    }
  }

  static Future<bool> _keyExists(String key) async {
    for (final locale in _arbFiles.keys) {
      final file = File('${_arbFiles[locale]}');
      if (await file.exists()) {
        final content = await file.readAsString();
        if (content.contains('"$key"')) {
          return true;
        }
      }
    }
    return false;
  }

  static Future<String> _translate(String text, String from, String to) async {
    try {
      final translation = await text.translate(from: 'ru', to: 'en');
      return translation.text;
    } catch (e) {
      print('⚠️  Ошибка перевода, используется оригинальный текст');
      return text;
    }
  }

  static Future<void> _addToArbFile(String locale, String key, String value) async {
    final file = File('${_arbFiles[locale]}');
    if (!await file.exists()) {
      print('❌ Файл ${_arbFiles[locale]} не найден!');
      return;
    }

    var content = await file.readAsString();
    final Map<String, dynamic> arbData = json.decode(content);

    // Добавляем новую пару ключ-значение
    arbData[key] = value;

    // Сортируем ключи в алфавитном порядке
    final sortedKeys = arbData.keys.toList()..sort();

    // Создаем новую отсортированную карту
    final sortedArbData = <String, dynamic>{};
    for (final sortedKey in sortedKeys) {
      sortedArbData[sortedKey] = arbData[sortedKey];
    }

    // Форматируем обратно в JSON с отступами
    final encoder = JsonEncoder.withIndent('  ');
    final newContent = encoder.convert(sortedArbData);

    // Записываем обратно в файл
    await file.writeAsString(newContent, encoding: utf8);
  }
}

void main(List<String> args) async {
  if (args.length != 2) {
    print('Использование: dart add_string.dart <ключ> <значение_на_русском>');
    print('Пример: dart add_string.dart welcome_message "Добро пожаловать"');
    return;
  }

  final key = args[0];
  final russianValue = args[1];

  await ArbManager.addString(key, russianValue);
}
