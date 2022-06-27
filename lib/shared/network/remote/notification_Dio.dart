import 'dart:io';

import 'package:dio/adapter.dart';
import 'package:dio/dio.dart';
// import 'package:social_app/shared/constants.dart';

class notificationHelper {
  static Dio? dio;

  static Future<void> init() async {
    dio = Dio(BaseOptions(
        baseUrl: ' https://fcm.googleapis.com/fcm/send',
        receiveDataWhenStatusError: true));

    // erooooorrrr befor added this
    //DioError [DioErrorType.other]: HandshakeException: Handshake error in client (OS Error: I/flutter ( 9085):
    // CERTIFICATE_VERIFY_FAILED: unable to get local issuer certificate(handshake.cc:359))

    (dio!.httpClientAdapter as DefaultHttpClientAdapter).onHttpClientCreate =
        (HttpClient client) {
      client.badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
      return client;
    };
  }

  static Future<Response> getData(
      {required String url, required Map<String, dynamic> query}) async {
    return await dio!.get(url, queryParameters: query);
  }

  static Future<Response> postData({
    required String url,
    Map<String, dynamic>? query,
    required Map<String, dynamic> data,
  }) async {
    dio!.options.headers = {
      'Authorization':
          'key=AAAAIQasDlw:APA91bGztG0B0_SjHChpqs7MW20S9vdOx_wiiKgraU74OuLMCfr0cWzz4xdU-_6qoMjcS0r1anxYsFT8wcOQfPQB8lRcXuu_Y6q4xvgBlFayjRsaESud4TuBAF2zylqLqwOmIXXoVxua',
      'Content-Type': 'application/json',
    };

    return dio!.post(
      url,
      queryParameters: query,
      data: data,
    );
  }
}

// class notificationHelper {
//   static Dio dio = Dio();
//   static init() {
//     BaseOptions(
//       baseUrl: 'https://fcm.googleapis.com/fcm/send ',
//       connectTimeout: 20 * 1000,
//       receiveTimeout: 20 * 1000,
//       receiveDataWhenStatusError: true,
//     );
//   }

//   static Future<Response> postnotificationData({
//     required Map<String, dynamic> data,
//   }) async {
//     dio.options.headers = {
//       'Content-Type': 'application/json',
//       'Authorization':
//           'key=AAAAIQasDlw:APA91bGztG0B0_SjHChpqs7MW20S9vdOx_wiiKgraU74OuLMCfr0cWzz4xdU-_6qoMjcS0r1anxYsFT8wcOQfPQB8lRcXuu_Y6q4xvgBlFayjRsaESud4TuBAF2zylqLqwOmIXXoVxua',
//     };
//     return await dio.post('https://fcm.googleapis.com/fcm/send', data: data);
//   }
// }
