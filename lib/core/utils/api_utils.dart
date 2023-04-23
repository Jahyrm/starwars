import 'dart:convert';
import 'dart:developer';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart';
import 'package:starwars/core/settings/global_vars.dart';

/// Tipos de llamados necesarios
enum ApiCallMethods { get, post, put, delete }

/// Clase que maneja el uso de la api.
class Api {
  /// Se implementa un método genérico para hacer llamadas a la api.
  static Future<dynamic> call(String url,
      {ApiCallMethods method = ApiCallMethods.get,
      dynamic data,
      Map<String, String>? customHeaders,
      bool? printDebugInfo,
      bool failOnPurpose = false}) async {
    /// Devolver error en caso de que se marco
    if (failOnPurpose) {
      return null;
    }

    /// Determinamos si imprimimos logs o no.
    if (GlobalVars.dev) {
      printDebugInfo = printDebugInfo ?? true;
    } else {
      printDebugInfo = printDebugInfo ?? false;
    }

    /// Determinamos la url a la cual debemos hacer la llamada.
    String finalUrl;
    if (GlobalVars.dev) {
      finalUrl = 'http://';
    } else {
      finalUrl = 'https://';
    }
    if (url.startsWith('http')) {
      finalUrl = url;
    } else {
      finalUrl += url;
    }
    Uri uri = Uri.parse(finalUrl);

    // Manejamos las cabeceras que se eben enviar
    Map<String, String> headers = {
      'Accept': 'application/json; charset=UTF-8',
    };
    if (customHeaders != null) {
      headers.addAll(customHeaders);
    }

    Response response;

    // Hacemos la llamada correspondiente.
    try {
      if (method == ApiCallMethods.post) {
        if (data != null && data.keys.isNotEmpty) {
          headers['Content-Type'] = 'application/json; charset=UTF-8';
          if (printDebugInfo) {
            _printLogsPartOne('POST', finalUrl, data: jsonEncode(data));
          }
          response = await post(uri, body: jsonEncode(data), headers: headers);
        } else {
          if (printDebugInfo) _printLogsPartOne('POST', finalUrl);
          response = await post(uri, headers: headers);
        }
      } else if (method == ApiCallMethods.get) {
        if (data != null && data.keys.isNotEmpty) {
          String argumentsChain = '';
          data.forEach((key, value) {
            if (key.isNotEmpty && value.toString().isNotEmpty) {
              argumentsChain += '$key=$value&';
            }
          });
          if (argumentsChain.isNotEmpty) {
            finalUrl += '?$argumentsChain';
            finalUrl = finalUrl.substring(0, finalUrl.length - 1);
            uri = Uri.parse(finalUrl);
          }
        }
        if (printDebugInfo) _printLogsPartOne('GET', finalUrl);
        response = await get(uri, headers: headers);
      } else if (method == ApiCallMethods.put) {
        if (data != null && data.keys.isNotEmpty) {
          headers['Content-Type'] = 'application/json; charset=UTF-8';
          if (printDebugInfo) {
            _printLogsPartOne('PUT', finalUrl, data: jsonEncode(data));
          }
          response = await put(uri, body: jsonEncode(data), headers: headers);
        } else {
          if (printDebugInfo) _printLogsPartOne('PUT', finalUrl);
          response = await put(uri, headers: headers);
        }
      } else {
        if (printDebugInfo) _printLogsPartOne('DELETE', finalUrl);
        response = await delete(uri, headers: headers);
      }

      if (printDebugInfo) {
        log('\t');
        log('RESPONSE CODE: ${response.statusCode}\n');
        log('\t');
        log('RESPONSE: ${response.body}\n');
        log('\t');
      }
      if (response.body.isEmpty) {
        return response.statusCode;
      } else {
        try {
          return jsonDecode(response.body);
        } catch (ex) {
          return null;
        }
      }
    } catch (e) {
      if (kDebugMode) {
        print('Excepión al hacer una llamada a la API: $e');
      }
    }
    return null;
  }

  static void _printLogsPartOne(String metodo, String url, {String? data}) {
    log('***********************************');
    log('\t');
    log('URL ($metodo): $url');
    log('\t');
    if (data?.isNotEmpty ?? false) {
      log('BODY ENVIADO: $data');
    }
  }
}
