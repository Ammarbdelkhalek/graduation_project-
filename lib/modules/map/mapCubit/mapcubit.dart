import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:realestateapp/modules/map/mapCubit/mapStates.dart';
import 'package:realestateapp/modules/repository/mapRepository.dart';

class MapCubit extends Cubit<MapStates> {
  final MapsRepository mapsRepository;
  MapCubit(this.mapsRepository) : super(initstate());


  void emitPlaceSuggestions(String? place, String? sessionToken) {
    mapsRepository.fetchSuggestions(place!, sessionToken!).then((suggestions) {
      emit(PlacesLoaded(suggestions));
    });
  }

  void emitPlaceLocation(String placeId, String sessionToken) {
    mapsRepository.getPlaceLocation(placeId, sessionToken).then((place) {
      emit(PlaceLocationLoaded(place));
    });
  }
}
