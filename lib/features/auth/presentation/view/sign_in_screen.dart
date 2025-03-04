import 'package:event_app/core/localization/l10n/l10n.dart';
import 'package:event_app/gen/assets.gen.dart';
import 'package:event_app/utils/common/app_button.dart';
import 'package:event_app/utils/common/app_text_field.dart';
import 'package:event_app/utils/contants/app_const.dart';
import 'package:event_app/utils/extension/context_extension.dart';
import 'package:event_app/utils/theme/app_text_styles.dart';
import 'package:flutter/material.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final formkey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.theme.scaffoldBackgroundColor,
      body: LayoutBuilder(
        builder: (context, constraints) {
          return SingleChildScrollView(
            child: ConstrainedBox(
              constraints: BoxConstraints(
                minHeight: constraints.maxHeight,
              ),
              child: IntrinsicHeight(
                child: Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: AppConst().screenHorizontalPadding,
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(15),
                        child: Assets.images.ldbMeLogo.image(
                          width: 120,
                          height: 120,
                          fit: BoxFit.fill,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 50),
                        child: Text(
                          context.l10n.login,
                          style: AppTextStyles()
                              .titleMediumTextStyle(context: context),
                        ),
                      ),
                      Form(
                        key: formkey,
                        child: Column(
                          children: [
                            AppTextField(
                              controller: emailController,
                              title: 'Email',
                              hintText: 'Enter a email',
                            ),
                            const SizedBox(height: 15),
                            AppTextField(
                              controller: passwordController,
                              title: 'Password',
                              hintText: 'Enter a password',
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 32),
                      const AppButton(text: 'Login'),
                      const SizedBox(height: 26),
                      Text(
                        'Forget Password?',
                        style: AppTextStyles()
                            .titleSmallTextStyle(
                              context: context,
                              textColor: Colors.black.withValues(alpha: 0.7),
                            )
                            ?.copyWith(fontWeight: AppFontWeight().regular),
                      ),
                      const SizedBox(height: 12),
                      GestureDetector(
                        onTap: () {},
                        behavior: HitTestBehavior.opaque,
                        child: Text(
                          'Or Create an Account',
                          style: AppTextStyles()
                              .titleSmallTextStyle(
                                context: context,
                                textColor: Colors.black.withValues(alpha: 0.7),
                              )
                              ?.copyWith(fontWeight: AppFontWeight().regular),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
