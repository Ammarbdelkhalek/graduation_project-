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
import 'package:easy_localization/easy_localization.dart';
import '../shared/components/components.dart';

class LayoutScreen extends StatefulWidget {
  LayoutScreen({Key? key}) : super(key: key);

  @override
  State<LayoutScreen> createState() => _LayoutScreenState();
}

class _LayoutScreenState extends State<LayoutScreen> {
  FloatingSearchBarController controller = FloatingSearchBarController();
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
                icon: const Icon(Icons.search),
              ),
              IconButton(
                onPressed: ({currentindex}) {
                  var index = 0;
                  currentindex = index;
                  navigateTo(context, filter_page());
                },
                icon: Icon(Icons.filter_list_alt),
              )
            ],
          ),
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
                label: 'Category'.tr().toString(),
              ),
              BottomNavigationBarItem(
                icon: const Icon(Icons.home_repair_service),
                label: 'Services'.tr().toString(),
              ),
              BottomNavigationBarItem(
                icon: const Icon(Icons.favorite),
                label: 'Favorite'.tr().toString(),
              ),

              BottomNavigationBarItem(
                icon: const Icon(Icons.settings),
                label: 'Settings'.tr().toString(),
              ),
            ],
          ),
        );
      },
    );
  }
}
