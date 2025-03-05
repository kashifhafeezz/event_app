import 'package:event_app/gen/assets.gen.dart';
import 'package:event_app/utils/extension/context_extension.dart';
import 'package:event_app/utils/navigation/app_navigation.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 1), () {
      if (mounted) {
        AppNavigation().navigateToSignIn(context: context);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.theme.scaffoldBackgroundColor,
      body: Center(
        child: ClipRRect(
          borderRadius: BorderRadius.circular(15),
          child: Assets.images.ldbMeLogo.image(
            width: 120,
            height: 120,
            fit: BoxFit.fill,
          ),
        ),
      ),
    );
  }
}
