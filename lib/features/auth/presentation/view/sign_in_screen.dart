import 'package:event_app/core/localization/l10n/l10n.dart';
import 'package:event_app/features/auth/presentation/widget/auth_header_widget.dart';
import 'package:event_app/features/auth/presentation/widget/auth_validation.dart';
import 'package:event_app/utils/common/app_button.dart';
import 'package:event_app/utils/common/app_text_field.dart';
import 'package:event_app/utils/contants/app_const.dart';
import 'package:event_app/utils/contants/app_snack_bar.dart';
import 'package:event_app/utils/extension/context_extension.dart';
import 'package:event_app/utils/navigation/app_navigation.dart';
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
  final ValueNotifier<bool> obscureTextNotifier = ValueNotifier(true);
  final formkey = GlobalKey<FormState>();

  @override
  void dispose() {
    obscureTextNotifier.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.theme.scaffoldBackgroundColor,
      body: SafeArea(
        child: LayoutBuilder(
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
                        AuthHeaderWidget(title: context.l10n.login),
                        _fields(context),
                        const SizedBox(height: 32),
                        AppButton(
                          text: context.l10n.login_small,
                          onPressed: () {
                            if (formkey.currentState?.validate() ?? false) {
                              AppSnackBar().showSuccessSnackBar(
                                context: context,
                                successMessage: context.l10n.login_successfully,
                              );
                            } else {
                              AppSnackBar().showErrorSnackBar(
                                context: context,
                                errorMessage: context.l10n.make_sure_to_provide,
                              );
                            }
                          },
                        ),
                        const SizedBox(height: 30),
                        Text(
                          '${context.l10n.forget_password}?',
                          style: AppTextStyles()
                              .titleSmallTextStyle(
                                context: context,
                                textColor: Colors.black.withValues(alpha: 0.7),
                              )
                              ?.copyWith(fontWeight: AppFontWeight().regular),
                        ),
                        const SizedBox(height: 15),
                        GestureDetector(
                          onTap: () {
                            AppNavigation().navigateToSignUp(context: context);
                          },
                          behavior: HitTestBehavior.opaque,
                          child: Text(
                            context.l10n.create_an_account,
                            style: AppTextStyles()
                                .titleSmallTextStyle(
                                  context: context,
                                  textColor:
                                      Colors.black.withValues(alpha: 0.7),
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
      ),
    );
  }

  Widget _fields(BuildContext context) {
    return Form(
      key: formkey,
      child: Column(
        children: [
          AppTextField(
            controller: emailController,
            title: context.l10n.email,
            hintText: context.l10n.enter_a_email,
            validator: AuthValidation().validateSignInEmail,
          ),
          const SizedBox(height: 15),
          ValueListenableBuilder<bool>(
            valueListenable: obscureTextNotifier,
            builder: (context, obscureText, child) {
              return AppTextField(
                controller: passwordController,
                title: context.l10n.password,
                hintText: context.l10n.enter_a_password,
                obscureText: obscureText,
                suffixIcon: IconButton(
                  icon: Icon(
                    obscureText
                        ? Icons.visibility_off_rounded
                        : Icons.visibility_rounded,
                    size: 20,
                  ),
                  onPressed: () {
                    obscureTextNotifier.value = !obscureText;
                  },
                ),
                validator: AuthValidation().validateSignInPassword,
              );
            },
          ),
        ],
      ),
    );
  }
}
