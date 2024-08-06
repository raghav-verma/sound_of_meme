part of 'app_bloc.dart';

abstract class AppState extends Equatable {
  const AppState();
}

class AppInitial extends AppState {
  @override
  List<Object> get props => [];
}

class LoginLoadingState extends AppState {
  @override
  List<Object> get props => [];
}

class LoginErrorState extends AppState {
  final String message;

  const LoginErrorState({required this.message});

  @override
  List<Object> get props => [message];
}

class LoginSuccessfulState extends AppState {
  @override
  List<Object> get props => [];
}

class LogOutLoadingState extends AppState {
  @override
  List<Object> get props => [];
}

class LogOutErrorState extends AppState {
  final String message;

  const LogOutErrorState({required this.message});

  @override
  List<Object> get props => [message];
}

class LogOutSuccessfulState extends AppState {
  @override
  List<Object> get props => [];
}

class SignUpLoadingState extends AppState {
  @override
  List<Object> get props => [];
}

class SignUpErrorState extends AppState {
  final String message;

  const SignUpErrorState({required this.message});

  @override
  List<Object> get props => [message];
}

class SignUpSuccessfulState extends AppState {
  @override
  List<Object> get props => [];
}

class GoogleLoginLoadingState extends AppState {
  @override
  List<Object> get props => [];
}

class GoogleLoginErrorState extends AppState {
  final String message;

  const GoogleLoginErrorState({required this.message});

  @override
  List<Object> get props => [message];
}

class GoogleLoginSuccessfulState extends AppState {
  @override
  List<Object> get props => [];
}

class UserDetailsLoadingState extends AppState {
  @override
  List<Object> get props => [];
}

class UserDetailsErrorState extends AppState {
  final String message;

  const UserDetailsErrorState({required this.message});

  @override
  List<Object> get props => [message];
}

class UserDetailsLoadedState extends AppState {
  final UserDetailsEntity userDetailsEntity;

  const UserDetailsLoadedState({required this.userDetailsEntity});

  @override
  List<Object> get props => [userDetailsEntity];
}
