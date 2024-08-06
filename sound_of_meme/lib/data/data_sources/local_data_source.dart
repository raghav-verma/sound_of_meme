import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../../core/constants/constants.dart';

import '../models/models.dart';

abstract class LocalDataSource {
  Future<void> init();

  Future<void> saveUserInfo(final UserDetailsResponseModel entity);

  Future<UserDetailsResponseModel?> getUserInfo();

  Future<bool?> clearAll();

  Future<void> saveAccessToken(final String accessToken);

  Future<String?> getAccessToken();

}

class LocalDataSourceImplementation implements LocalDataSource {
  SharedPreferences? sharedPref;

  @override
  Future<void> init() async {
    sharedPref = await SharedPreferences.getInstance();
  }

  @override
  Future<void> saveUserInfo(final UserDetailsResponseModel entity) async {
    await sharedPref?.setString(
      LocalDataBaseConstants.user,
      jsonEncode(entity.toJson()),
    );
  }

  @override
  Future<UserDetailsResponseModel?> getUserInfo() async {
    final String? stringResult =
        sharedPref?.getString(LocalDataBaseConstants.user);
    if (stringResult != null) {
      return UserDetailsResponseModel.fromJson(jsonDecode(stringResult));
    }
    return null;
  }

  @override
  Future<void> saveAccessToken(final String accessToken) async {
    await sharedPref?.setString(
      LocalDataBaseConstants.accessToken,
      accessToken,
    );
  }

  @override
  Future<String?> getAccessToken() async {
    return sharedPref?.getString(LocalDataBaseConstants.accessToken);
  }

  @override
  Future<bool?> clearAll() async {
    return await sharedPref?.clear();
  }
}
