part of 'welcome_bloc.dart';

abstract class WelcomeEvent extends Equatable {
  const WelcomeEvent();

  @override
  List<Object> get props => [];
}

class LoadWelcomePageEvent extends WelcomeEvent {}

class NavigateFromWelcomeEvent extends WelcomeEvent {
  final String destination;

  const NavigateFromWelcomeEvent(this.destination);

  @override
  List<Object> get props => [destination];
}

class MarkAppAsOpenedEvent extends WelcomeEvent {}
class UpdateWelcomePageEvent extends WelcomeEvent {
  final int pageIndex;

  const UpdateWelcomePageEvent(this.pageIndex);

  @override
  List<Object> get props => [pageIndex];
}