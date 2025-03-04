part of 'auth_bloc.dart';

abstract class AuthEvent extends Equatable {
  const AuthEvent();

  @override
  List<Object> get props => [];
}

class SignUpRequestedEvent extends AuthEvent {
  final String email;
  final String password;
  final String username;

  const SignUpRequestedEvent({
    required this.email, 
    required this.password, 
    required this.username
  });

  @override
  List<Object> get props => [email, password, username];
}

class SignInRequestedEvent extends AuthEvent {
  final String email;
  final String password;

  const SignInRequestedEvent({
    required this.email, 
    required this.password
  });

  @override
  List<Object> get props => [email, password];
}

class SignOutRequestedEvent extends AuthEvent {
  
}