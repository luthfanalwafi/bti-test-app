import 'package:bti_test_app/pages/login/widget/login.dart';
import 'package:bti_test_app/router/constants.dart';
import 'package:bti_test_app/services/assets.dart';
import 'package:bti_test_app/services/snackbar.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../provider/user_provider.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  void initState() {
    super.initState();
    checkUser();
  }

  Future<void> checkUser() async {
    final prov = Provider.of<UserProvider>(context, listen: false);
    try {
      final user = await prov.getUser();
      if (!mounted) return;
      if (user != null) {
        Navigator.pushNamedAndRemoveUntil(context, mainRoute, (route) => false);
      }
    } catch (e) {
      if (!mounted) return;
      showSnackBar(context, e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      body: Stack(
        children: [
          Container(
            height: screenHeight * 0.4,
            width: double.infinity,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage(backgroundLogin),
                fit: BoxFit.cover,
              ),
            ),
          ),
          LoginContent(),
        ],
      ),
    );
  }
}
