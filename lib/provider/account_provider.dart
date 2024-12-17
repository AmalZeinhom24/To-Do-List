import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/user_profile.dart';

class AccountProvider extends ChangeNotifier {
  UserProfile? _userProfile;
  String? _error;
  bool _isLoading = false;

  UserProfile? get userProfile => _userProfile;
  String? get error => _error;
  bool get isLoading => _isLoading;

  Future<void> loadUserProfile() async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      final prefs = await SharedPreferences.getInstance();
      final userData = {
        'id': prefs.getString('user_id') ?? '',
        'name': prefs.getString('user_name') ?? '',
        'email': prefs.getString('user_email') ?? '',
        'photoUrl': prefs.getString('user_photo'),
      };

      _userProfile = UserProfile.fromJson(userData);
    } catch (e) {
      _error = 'Failed to load profile data';
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> updateProfile({String? name, String? email, String? photoUrl}) async {
    if (_userProfile == null) return;

    try {
      final prefs = await SharedPreferences.getInstance();
      if (name != null) await prefs.setString('user_name', name);
      if (email != null) await prefs.setString('user_email', email);
      if (photoUrl != null) await prefs.setString('user_photo', photoUrl);

      await loadUserProfile();
    } catch (e) {
      _error = 'Failed to update profile';
      notifyListeners();
    }
  }

  Future<void> updatePassword(String newPassword) async {
    // Implement password update logic
  }

  Future<void> deleteAccount() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.clear();
      _userProfile = null;
      notifyListeners();
    } catch (e) {
      _error = 'Failed to delete account';
      notifyListeners();
    }
  }

  Future<void> signOut() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.clear();
      _userProfile = null;
      notifyListeners();
    } catch (e) {
      _error = 'Failed to sign out';
      notifyListeners();
    }
  }
}