import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get_country_apk/blocs/welcome/welcome_bloc.dart';
import 'package:get_country_apk/common/colors.dart';
import 'package:get_country_apk/screen/login_screen.dart';

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
                        context.read<WelcomeBloc>().add(UpdateWelcomePageEvent(index));
                      },
                      children: [
                        _page(1, context, 
                        "BIENVENUE DANS GEOQUIZ!","assets/earthFromSpace.png",
                        "Es-tu prêt à explorer le monde et à défier tes connaissances sur les pays ?", 
                        "Next",pageController),
                        _page(2, context, 
                        'Choisis un mode de jeu!','assets/worldMap.png',
                        'Réponds aux questions le plus vite possible ⏳,Gagne des points et grimpe dans le classement ! 🏆', 
                         'Next', pageController),
                        _page(3, context, 
                        'Es-tu prêt à relever le défi ?','assets/earthFromSpaceOnAfrica.png',
                        ' Let\'s go 🚀', 
                         'Get Started',pageController),
                      ],
                      
                    ),
                    Positioned(
                      bottom: 40,
                      child: BlocBuilder<WelcomeBloc, WelcomeState>(
                        builder: (context, state) {
                          if (state is WelcomeLoadedState){
                            return DotsIndicator(
                              position: state.currentPage.toDouble(),
                              dotsCount: 3,
                              mainAxisAlignment: MainAxisAlignment.center,
                              decorator: DotsDecorator(
                                color: AppColors.primaryThirdElementText,
                                activeColor: AppColors.primaryElement,
                                size: const Size.square(10.0),
                                activeSize: const Size(18.0, 8.0),
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


  Widget _page(int index, BuildContext context, String title, String imagePath,  String subtitle, String buttonText, pageController) {
  return Column(
    children: [
      Padding(
        padding: const EdgeInsets.only(top: 70),
        child: SizedBox(width: 345.w,height: 345.w,
        child:Center(
          child: Image.asset(
            imagePath,
            fit: BoxFit.cover,
          ),
        ),),
      ),
      Column(
        children: [
          SizedBox(height: 20.h),
          Text(
            title,
            style: TextStyle(
            color: AppColors.primaryText,
            fontSize: 26,
            fontWeight: FontWeight.normal,
            ),
          ),
          SizedBox(height: 20.h),
          Container(
            width: 375.w,
            padding: EdgeInsets.only(left: 30.w, right: 30.w),
            child: Center(
              child: Text(
                subtitle,
                style: TextStyle(
                  color: AppColors.primarySecondaryElementText,
                  fontSize: 18,
                  fontWeight: FontWeight.normal
                ),
              ),
            ),
          ),
        ]
      ),  
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
            Navigator.of(context).push(
            MaterialPageRoute(builder: (context) => const LoginScreen())
            );
          }
        },
        child: Container(
          margin: const EdgeInsets.only(top: 100, left: 25, right: 25),
          width: 325.w,
          height: 50.h,
          decoration: BoxDecoration(
            color: AppColors.primaryElement,
            borderRadius: BorderRadius.all(Radius.circular(15.w)),
            boxShadow: [
              BoxShadow(
                color: Colors.grey,
                spreadRadius: 1,
                blurRadius: 2,
                offset: const Offset(0, 1),
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

