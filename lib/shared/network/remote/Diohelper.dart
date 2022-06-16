import 'package:dio/dio.dart';
import 'package:realestateapp/shared/components/constant.dart';

class Diohelper {
  static late Dio dio = Dio();
  static init() {
    dio = Dio(BaseOptions(
      baseUrl: 'https://fcm.googleapis.com/fcm/send',
      //https://newsapi.org/
      receiveDataWhenStatusError: true,
    ));
  }

  static Future<Response> postnotificationData({
    required Map<String, dynamic> data,
  }) async {
    dio.options.headers = {
      'Content-Type': 'application/json',
      'Authorization':
          'key=AAAAIQasDlw:APA91bGztG0B0_SjHChpqs7MW20S9vdOx_wiiKgraU74OuLMCfr0cWzz4xdU-_6qoMjcS0r1anxYsFT8wcOQfPQB8lRcXuu_Y6q4xvgBlFayjRsaESud4TuBAF2zylqLqwOmIXXoVxua',
    };
    return await dio.post('https://fcm.googleapis.com/fcm/send', data: data);
  }
  /*
  static Future<List<dynamic>> placeAutocomplete({
    String? place,
    String? sessiontoken,
  }) async {
    Response response = await dio.get(baseUrl, queryParameters: {
      'input ': place,
      'type ': 'address',
      'components ': 'country:eg',
      'key': mapkey,
      'sessiontoken': sessiontoken,
    });
    return response.data['predictions'];
  }
  */
}
