import 'package:realestateapp/models/locationmodel.dart';

import '../../../models/place.dart';

class MapStates {}

class initstate extends MapStates {}

class PlacesLoaded extends MapStates {
  final List<LocationModel> places;

  PlacesLoaded(this.places);
}

class PlaceLocationLoaded extends MapStates {
  final Place place;

  PlaceLocationLoaded(this.place);
}
