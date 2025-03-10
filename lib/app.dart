import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get_country_apk/screen/home_screen.dart';
import 'package:get_country_apk/screen/login_screen.dart';
    
import 'blocs/welcome/welcome_bloc.dart';
import 'screen/welcome_screen.dart';
    
class App extends StatelessWidget {
  const App({super.key});
    
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(375, 812), // Standard iPhone design size
      splitScreenMode: true,
      builder: (_, child) {
      return MaterialApp(
        debugShowCheckedModeBanner: false,
          initialRoute: '/',
          routes: {
            '/login': (context) => const LoginScreen(),
            '/home': (context) => const HomeScreen(),
          },
          theme: ThemeData(
                primarySwatch: Colors.blue,
                visualDensity: VisualDensity.adaptivePlatformDensity,
              ),
              home: BlocProvider(
                create: (context) => WelcomeBloc()..add(LoadWelcomePageEvent()),
                child: const WelcomeScreen(),
              ),
            );
          },
        );
      }
}
 