import '../../models/user_model.dart';

abstract class IAuthRepository {
  Stream<UserModel?> get authStateChanges;
  Future<UserModel?> getUserProfile(String uid);
  Future<void> login(String email, String password);
  Future<void> register(String email, String password, String name);
  Future<void> logout();
}
