import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_country_apk/blocs/auth/auth_bloc.dart';
import 'package:get_country_apk/common/colors.dart';
import 'package:get_country_apk/repositories/user_repository.dart';
import 'package:get_country_apk/screen/home_screen.dart';
import 'package:get_country_apk/utils/button_utils.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  Future<bool> checkLoginStatus() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('token');

    if (token != null) {
      DateTime tokenExpriy = DateTime.parse(prefs.getString('tokenExpriy')!);
      return tokenExpriy.isAfter(DateTime.now());
    }
    return false;
  }

  @override
  Widget build(BuildContext context) {
    final TextEditingController emailController = TextEditingController();
    final TextEditingController passwordController = TextEditingController();
    // final TextEditingController usernameController = TextEditingController();
    final GlobalKey<FormState> formKey = GlobalKey<FormState>();
    return Scaffold(
      backgroundColor: AppColors.primaryBackground,
      body: FutureBuilder<bool>(
        future: checkLoginStatus(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasData && snapshot.data == true) {
            WidgetsBinding.instance.addPostFrameCallback((_) {
              Navigator.pushReplacementNamed(context, '/home');
            });
            return const Center(child: CircularProgressIndicator());
          }
          return BlocProvider(
            create: (context) => AuthBloc(userRepository: UserRepository()),
            child: BlocListener<AuthBloc, AuthState>(
              listener: (context, state) {
                if (state is AuthAuthenticated) {
                  Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => const HomeScreen()),
                  );
                }
                if (state is AuthError) {
                  ScaffoldMessenger.of(
                    context,
                  ).showSnackBar(SnackBar(content: Text(state.message)));
                }
              },
              child: BlocBuilder<AuthBloc, AuthState>(
                builder: (context, state) {
                  return Form(
                    key: formKey,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset(
                          'assets/loginForApp.png',
                          height: 400,
                          fit: BoxFit.cover,
                        ),
                        TextFormField(
                          controller: emailController,
                          decoration: const InputDecoration(labelText: 'Email'),
                          validator:
                              (value) =>
                                  value == null || value.isEmpty
                                      ? 'Veuillez entrer votre email'
                                      : null,
                        ),
                        TextFormField(
                          controller: passwordController,
                          decoration: const InputDecoration(
                            labelText: 'Mot de passe',
                          ),
                          validator:
                              (value) =>
                                  value == null || value.isEmpty
                                      ? 'Veuillez entrer votre mot de passe'
                                      : null,
                          obscureText: true,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                            top: 10.0,
                            left: 80.0,
                            right: 80.0,
                          ),
                          child: Row(
                            children: [
                              ButtonUtils(
                                buttonText: 'Connexion',
                                onPressed: () {
                                  if (formKey.currentState!.validate()) {
                                    context.read<AuthBloc>().add(
                                      SignInRequestedEvent(
                                        email: emailController.text.trim(),
                                        password:
                                            passwordController.text.trim(),
                                      ),
                                    );
                                  }
                                },
                              ),
                              SizedBox(width: 10),
                              ButtonUtils(
                                buttonText: 'S\'inscris',
                                onPressed: () {
                                  if (formKey.currentState!.validate()) {
                                    context.read<AuthBloc>().add(
                                      SignUpRequestedEvent(
                                        email: emailController.text.trim(),
                                        password:
                                            passwordController.text.trim(),
                                      ),
                                    );
                                  }
                                },
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          );
        },
      ),
    );
  }
}
