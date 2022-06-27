import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:realestateapp/models/locationmodel.dart';
import 'package:realestateapp/models/place.dart';
import 'package:realestateapp/shared/network/remote/Diohelper.dart';

class MapsRepository {
  final Diohelper diohelper;

  MapsRepository(this.diohelper);

  Future<List<LocationModel>> fetchSuggestions(
      String place, String sessionToken) async {
    final suggestions = await Diohelper.fetchSuggestionplace(
        place: place, sessiontoken: sessionToken);

    return suggestions
        .map((suggestion) => LocationModel.fromJson(suggestion))
        .toList();
  }

  Future<Place> getPlaceLocation(String placeId, String sessionToken) async {
    final place = await diohelper.getPlaceLocation(placeId, sessionToken);
    // var readyPlace = Place.fromJson(place);
    return Place.fromJson(place);
  }
}
