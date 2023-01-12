import 'dart:async';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:http/http.dart';

Future<String> fetchMoviesAndSeries(String url) async {
  try {
    final data = await http.get(Uri.parse(url));
    if (data.statusCode == 200) {
      return data.body;
    } else {
      return '';
    }
  } on TimeoutException {
    return '';
  } on ClientException {
    return '';
  } on SocketException {
    return '';
  } catch (e) {
    return '';
  }
}
