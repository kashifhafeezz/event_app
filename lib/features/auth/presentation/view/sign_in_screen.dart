import 'package:event_app/core/localization/l10n/l10n.dart';
import 'package:event_app/utils/extension/context_extension.dart';
import 'package:flutter/material.dart';

class SignInScreen extends StatelessWidget {
  const SignInScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.theme.scaffoldBackgroundColor,
      body: Center(
        child: Text(context.l10n.login),
      ),
    );
  }
}
