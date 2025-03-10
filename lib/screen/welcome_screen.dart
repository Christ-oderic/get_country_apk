import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_country_apk/blocs/welcome/welcome_bloc.dart';
import 'package:get_country_apk/common/colors.dart';
import 'package:get_country_apk/utils/welcome_page_utils.dart';

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
                        WelcomePageUtils(
                          index: 1, 
                          title:'BIENVENUE DANS GEOQUIZ', 
                          imagePath: "assets/earthFromSpace.png",
                          subtitle: "Es-tu prêt à explorer le monde et à défier tes connaissances sur les pays ?",
                          buttonText: "Next",
                          pageController: pageController),
                        WelcomePageUtils(
                          index: 2,
                          title: 'Choisis un mode de jeu!',
                          imagePath: 'assets/worldMap.png',
                          subtitle: 'Réponds aux questions le plus vite possible ⏳,Gagne des points et grimpe dans le classement ! 🏆',
                          buttonText: 'Next',
                          pageController: pageController
                        ),
                        WelcomePageUtils(
                          index: 3,
                          title:'Es-tu prêt à relever le défi ?',
                          imagePath: 'assets/earthFromSpaceOnAfrica.png',
                          subtitle: ' Let\'s go 🚀', 
                          buttonText: 'Start',
                          pageController: pageController
                        ),
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
}

