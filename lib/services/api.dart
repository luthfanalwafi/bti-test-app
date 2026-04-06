import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:bti_test_app/config/env.dart';

import 'enums.dart';

final maskingErrorText = 'Unable to load data. Please try again later.';
const headers = {'Content-Type': 'application/json'};

class ResponseApi {
  final int statusCode;
  final String jsonString;

  const ResponseApi({required this.statusCode, required this.jsonString});
}

Future<ResponseApi> getResponseApi(
  HttpMethod method,
  String path, {
  Map<String, dynamic>? params,
  String? authorization,
}) async {
  try {
    String responseString = '';
    late HttpClientRequest request;
    HttpClientResponse? response;

    Map<String, dynamic> query = {'apiKey': apiKey};
    if (params != null) query.addAll(params);

    final url = Uri.https(baseUrl, path, query);

    final HttpClient httpClient = HttpClient();

    switch (method) {
      case HttpMethod.get:
        request = await httpClient.getUrl(url);
        request.headers.contentType = ContentType.json;
        request.headers.add('Accept', 'application/json');
        if (authorization != null) {
          request.headers.add('Authorization', authorization);
        }
        break;
      case HttpMethod.post:
        request = await httpClient.postUrl(url);
        request.headers.contentType = ContentType.json;
        request.headers.add('Accept', 'application/json');
        if (authorization != null) {
          request.headers.add('Authorization', authorization);
        }
        break;
    }

    response = await request.close();
    await for (var val in response.transform(utf8.decoder)) {
      responseString += val;
    }

    return ResponseApi(
      jsonString: responseString,
      statusCode: response.statusCode,
    );
  } catch (e) {
    if (e is HandshakeException) {
      throw maskingErrorText;
    }
    rethrow;
  }
}

class Api {
  static Future<Map<String, dynamic>?> getHeadlineNews(
    Map<String, dynamic> params,
  ) async {
    try {
      final response = await getResponseApi(
        HttpMethod.get,
        'v2/top-headlines',
        params: params,
      );
      final Map<String, dynamic> jsonDecoded = jsonDecode(response.jsonString);

      if (response.statusCode == 200) {
        return jsonDecoded;
      } else {
        throw jsonDecoded['message'];
      }
    } catch (e) {
      if (e is HttpException || e is FormatException || e is SocketException) {
        throw maskingErrorText;
      }
      rethrow;
    }
  }
}
