import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:todo/models/user_profile.dart';


class AccountService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<UserProfile?> getCurrentUserProfile() async {
    final user = _auth.currentUser;
    if (user == null) return null;

    final doc = await _firestore.collection('users').doc(user.uid).get();
    if (!doc.exists) return null;

    return UserProfile.fromJson({
      'id': user.uid,
      ...doc.data()!,
    });
  }

  Future<void> updateUserProfile(UserProfile profile) async {
    final user = _auth.currentUser;
    if (user == null) throw Exception('No authenticated user');

    await _firestore.collection('users').doc(user.uid).update(profile.toJson());
  }

  Future<void> updatePassword(String newPassword) async {
    final user = _auth.currentUser;
    if (user == null) throw Exception('No authenticated user');

    await user.updatePassword(newPassword);
  }

  Future<void> deleteAccount() async {
    final user = _auth.currentUser;
    if (user == null) throw Exception('No authenticated user');

    await _firestore.collection('users').doc(user.uid).delete();
    await user.delete();
  }

  Future<void> signOut() async {
    await _auth.signOut();
  }
}