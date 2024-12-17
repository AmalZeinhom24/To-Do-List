/*
import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:todo/screens/login/login.dart';
import 'package:todo/screens/settings/widgets/action_buttons.dart';
import 'package:todo/screens/settings/widgets/edit_items.dart';
import 'package:todo/shared/styles/colors.dart';

class EditAccountScreen extends StatefulWidget {
  const EditAccountScreen({super.key});

  @override
  State<EditAccountScreen> createState() => _EditAccountScreenState();
}

class _EditAccountScreenState extends State<EditAccountScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(
              Ionicons.chevron_back_outline,
            )),
        leadingWidth: 50,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Account',
                  style: TextStyle(fontSize: 36, fontWeight: FontWeight.bold)),
              SizedBox(height: 40),
              EditItems(
                title: 'Photo',
                widget: Column(
                  children: [
                    Image.asset(
                      'assets/images/avatar.png',
                      height: 100,
                      width: 100,
                    ),
                    TextButton(
                      style: TextButton.styleFrom(
                          foregroundColor: Colors.lightBlueAccent),
                      onPressed: () {},
                      child: Text(
                        'Upload Image',
                        style: TextStyle(
                            color: Colors.blue,
                            fontWeight: FontWeight.w600,
                            fontSize: 20),
                      ),
                    )
                  ],
                ),
              ),
              EditItems(title: "Name", widget: TextField()),
              SizedBox(height: 20),
              EditItems(title: "Email", widget: TextField()),
              SizedBox(height: 20),
              EditItems(title: "Password", widget: TextField()),
              SizedBox(height: 40),
              Row(
                children: [
                  ActionButtons(title: 'Delete Account'),
                  Spacer(),
                  ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.blue,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15),
                          )),
                      onPressed: () {
                        Navigator.pushReplacement(context,
                            MaterialPageRoute(builder: (context) {
                          return LoginScreen();
                        }));
                      },
                      child: Text(
                        'Logout',
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 20),
                      ))
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
*/
import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';
import 'package:provider/provider.dart';
import 'package:todo/screens/login/login.dart';
import 'package:todo/screens/settings/widgets/buttons.dart';
import 'package:todo/screens/settings/widgets/edit_fields.dart';
import 'package:todo/screens/settings/widgets/profile_image.dart';

import '../../provider/account_provider.dart';

class EditAccountScreen extends StatefulWidget {
  const EditAccountScreen({super.key});

  @override
  State<EditAccountScreen> createState() => _EditAccountScreenState();
}

class _EditAccountScreenState extends State<EditAccountScreen> {
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<AccountProvider>().loadUserProfile();
    });
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: Icon(Ionicons.chevron_back_outline),
        ),
        leadingWidth: 50,
      ),
      body: Consumer<AccountProvider>(
        builder: (context, provider, _) {
          if (provider.isLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          if (provider.error != null) {
            return Center(child: Text(provider.error!));
          }

          final profile = provider.userProfile;
          if (profile == null) {
            return const Center(child: Text('No profile data available'));
          }

          // Update controllers with current values
          _nameController.text = profile.name;
          _emailController.text = profile.email;

          return SingleChildScrollView(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Account',
                  style: TextStyle(fontSize: 36, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 40),
                ProfileImage(
                  imageUrl: profile.photoUrl,
                  onUpload: (url) => provider.updateProfile(photoUrl: url),
                ),
                const SizedBox(height: 20),
                EditField(
                  title: 'Name',
                  controller: _nameController,
                  onChanged: (value) => provider.updateProfile(name: value),
                ),
                const SizedBox(height: 20),
                EditField(
                  title: 'Email',
                  controller: _emailController,
                  onChanged: (value) => provider.updateProfile(email: value),
                ),
                const SizedBox(height: 20),
                EditField(
                  title: 'Password',
                  controller: _passwordController,
                  isPassword: true,
                  onChanged: (value) => provider.updatePassword(value),
                ),
                const SizedBox(height: 40),
                _buildActionButtons(context, provider),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildActionButtons(BuildContext context, AccountProvider provider) {
    return Row(
      children: [
        ActionButton(
          title: 'Delete Account',
          onPressed: () => _showDeleteConfirmation(context, provider),
        ),
        const Spacer(),
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.blue,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15),
            ),
            padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
          ),
          onPressed: () => _handleLogout(context, provider),
          child: const Text(
            'Logout',
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 20,
            ),
          ),
        ),
      ],
    );
  }

  Future<void> _showDeleteConfirmation(
      BuildContext context,
      AccountProvider provider,
      ) async {
    final confirm = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Delete Account'),
        content: const Text(
          'Are you sure you want to delete your account? This action cannot be undone.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context, true),
            child: const Text('Delete'),
          ),
        ],
      ),
    );

    if (confirm == true) {
      await provider.deleteAccount();
      _navigateToLogin(context);
    }
  }

  Future<void> _handleLogout(
      BuildContext context,
      AccountProvider provider,
      ) async {
    await provider.signOut();
    _navigateToLogin(context);
  }

  void _navigateToLogin(BuildContext context) {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (_) => LoginScreen()),
    );
  }
}