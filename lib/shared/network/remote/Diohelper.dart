import 'package:dio/dio.dart';
import 'package:realestateapp/models/locationmodel.dart';
import 'package:realestateapp/shared/components/constant.dart';

class Diohelper {
  static Dio dio = Dio();

  static PlacesWebservices() {
    BaseOptions options = BaseOptions(
      baseUrl: 'https://maps.googleapis.com/maps/api/place/autocomplete/json',
      connectTimeout: 20 * 1000,
      receiveTimeout: 20 * 1000,
      receiveDataWhenStatusError: true,
    );
  }

  static Future<List<dynamic>> fetchSuggestionplace({
    String? place,
    String? sessiontoken,
  }) async {
    try {
      Response response = await dio.get(
        'https://maps.googleapis.com/maps/api/place/autocomplete/json',
        queryParameters: {
          'input': place,
          'types': 'address',
          'components': 'country:eg',
          'key': 'AIzaSyB8ouG6DHqKcBayUzndcNoI4AsRHm4xWS0',
          'sessiontoken': sessiontoken
        },
      );
      print(response.data['predictions']);
      print(response.statusCode);
      return response.data['predictions'];
    } catch (error) {
      print(error.toString());
      return [];
    }
  }

  Future<dynamic> getPlaceLocation(String placeId, String sessionToken) async {
    try {
      Response response = await dio.get(
        'https://maps.googleapis.com/maps/api/place/autocomplete/json',
        queryParameters: {
          'place_id': placeId,
          'fields': 'geometry',
          'key': 'AIzaSyB8ouG6DHqKcBayUzndcNoI4AsRHm4xWS0',
          'sessiontoken': sessionToken
        },
      );
     print(response.data);
      return response.data;

    } catch (error) {
      return Future.error("Place location error : ",
          StackTrace.fromString(('this is its trace')));
    }
  }
}
