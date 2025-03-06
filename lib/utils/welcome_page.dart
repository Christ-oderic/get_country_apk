import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_country_apk/common/colors.dart';
import 'package:get_country_apk/blocs/welcome/welcome_bloc.dart';
import 'package:get_country_apk/screen/login_screen.dart';

class WelcomePage extends StatelessWidget {
  final int index;
  final String title;
  final String imagePath;
  final String subtitle;
  final String buttonText;
  final PageController pageController;

  const WelcomePage({
    super.key,
    required this.index,
    required this.title,
    required this.imagePath,
    required this.subtitle,
    required this.buttonText,
    required this.pageController,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 70),
          child: SizedBox(
            width: 345,
            height: 345,
            child: Center(
              child: Image.asset(
                imagePath,
                fit: BoxFit.cover,
              ),
            ),
          ),
        ),
        Column(
          children: [
            SizedBox(height: 20),
            Text(
              title,
              style: TextStyle(
                color: AppColors.primaryText,
                fontSize: 26,
                fontWeight: FontWeight.normal,
              ),
            ),
            SizedBox(height: 20),
            Container(
              width: 375,
              padding: EdgeInsets.only(left: 30, right: 30),
              child: Center(
                child: Text(
                  subtitle,
                  style: TextStyle(
                    color: AppColors.primarySecondaryElementText,
                    fontSize: 18,
                    fontWeight: FontWeight.normal,
                  ),
                ),
              ),
            ),
          ],
        ),
        GestureDetector(
          onTap: () {
            if (index < 3) {
              pageController.nextPage(
                duration: const Duration(milliseconds: 500),
                curve: Curves.easeInOut,
              );
            } else {
              context.read<WelcomeBloc>().add(MarkAppAsOpenedEvent());
              Navigator.of(context).push(
                MaterialPageRoute(builder: (context) => const LoginScreen()),
              );
            }
          },
          child: Container(
            margin: const EdgeInsets.only(top: 100, left: 25, right: 25),
            width: 325,
            height: 50,
            decoration: BoxDecoration(
              color: AppColors.primaryElement,
              borderRadius: BorderRadius.all(Radius.circular(15)),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey,
                  spreadRadius: 1,
                  blurRadius: 2,
                  offset: const Offset(0, 1),
                ),
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
            ),
          ),
        ),
      ],
    );
  }
}