import 'package:bti_test_app/provider/user_provider.dart';
import 'package:bti_test_app/router/constants.dart';
import 'package:bti_test_app/services/color_theme.dart';
import 'package:bti_test_app/services/modals.dart';
import 'package:bti_test_app/services/snackbar.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  Future<void> logout() async {
    final prov = Provider.of<UserProvider>(context, listen: false);
    Modals.loading(context: context);
    try {
      await prov.logout();
      if (!mounted) return;
      Navigator.pop(context);
      Navigator.pushNamedAndRemoveUntil(context, loginRoute, (route) => false);
    } catch (e) {
      if (!mounted) return;
      Navigator.pop(context);
      showSnackBar(context, e.toString());
    }
  }

  Widget buildButton(String title, VoidCallback onTap) {
    final textTheme = Theme.of(context).textTheme;

    return ElevatedButton(
      onPressed: onTap,
      style: ElevatedButton.styleFrom(backgroundColor: primaryColor),
      child: Container(
        padding: EdgeInsets.all(12.0),
        child: Text(
          title,
          style: textTheme.titleMedium?.copyWith(color: white),
        ),
      ),
    );
  }

  Widget guestMode() {
    final textTheme = Theme.of(context).textTheme;
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text('Guest Mode', style: textTheme.titleLarge),
          SizedBox(height: 24.0),
          buildButton('Back to Login Page', () => Navigator.pop(context)),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Scaffold(
      body: Center(
        child: Consumer<UserProvider>(
          builder: (context, prov, child) {
            final user = prov.user;
            final name = user?.name;
            final email = user?.email;

            if (user == null) return guestMode();

            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(name ?? '', style: textTheme.titleLarge),
                Container(
                  padding: EdgeInsets.symmetric(vertical: 24.0),
                  child: Text(email ?? '', style: textTheme.titleLarge),
                ),
                buildButton('Logout', logout),
              ],
            );
          },
        ),
      ),
    );
  }
}
