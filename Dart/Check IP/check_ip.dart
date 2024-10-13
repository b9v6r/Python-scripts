import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;

void main() async {
  stdout.write('Введите доменное имя или IP-адрес: ');
  String? input = stdin.readLineSync();

  if (input == null || input.isEmpty) {
    print('Ввод не может быть пустым.');
    return;
  }

  // Проверяем, является ли ввод доменом или IP-адресом
  String domainOrIp = input.trim();

  // URL API для получения информации о местоположении IP
  var url = Uri.parse('http://ip-api.com/json/$domainOrIp');

  try {
    // Выполняем GET-запрос к API
    var response = await http.get(url);

    List<InternetAddress> addresses = await InternetAddress.lookup(domainOrIp);

    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);

      // Проверка на успешный ответ
      if (data['status'] == 'success') {
        print('Ввод: $domainOrIp');
        for (var address in addresses) {
          print('IP-адрес: ${address.address}');
        }
        print('IP-адрес: ${data['query']}');
        print('Страна: ${data['country']}');
        print('Регион: ${data['regionName']}');
        print('Город: ${data['city']}');
        print('Почтовый индекс: ${data['zip']}');
        print('Широта: ${data['lat']}');
        print('Долгота: ${data['lon']}');
      } else {
        print('Ошибка: ${data['message']}');
      }
    } else {
      print('Ошибка при выполнении запроса: ${response.statusCode}');
    }
  } catch (e) {
    print('Произошла ошибка: $e');
  }

  // Ожидание нажатия Enter перед выходом
  print('Нажмите Enter для выхода...');
  stdin.readLineSync();
}
