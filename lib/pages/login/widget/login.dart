import 'package:bti_test_app/commons/loading_widget.dart';
import 'package:bti_test_app/commons/visibility.dart';
import 'package:bti_test_app/provider/user_provider.dart';
import 'package:bti_test_app/router/constants.dart';
import 'package:bti_test_app/services/assets.dart';
import 'package:bti_test_app/services/color_theme.dart';
import 'package:bti_test_app/services/snackbar.dart';
import 'package:bti_test_app/services/test_key.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LoginContent extends StatefulWidget {
  const LoginContent({super.key});

  @override
  State<LoginContent> createState() => _LoginContentState();
}

class _LoginContentState extends State<LoginContent> {
  bool _loading = false;
  set loading(bool value) {
    setState(() => _loading = value);
  }

  void loginGoogle() async {
    final prov = Provider.of<UserProvider>(context, listen: false);
    loading = true;
    try {
      final result = await prov.signInWithGoogle();
      if (!mounted) return;
      if (result != null) {
        Navigator.pushNamedAndRemoveUntil(context, mainRoute, (route) => false);
      }
    } catch (e) {
      if (!mounted) return;
      showSnackBar(context, e.toString());
    }
    loading = false;
  }

  void onTapGuest() {
    Navigator.pushNamed(context, mainRoute);
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final textTheme = Theme.of(context).textTheme;
    return Container(
      margin: EdgeInsets.only(top: (screenHeight * 0.4) - 50.0),
      padding: EdgeInsets.all(42.0),
      decoration: BoxDecoration(
        color: white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(50.0)),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            children: [
              Text(
                'Welcome',
                style: textTheme.displayMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text('Sign in to your account', style: textTheme.titleLarge),
              SizedBox(height: 32.0),
              VisibilityWidget(
                visible: !_loading,
                replacement: Center(child: LoadingWidget()),
                child: Material(
                  child: InkWell(
                    onTap: loginGoogle,
                    borderRadius: BorderRadius.all(Radius.circular(30.0)),
                    child: Container(
                      padding: EdgeInsets.all(8.0),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(30.0)),
                        border: Border.all(color: grey),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset(iconGoogle),
                          SizedBox(width: 12.0),
                          Text(
                            'Sign in with Google',
                            style: textTheme.titleLarge?.copyWith(
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
          Visibility(
            visible: !_loading,
            replacement: Container(),
            child: InkWell(
              key: keyLoginBtn,
              onTap: onTapGuest,
              child: Container(
                padding: EdgeInsets.only(bottom: 32.0),
                child: Text(
                  'Continue as guest',
                  style: textTheme.titleLarge?.copyWith(color: primaryColor),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
