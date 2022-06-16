import 'package:carousel_slider/carousel_slider.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:realestateapp/models/post_model.dart';
import 'package:realestateapp/modules/category/rentcategory.dart';
import 'package:realestateapp/modules/cubit/cubit.dart';
import 'package:realestateapp/modules/cubit/states.dart';
import 'package:realestateapp/shared/components/components.dart';
import '../../models/category_model.dart';

class Categoryscreen extends StatelessWidget {
  Categoryscreen({Key? key}) : super(key: key);
  CategoryDataModel? categoryDataModel;
  var carousalController = CarouselController();
  @override
  Widget build(BuildContext context) {
    AppCubit.get(context).getCategoryData();
    return BlocConsumer<AppCubit, AppStates>(
        listener: (context, state) {},
        builder: (context, state) {
          return ConditionalBuilder(
              condition: AppCubit.get(context).categories.length > 0,
              builder: (context) {
                return ListView.separated(
                  itemBuilder: (context, index) => InkWell(
                      onTap: (() {
                        navigateTo(
                            context,
                            rentcategory(
                                AppCubit.get(context).categories[index]));
                      }),
                      child: BuildCategoryItems(
                          AppCubit.get(context).categories[index])),
                  separatorBuilder: (context, index) => myDivider(),
                  itemCount: AppCubit.get(context).categories.length,
                );
              },
              fallback: (context) =>
                  const Center(child: CircularProgressIndicator()));
        });
  }

  Widget BuildCategoryItems(CategoryDataModel? categoryDataModel) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Expanded(
        child: Column(
          children: [
            Row(
              children: [
                Image(
                  width: 100,
                  height: 80,
                  image: NetworkImage('${categoryDataModel!.categoryImage}'),
                  fit: BoxFit.cover,
                ),
                const SizedBox(
                  width: 8.0,
                ),
                Text(
                  '${categoryDataModel.categoryName}',
                  style: const TextStyle(
                    fontSize: 17.0,
                  ),
                ),
                const Spacer(),
                IconButton(
                    onPressed: () {},
                    icon: const Icon(Icons.arrow_forward_ios)),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
