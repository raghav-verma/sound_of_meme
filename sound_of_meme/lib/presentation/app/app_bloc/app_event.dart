part of 'app_bloc.dart';

abstract class AppEvent extends Equatable {
  const AppEvent();
}

class LogInEvent extends AppEvent {
  final String email;
  final String password;

  const LogInEvent({
    required this.email,
    required this.password,
  });

  @override
  List<Object> get props => [
        email,
        password,
      ];
}

class SignUpEvent extends AppEvent {
  final String name;
  final String email;
  final String password;

  const SignUpEvent({
    required this.name,
    required this.email,
    required this.password,
  });

  @override
  List<Object> get props => [
        name,
        email,
        password,
      ];
}

class LogOutEvent extends AppEvent {
  @override
  List<Object> get props => [];
}

class GoogleLoginEvent extends AppEvent {
  final String name;
  final String email;
  final String picture;

  const GoogleLoginEvent({
    required this.name,
    required this.email,
    required this.picture,
  });

  @override
  List<Object> get props => [
        name,
        email,
        picture,
      ];
}

class GetUserDetailsEvent extends AppEvent {
  @override
  List<Object> get props => [];
}
