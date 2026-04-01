// lib/core/models/user_model.dart
import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  final String id;
  final String email;
  final String name;
  final String? photoUrl;
  final String plan; // 'free', 'pro', 'enterprise'
  final int tokenUsage;
  final int credits; // Business logic credits
  final String role; // 'user', 'admin'
  final DateTime? createdAt;

  UserModel({
    required this.id,
    required this.email,
    required this.name,
    this.photoUrl,
    required this.plan,
    required this.tokenUsage,
    this.credits = 5,
    this.role = 'user',
    this.createdAt,
  });

  factory UserModel.fromMap(Map<String, dynamic> map, String id) {
    return UserModel(
      id: id,
      email: map['email'] ?? '',
      name: map['name'] ?? '',
      photoUrl: map['photoUrl'],
      plan: map['plan'] ?? 'free',
      tokenUsage: map['tokenUsage'] ?? 0,
      credits: map['credits'] ?? 5,
      role: map['role'] ?? 'user',
      createdAt: (map['createdAt'] as Timestamp?)?.toDate(),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'email': email,
      'name': name,
      'photoUrl': photoUrl,
      'plan': plan,
      'tokenUsage': tokenUsage,
      'credits': credits,
      'role': role,
      'createdAt': createdAt != null ? Timestamp.fromDate(createdAt!) : FieldValue.serverTimestamp(),
    };
  }

  UserModel copyWith({
    String? name,
    String? photoUrl,
    String? plan,
    int? tokenUsage,
    int? credits,
    String? role,
  }) {
    return UserModel(
      id: id,
      email: email,
      name: name ?? this.name,
      photoUrl: photoUrl ?? this.photoUrl,
      plan: plan ?? this.plan,
      tokenUsage: tokenUsage ?? this.tokenUsage,
      credits: credits ?? this.credits,
      role: role ?? this.role,
      createdAt: createdAt,
    );
  }
}
