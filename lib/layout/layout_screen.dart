import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:material_floating_search_bar/material_floating_search_bar.dart';
import 'package:realestateapp/models/post_model.dart';
import 'package:realestateapp/modules/cubit/cubit.dart';
import 'package:realestateapp/modules/cubit/states.dart';
import 'package:realestateapp/modules/new_post/new_post.dart';
import 'package:realestateapp/modules/search/filtering.dart';
import 'package:realestateapp/modules/search/search_screen.dart';
import 'package:realestateapp/modules/setting/drawer.dart';
import 'package:easy_localization/easy_localization.dart';
import '../shared/components/components.dart';

class LayoutScreen extends StatefulWidget {
  LayoutScreen({Key? key}) : super(key: key);

  @override
  State<LayoutScreen> createState() => _LayoutScreenState();
}

class _LayoutScreenState extends State<LayoutScreen> {
  FloatingSearchBarController controller = FloatingSearchBarController();

  double xOffset = 0;

  double yOffset = 0;

  bool isDrawerOpen = false;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = AppCubit.get(context);

        return Scaffold(
          appBar: AppBar(
            actions: [
              IconButton(
                onPressed: ({currentindex}) {
                  var index = 0;
                  currentindex = index;
                  cubit.searchADS == null;
                  navigateTo(context, SearchScreen(cubit.posts[index]));
                },
                icon: Icon(Icons.search),
              )
            ],
          ),
          drawer: Stack(children: [
            AnimatedContainer(
                transform: Matrix4.translationValues(xOffset, yOffset, 0)
                  ..scale(isDrawerOpen ? 0.85 : 1.00)
                  ..rotateZ(isDrawerOpen ? -50 : 0),
                duration: Duration(milliseconds: 200),
                // color: Colors.brown,
                decoration: BoxDecoration(
                  color: Colors.brown,
                  borderRadius: BorderRadius.circular(40),
                ),
                child: SingleChildScrollView(
                    child: Column(children: <Widget>[
                  SizedBox(
                    height: 50,
                  ),
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 20),
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          isDrawerOpen
                              ? GestureDetector(
                                  child: const Icon(
                                    Icons.arrow_back_ios_outlined,
                                    color: Colors.white,
                                  ),
                                  onTap: () {
                                    setState(() {
                                      xOffset = 0;
                                      yOffset = 0;
                                      isDrawerOpen = false;
                                    });
                                  },
                                )
                              : GestureDetector(
                                  child: const Icon(
                                    Icons.menu,
                                    color: Colors.white,
                                  ),
                                  onTap: () {
                                    setState(() {
                                      xOffset = 290;
                                      yOffset = 80;
                                      isDrawerOpen = true;
                                    });
                                  },
                                ),
                        ]),
                  ),
                ]))),
            const drawer_setting(),
          ]),
          floatingActionButton: Padding(
            padding: const EdgeInsets.all(10.0),
            child: FloatingActionButton(
              onPressed: () {
                navigateTo(context, NewPost());
              },
              child: const Icon(Icons.add_card),
            ),
          ),
          body: cubit.Screens[cubit.currentIndex],
          bottomNavigationBar: BottomNavigationBar(
            onTap: (index) {
              cubit.ChangeBottomNav(index);
            },
            currentIndex: cubit.currentIndex,
            items: [
              BottomNavigationBarItem(
                icon: const Icon(Icons.home),
                label: 'Home'.tr().toString(),
              ),
              BottomNavigationBarItem(
                icon: const Icon(Icons.category_outlined),
                label: 'category'.tr().toString(),
              ),
              BottomNavigationBarItem(
                icon: const Icon(Icons.home_repair_service),
                label: 'services'.tr().toString(),
              ),
              BottomNavigationBarItem(
                icon: const Icon(Icons.favorite),
                label: 'Favourite'.tr().toString(),
              ),
              BottomNavigationBarItem(
                icon: const Icon(Icons.message),
                label: 'Chat'.tr().toString(),
              ),
              BottomNavigationBarItem(
                icon: const Icon(Icons.settings),
                label: 'Setting'.tr().toString(),
              ),
            ],
          ),
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
            icon: const Icon(Icons.search),
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
