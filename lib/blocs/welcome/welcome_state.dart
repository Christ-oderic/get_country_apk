part of 'welcome_bloc.dart';

abstract class WelcomeState extends Equatable {
  const WelcomeState();
  
  @override
  List<Object> get props => [];
}

final class WelcomeInitial extends WelcomeState {}

final class WelcomeLoadingState extends WelcomeState {}

final class WelcomeLoadedState extends WelcomeState {
  final bool isFirstTime;
  final int currentPage;

  const WelcomeLoadedState({this.isFirstTime = true, this.currentPage = 0});

  @override
  List<Object> get props => [isFirstTime, currentPage];
}

final class WelcomeErrorState extends WelcomeState {
  final String errorMessage;

  const WelcomeErrorState({required this.errorMessage});

  @override
  List<Object> get props => [errorMessage];
}