import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:realestateapp/layout/layout_screen.dart';
import 'package:realestateapp/models/user_model.dart';
import 'package:realestateapp/modules/cubit/cubit.dart';
import 'package:realestateapp/modules/cubit/states.dart';
import 'package:realestateapp/modules/login/login_screen.dart';
import 'package:realestateapp/modules/map/map.dart';
import 'package:realestateapp/modules/map/mapCubit/mapcubit.dart';
import 'package:realestateapp/modules/onboarding_screen.dart';
import 'package:realestateapp/modules/repository/mapRepository.dart';
import 'package:realestateapp/modules/search/filtering.dart';
import 'package:realestateapp/shared/components/constant.dart';
import 'package:realestateapp/shared/network/local/cache_helper.dart';
import 'package:realestateapp/shared/network/remote/Diohelper.dart';
import 'package:realestateapp/shared/network/remote/notification_Dio.dart';
import 'package:realestateapp/shared/styles/themes.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:easy_localization/easy_localization.dart';

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  // If you're going to use other Firebase services in the background, such as Firestore,
  // make sure you call `initializeApp` before using other Firebase services.
  await Firebase.initializeApp();

  print("Handling a background message: ${message.messageId}");
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();
  await Firebase.initializeApp(
      // options: DefaultFirebaseOptions.currentPlatform,

      );

  // var Token = await FirebaseMessaging.instance.getToken();
  // print(Token);

  FirebaseMessaging.onMessage.listen((event) {
    print(event.data.toString());
  });
  FirebaseMessaging.onMessageOpenedApp.listen((event) {
    print(event.data.toString());
  });
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  Diohelper.PlacesWebservices();
  notificationHelper.init();
  await CacheHelper.init();

  bool? isDark = CacheHelper.getData(key: 'isDark');

  Widget widget;

  uid = CacheHelper.getData(key: 'uid');
  bool? onboarding = CacheHelper.getData(key: 'onBoarding');

  print(uid);
  if (onboarding != null) {
    if (uid != null) {
      widget = LayoutScreen();
    } else {
      widget = LoginScreen();
    }
  } else {
    widget = OnBoardingScreen();
  }

  runApp(EasyLocalization(
    supportedLocales: [Locale('en', 'US'), Locale('ar', 'EG')],
    path: 'assets/translations',
    saveLocale: true, // <-- change the path of the translation files
    fallbackLocale: const Locale('en', 'US'),
    child: MyApp(
      startWidget: widget,
      isDark: isDark,
    ),
  ));
}

class MyApp extends StatelessWidget {
  bool? isDark;
  String? uid;
  Widget? startWidget;
  MyApp({this.startWidget, this.uid, this.isDark});

  // This widget is the root of your application.
  @override
  Widget build(
    BuildContext context,
  ) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (BuildContext context) => AppCubit()
            ..getUserData()
            ..getPosts()
            ..changeAppMode(
              themeMode: isDark,
            )
            ..getCategoryData()
            ..getBundle()
            ..getAllUsers()
            ..getUserToken(),
        ),
        BlocProvider(
            create: (BuildContext context) =>
                MapCubit(MapsRepository(Diohelper()))),
      ],
      child: BlocConsumer<AppCubit, AppStates>(
        listener: (context, state) {},
        builder: (context, state) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            theme: lightTheme,
            darkTheme: darkTheme,
            themeMode:
                AppCubit.get(context).isDark ? ThemeMode.light : ThemeMode.dark,
            home: AnimatedSplashScreen(
              splash: const Image(
                image: AssetImage('assets/images/12.png'),
              ),
              nextScreen: startWidget!,
              backgroundColor: Colors.greenAccent,
              duration: 2500,
              centered: true,
              splashIconSize: 100,
              splashTransition: SplashTransition.fadeTransition,
            ),
            localizationsDelegates: context.localizationDelegates,
            supportedLocales: context.supportedLocales,
            locale: context.locale,
          );
        },
      ),
    );
  }
}
