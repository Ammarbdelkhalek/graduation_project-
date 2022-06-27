import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geocoding/geocoding.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:material_floating_search_bar/material_floating_search_bar.dart';
import 'package:realestateapp/modules/cubit/cubit.dart';
import 'package:realestateapp/modules/cubit/states.dart';

class Mapsscreen extends StatelessWidget {
  Mapsscreen({Key? key}) : super(key: key);
  Completer<GoogleMapController> _controller = Completer();
  FloatingSearchBarController controller = FloatingSearchBarController();
  var location;
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(
      listener: (context, state) {},
      builder: (context, state) {
        AppCubit.get(context).getlatAndlang();
        AppCubit.get(context).getpermission(context);
        var lat = AppCubit.get(context).lat;
        var long = AppCubit.get(context).long;
        Set<Marker> myMarker = {
          Marker(
            draggable: true,
            markerId: MarkerId('1'),
            infoWindow: InfoWindow(
                title: 'second ',
                onTap: () {
                  print("first marker ");
                }),
            position: const LatLng(30.056370, 31.110270),
          ),
        };
        return Scaffold(
          appBar: AppBar(
            title: const Text('your location '),
            leading: MaterialButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Icon(Icons.arrow_back),
            ),
          ),
          body: Stack(fit: StackFit.expand, children: [
            Column(
              children: [
                AppCubit.get(context).kGooglePlex == null
                    ? CircularProgressIndicator()
                    : SizedBox(
                        height: 500,
                        width: 400,
                        child: GoogleMap(
                          mapType: MapType.normal,
                          markers: myMarker,
                          onTap: (latlang) {
                            myMarker.add(Marker(
                                markerId: MarkerId("3"), position: latlang));
                          },
                          myLocationEnabled: true,
                          initialCameraPosition:
                              AppCubit.get(context).kGooglePlex!,
                          onMapCreated: (GoogleMapController controller) {
                            _controller.complete(controller);
                          },
                        ),
                      ),
                MaterialButton(
                  onPressed: () async {
                    location =
                        AppCubit.get(context).getlatAndlang().then((value) {
                      value = location;
                    });
                    List<Placemark> placemarks = await placemarkFromCoordinates(
                        AppCubit.get(context).lat, AppCubit.get(context).long);

                    print(placemarks[0].street);

                    Navigator.pop(context);
                  },
                  child: const Text('confirm the location'),
                )
              ],
            ),
            // buildFloatingSearchBar(context),
          ]),
        );
      },
    );
  }

  Widget buildFloatingSearchBar(context) {
    final isPortrait =
        MediaQuery.of(context).orientation == Orientation.portrait;

    return FloatingSearchBar(
      hint: 'Search...',
      scrollPadding: const EdgeInsets.only(top: 16, bottom: 56),
      controller: controller,
      transitionDuration: const Duration(milliseconds: 800),
      transitionCurve: Curves.easeInOut,
      physics: const BouncingScrollPhysics(),
      axisAlignment: isPortrait ? 0.0 : -1.0,
      openAxisAlignment: 0.0,
      width: isPortrait ? 600 : 500,
      debounceDelay: const Duration(milliseconds: 500),
      onQueryChanged: (query) {
        // Call your model, bloc, controller here.
      },
      // Specify a custom transition to be used for
      // animating between opened and closed stated.
      transition: CircularFloatingSearchBarTransition(),
      actions: [
        FloatingSearchBarAction(
          showIfOpened: false,
          child: CircularButton(
            icon: const Icon(Icons.place),
            onPressed: () {},
          ),
        ),
        FloatingSearchBarAction.searchToClear(
          showIfClosed: false,
        ),
      ],
      builder: (context, transition) {
        return ClipRRect(
          borderRadius: BorderRadius.circular(8),
          child: Material(
            color: Colors.white,
            elevation: 4.0,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: Colors.accents.map((color) {
                return Container(height: 112, color: color);
              }).toList(),
            ),
          ),
        );
      },
    );
  }
}
