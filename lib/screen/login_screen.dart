import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_country_apk/blocs/auth/auth_bloc.dart';
import 'package:get_country_apk/common/colors.dart';
import 'package:get_country_apk/repositories/user_repository.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final TextEditingController emailController = TextEditingController();
    final TextEditingController passwordController = TextEditingController();
    // final TextEditingController usernameController = TextEditingController();
    final GlobalKey<FormState> formKey = GlobalKey<FormState>();
    return Scaffold(
      backgroundColor: AppColors.primaryBackground,
      body: BlocProvider(
        create: (context) => AuthBloc(
          userRepository: UserRepository()
        ),
        child: BlocListener<AuthBloc, AuthState>(
          listener: (context, state) {
            if(state is AuthAuthenticated) {
              // Navigator.of(context).pushReplacementNamed('/home');
            }
            if (state is AuthError) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text(state.message)),
              );
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
                      decoration: const InputDecoration(
                        labelText: 'Email',
                      ),  
                      validator: (value) =>
                        value == null || value.isEmpty ? 'Veuillez entrer votre email' : null,
                    ),
                    TextFormField(
                      controller: passwordController,
                      decoration: const InputDecoration(
                        labelText: 'Mot de passe',
                      ),
                      validator: (value) =>
                        value == null || value.isEmpty ? 'Veuillez entrer votre mot de passe' : null,
                      obscureText: true,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(right: 70.0, left: 70.0, top: 10.0),
                      child: Row(
                        children: [
                          ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              
                            ),
                            onPressed: () {
                              if (formKey.currentState!.validate()) {
                                context.read<AuthBloc>().add(
                                  SignInRequestedEvent(email: emailController.text.trim(), password: passwordController.text.trim()
                                  )
                                );
                              }
                            },
                            child: const Text('Se connecter'),  
                          ),     
                          SizedBox(width: 10,),                   
                          ElevatedButton(
                            onPressed: () {
                              if (formKey.currentState!.validate()) {
                                context.read<AuthBloc>().add(
                                SignUpRequestedEvent(
                                  email: emailController.text.trim(), 
                                  password: passwordController.text.trim()
                                )
                              );
                              }
                            },
                            child: const Text('Inscription'),
                          )
                        ],
                      ),
                    ),
                  ]
                )
              );
            }
          ),
        )
      )
    );
  }
}