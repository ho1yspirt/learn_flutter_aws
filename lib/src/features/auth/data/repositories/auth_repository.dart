import 'package:amazon_cognito_identity_dart_2/cognito.dart';

import '../../../../core/services/cognito/cognito_service.dart';
import '../datasources/auth_datasource.dart';

abstract interface class AuthRepository {
  Future<void> login({
    required String email,
    required String password,
  });

  Future<void> logout();

  Future<CognitoUserSession?> restoreSession();

  Future<CognitoUserSession?> refreshSession();
}

class AuthRepository$Impl implements AuthRepository {
  const AuthRepository$Impl(
    this._cognitoService,
    this._authDataSource,
  );

  final CognitoService _cognitoService;
  final AuthDataSource _authDataSource;

  @override
  Future<void> login({
    required String email,
    required String password,
  }) async {
    try {
      final AuthenticationDetails authenticationDetails = AuthenticationDetails(
        username: email,
        password: password,
      );

      await _cognitoService.authenticateUserSession(
        username: email,
        authenticationDetails: authenticationDetails,
      );

      await _authDataSource.setUsername(email);
      await _authDataSource.setIdToken(_cognitoService.userSession!.idToken.getJwtToken()!);
      await _authDataSource.setAccessToken(_cognitoService.userSession!.accessToken.getJwtToken()!);
      await _authDataSource.setRefreshToken(_cognitoService.userSession!.refreshToken!.getToken()!);
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<void> logout() async {
    try {
      await _cognitoService.user?.signOut();

      await _authDataSource.deleteUsername();
      await _authDataSource.deleteIdToken();
      await _authDataSource.deleteAccessToken();
      await _authDataSource.deleteRefreshToken();
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<CognitoUserSession?> restoreSession() async {
    try {
      final String? username = await _authDataSource.getUsername();
      final String? idToken = await _authDataSource.getIdToken();
      final String? accessToken = await _authDataSource.getAccessToken();
      final String? refreshToken = await _authDataSource.getRefreshToken();

      // TODO: Prettify condition check
      if (username != null && idToken != null && accessToken != null && refreshToken != null) {
        await _cognitoService.initializeUserSession(
          username: username,
          idToken: idToken,
          accessToken: accessToken,
          refreshToken: refreshToken,
        );

        return _cognitoService.userSession;
      }

      return null;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<CognitoUserSession?> refreshSession() async {
    try {
      await _cognitoService.refreshSession();

      return _cognitoService.userSession;
    } catch (e) {
      rethrow;
    }
  }
}
