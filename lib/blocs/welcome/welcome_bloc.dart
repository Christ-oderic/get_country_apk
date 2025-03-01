import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'welcome_event.dart';
part 'welcome_state.dart';

class WelcomeBloc extends Bloc<WelcomeEvent, WelcomeState> {
  WelcomeBloc() : super(WelcomeInitial()) {
    on<LoadWelcomePageEvent>(_onLoadWelcomePage);
    on<NavigateFromWelcomeEvent>(_onNavigateFromWelcome);
    on<MarkAppAsOpenedEvent>(_onMarkAppAsOpenedEvent); 
  }

  Future<void> _onLoadWelcomePage(WelcomeEvent event, Emitter<WelcomeState> emit) async {
    try {
      emit(WelcomeLoadedState());
      final bool isFirstTime = true;
      emit(WelcomeLoadedState(isFirstTime: isFirstTime));
    } catch (e) {
      emit(WelcomeErrorState(errorMessage: 'Failed to load welcome page:${e.toString()}'));
    }
  }

  Future<void> _onNavigateFromWelcome(WelcomeEvent event, Emitter<WelcomeState> emit) async {

  }

  Future<void> _onMarkAppAsOpenedEvent(WelcomeEvent event, Emitter<WelcomeState> emit) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setBool('isFirstTime', false);
      emit(WelcomeLoadedState(isFirstTime: false));
    } catch (e) {
      emit(WelcomeErrorState(errorMessage: 'Failed to mark app as opened:${e.toString()}'));
    }
  }

  // Future<bool> _checkIfFirstTime() async {
  //   try {
  //     final prefs = await SharedPreferences.getInstance();
  //     return prefs.getBool('isFirstTime') ?? true;
  //   } catch (e) {
  //     return true;
  //   }
    
  // }

}
