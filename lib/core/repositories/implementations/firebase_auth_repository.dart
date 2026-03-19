import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../../models/user_model.dart';
import '../interfaces/i_auth_repository.dart';

class FirebaseAuthRepository implements IAuthRepository {
  final FirebaseAuth _auth;
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  FirebaseAuthRepository(this._auth);

  @override
  Stream<UserModel?> get authStateChanges {
    return _auth.authStateChanges().asyncMap((user) {
      if (user == null) return null;
      return getUserProfile(user.uid);
    });
  }

  @override
  Future<UserModel?> getUserProfile(String uid) async {
    final doc = await _db.collection('users').doc(uid).get();
    if (doc.exists) {
      return UserModel.fromMap(doc.data()!, doc.id);
    }
    return null;
  }

  @override
  Future<void> login(String email, String password) async {
    await _auth.signInWithEmailAndPassword(email: email, password: password);
  }

  @override
  Future<void> register(String email, String password, String name) async {
    final credential = await _auth.createUserWithEmailAndPassword(email: email, password: password);
    if (credential.user != null) {
      final userModel = UserModel(
        id: credential.user!.uid,
        email: email,
        name: name,
        plan: 'free',
        tokenUsage: 0,
        createdAt: DateTime.now(),
      );
      await _db.collection('users').doc(userModel.id).set(userModel.toMap());
    }
  }

  @override
  Future<void> logout() async {
    await _auth.signOut();
  }
}
