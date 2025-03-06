import 'package:event_app/core/localization/l10n/l10n.dart';
import 'package:event_app/features/auth/data/models/request_model/login_request_model.dart';
import 'package:event_app/features/auth/presentation/manager/login_bloc/login_bloc.dart';
import 'package:event_app/features/auth/presentation/widget/auth_header_widget.dart';
import 'package:event_app/features/auth/presentation/widget/auth_validation.dart';
import 'package:event_app/utils/common/app_button.dart';
import 'package:event_app/utils/common/app_text_field.dart';
import 'package:event_app/utils/constants/app_const.dart';
import 'package:event_app/utils/constants/app_snack_bar.dart';
import 'package:event_app/utils/di/di_container.dart';
import 'package:event_app/utils/extension/context_extension.dart';
import 'package:event_app/utils/navigation/app_navigation.dart';
import 'package:event_app/utils/theme/app_text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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
  late LoginBloc loginBloc;

  @override
  void initState() {
    loginBloc = di.get<LoginBloc>();
    super.initState();
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
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
                        _loginButton(context),
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

  Widget _loginButton(BuildContext context) {
    return BlocProvider.value(
      value: loginBloc,
      child: BlocConsumer<LoginBloc, LoginState>(
        listener: (context, state) {
          if (state is LoginErrorState) {
            AppSnackBar().showErrorSnackBar(
              context: context,
              errorMessage: state.errorMessage,
            );
          }

          if (state is LoginLoadedState) {
            AppSnackBar().showSuccessSnackBar(
              context: context,
              successMessage: context.l10n.login_successfully,
            );

            AppNavigation().navigateToHome(context: context);
          }
        },
        builder: (context, state) {
          return AppButton(
            text: context.l10n.login_small,
            isLoading: state is LoginLoadingState,
            onPressed: () {
              if (formkey.currentState?.validate() ?? false) {
                loginBloc.add(
                  LoginUserEvent(
                    requestModel: LoginRequestModel(
                      email: emailController.text,
                      password: passwordController.text,
                    ),
                  ),
                );
              } else {
                AppSnackBar().showErrorSnackBar(
                  context: context,
                  errorMessage: context.l10n.make_sure_to_provide,
                );
              }
            },
          );
        },
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
            validator: (v) {
              return AuthValidation().validateSignInEmail(v, context);
            },
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
                validator: (v) {
                  return AuthValidation().validateSignInPassword(v, context);
                },
              );
            },
          ),
        ],
      ),
    );
  }
}
