import 'package:http/http.dart' as http;
import 'dart:io';
import 'dart:async';

Future<void> main() async {
  List<String> websites = [
    'Your website: http://example.com',
  ];

  Timer.periodic(Duration(seconds:0),(Timer timer) async {
    for (String website in websites) {
      await checkWebsiteAvailability(website);
    }
  });
}

Future<void> checkWebsiteAvailability(String url) async {
  try {
    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      print('$url доступен');
    } else {
      print('$url недоступен');
    }
  } catch (e) {
    print('$url недоступен');
  }
}

