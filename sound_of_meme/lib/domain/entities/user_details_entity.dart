import '../../data/models/models.dart';

class UserDetailsEntity {
  final String name;
  final String email;
  String? profileUrl;

  UserDetailsEntity({
    required this.name,
    required this.email,
    this.profileUrl,
  });

  factory UserDetailsEntity.fromModel(UserDetailsResponseModel model) =>
      UserDetailsEntity(
        name: model.name,
        email: model.email,
        profileUrl: model.profileUrl,
      );
}
