import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/bloc_observer.dart';
import 'package:shop_app/layout/cubit/cubit.dart';
import 'package:shop_app/layout/home_layout.dart';
import 'package:shop_app/screens/login/login_screen.dart';

import 'package:shop_app/screens/on_boarding/on_boarding_screen.dart';
import 'package:shop_app/shared/components/constance.dart';
import 'package:shop_app/shared/network/local/cache_helper.dart';
import 'package:shop_app/shared/network/remote/dio_helper.dart';

import 'shared/styles/themes.dart';

void main(List<String> args) async {
  WidgetsFlutterBinding.ensureInitialized();

  await CacheHelper.init();

  bool? onBoarding = CacheHelper.getData(
    key: "onBoarding",
  );
  token = CacheHelper.getData(key: "token");
  Widget? widget;
  if (onBoarding != null) {
    if (token != null)
      widget = HomeLayout();
    else
      widget = LoginScreen();
  } else {
    widget = OnboardingScreen();
  }
  print(token);
  print(onBoarding);

  BlocOverrides.runZoned(() {
    DioHelper.init();

    runApp(MyApp(
      startWidgt: widget,
    ));
  }, blocObserver: MyBlocObserver());
}

class MyApp extends StatelessWidget {
  // final bool? onBoarding;
  final Widget? startWidgt;
  const MyApp({Key? key, this.startWidgt}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
            create: (context) => LayOutCubit()
              ..getHomeData()
              ..getCategoriesData()
              ..getFavoriteData()
              ..getProfileData()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: startWidgt,
        theme: light,
        darkTheme: dark,
        themeMode: ThemeMode.light,
      ),
    );
  }
}
