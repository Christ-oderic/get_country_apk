import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get_country_apk/blocs/welcome/welcome_bloc.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final PageController pageController = PageController(initialPage: 0);
    return BlocBuilder<WelcomeBloc, WelcomeState>(
      builder: (context, state) {
          if (state is WelcomeLoadedState){
            return Scaffold(
              body: Container(
                color: Colors.white,
                child: Stack(
                  alignment: Alignment.topCenter,
                  children: [
                    PageView(
                      controller: pageController,
                      onPageChanged: (index) {
                        
                      },
                      children: [
                        _page(1, context, 'Welcome', 'assets/earthFromSpace.png'),
                        _page(2, context, 'Welcome', 'assets/worldMap.png'),
                        _page(3, context, 'Welcome', 'assets/earthFromSpaceOnAfrica.png'),
                      ],
                      
                    ),
                    Positioned(
                      bottom: 100.h,
                      child: DotsIndicator(
                        position: pageController.initialPage.toDouble(),
                        dotsCount: 3,
                        mainAxisAlignment: MainAxisAlignment.center,
                        decorator: DotsDecorator(
                          color: Colors.grey,
                          activeColor: Colors.black,
                          size: const Size.square(10.0),
                          activeSize: const Size(18.0, 8.0),
                          activeShape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5.0),
                        ),
                        )
                      )
                    )
                  ]
                )
              ),
            );
          }
          return const Scaffold(
          body: Center(child: CircularProgressIndicator()),);
        
      }
    );
  }


  Widget _page(int index, BuildContext context, String title, String imagePath) {
  return Column(
    children: [
      Image.asset(
        imagePath,
        width: double.infinity,
      ),
      Text(
        title,
        style: TextStyle(
          color: Colors.black,
          fontSize: 24,
          fontWeight: FontWeight.bold,
        ),
      ),
    ],
  );
  }
}

