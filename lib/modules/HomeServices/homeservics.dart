import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:realestateapp/models/servicesmodel.dart';
import 'package:realestateapp/models/servicesmodel.dart';
import 'package:realestateapp/models/servicesmodel.dart';
import 'package:realestateapp/modules/HomeServices/webview.dart';
import 'package:realestateapp/modules/cubit/cubit.dart';
import 'package:realestateapp/modules/cubit/states.dart';
import 'package:realestateapp/modules/search/filtering.dart';
import 'package:realestateapp/shared/components/components.dart';
import 'package:realestateapp/shared/components/constant.dart';

class AppServices extends StatelessWidget {
  AppServices({Key? key}) : super(key: key);
  ServicesModel? servicesModel;
  @override
  Widget build(BuildContext context) {
    AppCubit.get(context).getservice();
    AppCubit.get(context).getLawService();
    return BlocConsumer<AppCubit, AppStates>(
        listener: (context, state) {},
        builder: (context, state) {
          return DefaultTabController(
            length: 2,
            child: Scaffold(
                appBar: AppBar(
                  bottom: const TabBar(tabs:
                  [
                    Tab(
                      icon: Icon(Icons.home_repair_service),
                      text: 'Home services',
                    ),
                    Tab(
                      icon: Icon(Icons.balance_sharp),
                      text: 'law services',
                    ),
                  ]),
                ),
                body: TabBarView(children: [
                  SingleChildScrollView(
                    child: Column(
                      children: [
                        ConditionalBuilder(
                          condition: AppCubit.get(context).Service.length > 0,
                          builder: (context) {
                            return Column(
                              children: [
                                ListView.separated(
                                  // scrollDirection: Axis.vertical,
                                  physics: const BouncingScrollPhysics(),
                                  shrinkWrap: true,
                                  itemBuilder: (context, index) =>
                                      BuidServicesItems(
                                          AppCubit.get(context).Service[index],
                                          index,
                                          context),
                                  separatorBuilder: (context, index) =>
                                      Padding(
                                        padding: const EdgeInsets.all(20.0),
                                        child: Container(
                                          height: 2,
                                          width: double.infinity,
                                          color: AppCubit.get(context).isDark? Colors.grey: Colors.white,
                                        ),
                                      ),
                                  itemCount:
                                      AppCubit.get(context).Service.length,
                                ),
                              ],
                            );
                          },
                          fallback: (context) =>
                              AppCubit.get(context).Service.length == 0
                                  ? Align(
                                      alignment: Alignment.center,
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: const [
                                          Image(
                                            image: NetworkImage(
                                                'https://correspondentsoftheworld.com/images/elements/clear/undraw_Content_structure_re_ebkv_clear.png'),
                                            height: 300,
                                            width: 380,
                                            fit: BoxFit.cover,
                                          ),
                                          SizedBox(
                                            height: 6.0,
                                          ),
                                          Text(
                                            ' explore other services ',
                                            style: TextStyle(
                                                fontSize: 15.0,
                                                fontWeight: FontWeight.bold,
                                                color: Colors.grey),
                                          ),
                                        ],
                                      ),
                                    )
                                  : const Center(
                                      child: CircularProgressIndicator()),
                        ),
                      ],
                    ),
                  ),
                  SingleChildScrollView(
                    child: Column(
                      children: [
                        ConditionalBuilder(
                          condition:
                              AppCubit.get(context).LawServices.length > 0,
                          builder: (context) {
                            return Column(
                              children: [
                                ListView.separated(
                                  // scrollDirection: Axis.vertical,
                                  physics: const BouncingScrollPhysics(),
                                  shrinkWrap: true,
                                  itemBuilder: (context, index) =>
                                      BuidServicesItems(
                                          AppCubit.get(context)
                                              .LawServices[index],
                                          index,
                                          context),
                                  separatorBuilder: (context, index) =>
                                       Padding(
                                         padding: const EdgeInsets.all(20.0),
                                         child: Container(
                                           height: 2,
                                          width: double.infinity,
                                           color: AppCubit.get(context).isDark? Colors.grey: Colors.white,
                                      ),
                                       ),
                                  itemCount:
                                      AppCubit.get(context).LawServices.length,
                                ),
                              ],
                            );
                          },
                          fallback: (context) =>
                              AppCubit.get(context).LawServices.length == 0
                                  ? Align(
                                      alignment: Alignment.center,
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: const [
                                          Image(
                                            image: NetworkImage(
                                                'https://correspondentsoftheworld.com/images/elements/clear/undraw_Content_structure_re_ebkv_clear.png'),
                                            height: 300,
                                            width: 380,
                                            fit: BoxFit.cover,
                                          ),
                                          SizedBox(
                                            height: 6.0,
                                          ),
                                          Text(
                                            ' Explore other services ',
                                            style: TextStyle(
                                                fontSize: 15.0,
                                                fontWeight: FontWeight.bold,
                                                color: Colors.grey),
                                          ),
                                        ],
                                      ),
                                    )
                                  : const Center(
                                      child: CircularProgressIndicator()),
                        ),
                      ],
                    ),
                  ),
                ])),
          );
        });
  }

  Widget BuidServicesItems(
    ServicesModel? model,
    index,
    context,
  ) {
    return InkWell(
      onTap: () {
        navigateTo(context, webview_page(model!.Url!));
      },
      child: Expanded(
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.only(right: appPadding / 3),
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: appPadding / 2),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: AppCubit.get(context).isDark? Colors.white : HexColor('#333739'),
                ),
                width: double.infinity,
                height: 146.0,
                // color: Colors.grey[300],
                child: Expanded(
                  child: Row(
                    children: [
                      Image.network(
                        '${model!.image}',
                        width: 100,
                        height: 150,
                      ),
                      Spacer(),
                      Flexible(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              ' ${model.companyName}  '.tr().toString(),
                              overflow: TextOverflow.ellipsis,
                              maxLines: 2,
                            ),
                            const SizedBox(height: 8.0),
                            Text('${model.serviceType} '),
                            const SizedBox(height: 8.0),
                            Text(
                              '  ${model.location}',
                              style: const TextStyle(
                                  fontSize: 10.0,
                                  overflow: TextOverflow.ellipsis),
                              maxLines: 2,
                            ),
                            const SizedBox(height: 10.0),
                            RatingBarIndicator(
                              rating: model.rate!,
                              itemBuilder: (context, index) => const Icon(
                                Icons.star,
                                color: Colors.amber,
                              ),
                              itemCount: 5,
                              itemSize: 20.0,
                              direction: Axis.horizontal,
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
