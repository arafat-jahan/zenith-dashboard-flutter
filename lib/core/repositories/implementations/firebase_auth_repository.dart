import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import '../../models/user_model.dart';
import '../interfaces/i_auth_repository.dart';

class FirebaseAuthRepository implements IAuthRepository {
  final FirebaseAuth _auth;
  final FirebaseFirestore _db = FirebaseFirestore.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();

  FirebaseAuthRepository(this._auth);

  @override
  Stream<User?> get authStateChanges {
    return _auth.authStateChanges();
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
      await credential.user!.sendEmailVerification();
      
      final userModel = UserModel(
        id: credential.user!.uid,
        email: email,
        name: name,
        plan: 'free',
        tokenUsage: 0,
        credits: 5,
        role: 'user',
        createdAt: DateTime.now(),
      );
      await _db.collection('users').doc(userModel.id).set(userModel.toMap());
    }
  }

  @override
  Future<void> signInWithGoogle() async {
    try {
      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
      if (googleUser == null) return;
      
      final GoogleSignInAuthentication googleAuth = await googleUser.authentication;
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );
      
      final userCredential = await _auth.signInWithCredential(credential);
      
      if (userCredential.additionalUserInfo?.isNewUser == true) {
        final userModel = UserModel(
          id: userCredential.user!.uid,
          email: userCredential.user!.email!,
          name: userCredential.user!.displayName ?? 'Google User',
          plan: 'free',
          tokenUsage: 0,
          credits: 5,
          role: 'user',
          createdAt: DateTime.now(),
        );
        await _db.collection('users').doc(userModel.id).set(userModel.toMap());
      }
    } catch (e) {
      throw Exception('Google Sign-In failed: ${e.toString()}');
    }
  }

  @override
  Future<void> signInWithApple() async {
    try {
      final appleProvider = AppleAuthProvider();
      appleProvider.addScope('email');
      appleProvider.addScope('name');
      
      final userCredential = await _auth.signInWithProvider(appleProvider);
      
      if (userCredential.additionalUserInfo?.isNewUser == true) {
        final userModel = UserModel(
          id: userCredential.user!.uid,
          email: userCredential.user!.email ?? '',
          name: userCredential.user!.displayName ?? 'Apple User',
          plan: 'free',
          tokenUsage: 0,
          credits: 5,
          role: 'user',
          createdAt: DateTime.now(),
        );
        await _db.collection('users').doc(userModel.id).set(userModel.toMap());
      }
    } catch (e) {
      throw Exception('Apple Sign-In failed: ${e.toString()}');
    }
  }

  @override
  Future<void> sendEmailVerification() async {
    final user = _auth.currentUser;
    if (user != null && !user.emailVerified) {
      await user.sendEmailVerification();
    }
  }

  @override
  Future<bool> isEmailVerified() async {
    final user = _auth.currentUser;
    if (user == null) return false;
    
    await user.reload();
    return user.emailVerified;
  }

  @override
  Future<void> logout() async {
    await _auth.signOut();
  }
}
