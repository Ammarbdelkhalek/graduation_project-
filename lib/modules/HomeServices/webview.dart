import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:realestateapp/modules/cubit/cubit.dart';
import 'package:realestateapp/modules/cubit/states.dart';
import 'package:webview_flutter/webview_flutter.dart';

class webview_page extends StatelessWidget {
  webview_page(
    this.Url, {
    Key? key,
  }) : super(key: key);
  final String Url;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(
      listener: ((context, state) {}),
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(),
          body: WebView(initialUrl: Url),
        );
      },
    );
  }
}
