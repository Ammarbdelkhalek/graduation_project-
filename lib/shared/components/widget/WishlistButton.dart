import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:realestateapp/models/user_model.dart';
import 'package:realestateapp/modules/cubit/cubit.dart';
import 'package:realestateapp/modules/cubit/states.dart';
import 'package:realestateapp/shared/globalfunction/GlobalFunction.dart';

class HeartBTN extends StatefulWidget {
  const HeartBTN({Key? key, required this.postid, this.isInWishlist = false})
      : super(key: key);
  final String postid;
  final bool? isInWishlist;

  @override
  State<HeartBTN> createState() => _HeartBTNState();
}

class _HeartBTNState extends State<HeartBTN> {
  bool loading = false;
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(
        listener: (context, state) {},
        builder: (context, state) {
          var cubit = AppCubit.get(context);
          return GestureDetector(onTap: () async {
            setState(() {
              loading = true;
            });
            //try {
            //     if (widget.isInWishlist == false &&
            //         widget.isInWishlist != null) {
            //       await cubit.addtoWishList(
            //           postid: AppCubit.get(context).postModel!.postid);
            //     } else {
            //       await cubit.removeoneItem(
            //           wishListId: cubit.postModel!.postid!,
            //           postid: widget.postid);
            //     }
            //     await cubit.fetchWishlist();
            //     setState(() {
            //       loading = false;
            //     });
            //   } catch (error) {
            //     GlobalMethods.errorDialog(subtitle: '$error', context: context);
            //   } finally {
            //     setState(() {
            //       loading = false;
            //     });
            //   }
            //   // print('user id is ${user.uid}');
            //   // wishlistProvider.addRemoveProductToWishlist(productId: productId);
            // },
            child:
            loading
                ? const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: SizedBox(
                        height: 15,
                        width: 15,
                        child: CircularProgressIndicator()),
                  )
                : Icon(
                    widget.isInWishlist != null && widget.isInWishlist == true
                        ? Icons.favorite_border_outlined
                        : Icons.favorite,
                    size: 22,
                    color: widget.isInWishlist != null &&
                            widget.isInWishlist == true
                        ? Colors.red
                        : Colors.grey,
                  );
          });
        });
  }
}
