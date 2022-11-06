import 'dart:convert';
import 'dart:io';
import 'package:catatan_keuangan_online/app/mahas/services/mahas_service.dart';
import '../mahas_config.dart';
import '../models/api_result_model.dart';
import 'package:http/http.dart' as http;

class HttpApi {
  static Future<String?> _token() async {
    return await auth.currentUser!.getIdToken(true);
  }

  static String getUrl(String url) {
    if (url.toUpperCase().contains('HTTPS://') ||
        url.toUpperCase().contains('HTTP://')) {
      return url;
    } else {
      return MahasConfig.urlApi + url;
    }
  }

  static ApiResultModel _getResult(http.Response r) {
    return ApiResultModel(r.statusCode, r.body);
  }

  static ApiResultModel _getErrorResult(Exception ex) {
    return ApiResultModel.error("$ex");
  }

  static Future<ApiResultModel> get(String url) async {
    try {
      final token = await _token();
      final urlX = Uri.parse(getUrl(url));
      final r = await http.get(
        urlX,
        headers: {
          'Authorization': token != null ? 'Bearer $token' : '',
        },
      );
      return _getResult(r);
    } on HttpException catch (ex) {
      return _getErrorResult(ex);
    }
  }

  static Future<ApiResultModel> post(String url, {Object? body}) async {
    try {
      final token = await _token();
      final urlX = Uri.parse(getUrl(url));
      var r = await http.post(
        urlX,
        headers: {
          'Content-type': 'application/json',
          'Authorization': token != null ? 'Bearer $token' : '',
        },
        body: json.encode(body),
      );
      return _getResult(r);
    } on HttpException catch (ex) {
      return _getErrorResult(ex);
    }
  }

  static Future<ApiResultModel> put(String url, {Object? body}) async {
    try {
      final token = await _token();
      final urlX = Uri.parse(getUrl(url));
      var r = await http.put(
        urlX,
        headers: {
          'Content-type': 'application/json',
          'Authorization': token != null ? 'Bearer $token' : '',
        },
        body: json.encode(body),
      );
      return _getResult(r);
    } on HttpException catch (ex) {
      return _getErrorResult(ex);
    }
  }

  static Future<ApiResultModel> delete(String url) async {
    try {
      final token = await _token();
      final urlX = Uri.parse(getUrl(url));
      var r = await http.delete(
        urlX,
        headers: {
          'Authorization': token != null ? 'Bearer $token' : '',
        },
      );
      return _getResult(r);
    } on HttpException catch (ex) {
      return _getErrorResult(ex);
    }
  }
}
