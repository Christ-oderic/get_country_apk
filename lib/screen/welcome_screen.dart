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
                      // onPageChanged: (index) {
                        
                      // },
                      children: [
                        _page(1, context, 'Welcome', 'assets/earthFromSpace.png', 'Next',pageController),
                        _page(2, context, 'Welcome', 'assets/worldMap.png', 'Next', pageController),
                        _page(3, context, 'Welcome', 'assets/earthFromSpaceOnAfrica.png', 'Get Started',pageController),
                      ],
                      
                    ),
                    Positioned(
                      bottom: 80.h,
                      child: BlocBuilder<WelcomeBloc, WelcomeState>(
                        builder: (context, state) {
                          if (state is WelcomeLoadedState){
                            return DotsIndicator(
                              position: state.currentPage.toDouble(),
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
                        ),
                      );
                    }
                    return SizedBox.shrink();
                        },
                      ),
                    )
                  ],
                ),
              ),
            );
          }
          return const Scaffold(
          body: Center(child: CircularProgressIndicator()
          ),
        );
        
      }
    );
  }


  Widget _page(int index, BuildContext context, String title, String imagePath, buttonText, pageController) {
  return Column(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      Padding(padding: EdgeInsets.symmetric(horizontal: 20.w),
      child:  Image.asset(
        imagePath,
        width: double.maxFinite,
        height: 300.h,
        fit: BoxFit.contain,
      ),
      ),
     SizedBox(height: 20.h),
      Text(
        title,
        style: TextStyle(
          color: Colors.black,
          fontSize: 24,
          fontWeight: FontWeight.normal,
        ),
      ),
     SizedBox(height: 40.h),

      GestureDetector(
        onTap: () {
          if (index < 3) {
            pageController.nextPage(
              duration: const Duration(milliseconds: 500),
              curve: Curves.easeInOut
            );
          }else {
            context.read<WelcomeBloc>().add(MarkAppAsOpenedEvent());
            // Navigator.pushNamed(context, '/home');
          }
        },
        child: Container(
          margin: const EdgeInsets.only(top: 100, left: 25, right: 25),
          width: 325,
          height: 50,
          decoration: BoxDecoration(
            color: Colors.black,
            borderRadius: BorderRadius.circular(10),
            boxShadow: [
              BoxShadow(
                color: Colors.grey,
                spreadRadius: 1,
                blurRadius: 2,
                offset: const Offset(0, 2),
              )
            ],
          ),
          child: Center(
            child: Text(
              buttonText,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.normal,
              ),
            ),
          )
        ),
      )
    ],
  );
  }
}

