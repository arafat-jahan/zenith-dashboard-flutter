// lib/core/repositories/implementations/mock_auth_repository.dart
import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import '../../models/user_model.dart';
import '../interfaces/i_auth_repository.dart';

class MockAuthRepository implements IAuthRepository {
  final _controller = StreamController<User?>();

  MockAuthRepository() {
    _controller.add(null);
  }

  @override
  Stream<User?> get authStateChanges => _controller.stream;

  @override
  Future<UserModel?> getUserProfile(String uid) async {
    return UserModel(
      id: uid,
      email: 'demo@zenith.ai',
      name: 'Demo User',
      plan: 'pro',
      tokenUsage: 42,
      createdAt: DateTime.now(),
    );
  }

  @override
  Future<void> login(String email, String password) async {
    // For demo purposes, any login works
    _controller.add(null); // This is just for the UI to move forward
  }

  @override
  Future<void> register(String email, String password, String name) async {
    _controller.add(null);
  }

  @override
  Future<void> logout() async {
    _controller.add(null);
  }
}
