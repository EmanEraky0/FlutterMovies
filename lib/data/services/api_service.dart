import 'dart:convert';
import 'dart:io';
import 'package:flutter_test2/core/utils/general_response.dart';
import 'package:flutter_test2/core/utils/constants.dart';
import 'package:http/http.dart' as http;

class ApiServices {
  final String baseUrl;

  ApiServices({required this.baseUrl});

  Future<ApiResult> request(String method, String endPoint,
      {Map<String, String>? headers, dynamic body,Map<String, String>? queryParameters}) async {
    final res = ApiResult();

    final url = Uri.https(
      'api.themoviedb.org',
      '/3/movie/popular',
      {'api_key': '2bf14753460f6b4f566587b6c70313cc', 'page': queryParameters!.values.last},
    );

    try {
      http.Response response;
      if (method == 'GET') {
        response = await http.get(url, headers: headers);
      } else if (method == 'POST') {
        response = await http.post(url, headers: headers, body: json.encode(body));
      } else if (method == 'PUT') {
        response = await http.put(url, headers: headers, body: json.encode(body));
      } else if (method == 'DELETE') {
        response = await http.delete(url, headers: headers);
      } else {
        throw UnsupportedError('HTTP method not supported: $method');
      }
      // Handle response
      if (response.statusCode == 200) {
        res.hasData = true;
        res.data =json.decode(response.body);
      } else {
        res.hasData = false;
        res.failure = Failure(response.statusCode, "Error in calling API");
      }
    } on SocketException {
      res.failure = Failure(Constants.socketCode, "Failed to connect to the network");
    } on FormatException {
      res.failure = Failure(Constants.formatCode, "Failed to format data");
    } catch (e) {
      res.failure = Failure(Constants.generalCode, "Request failed: $e");
    }

    return res;
  }

  Future<ApiResult> get(String endPoint, {Map<String, String>? headers,Map<String, String>? queryParameters}) {
    return request('GET', endPoint, headers: headers,queryParameters: queryParameters);
  }

  Future<ApiResult> post(String endPoint, {Map<String, String>? headers , dynamic body }) {
    return request('POST', endPoint, headers: headers,body: body);
  }

  Future<ApiResult> put(String endPoint, {Map<String, String>? headers , dynamic body }) {
    return request('PUT', endPoint, headers: headers,body: body);
  }

  Future<ApiResult> delete(String endPoint, {Map<String, String>? headers , dynamic body }) {
    return request('DELETE', endPoint, headers: headers);
  }

}
