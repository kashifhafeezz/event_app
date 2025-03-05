import 'package:event_app/core/localization/l10n/l10n.dart';
import 'package:event_app/features/auth/presentation/widget/auth_header_widget.dart';
import 'package:event_app/features/auth/presentation/widget/auth_validation.dart';
import 'package:event_app/utils/common/app_button.dart';
import 'package:event_app/utils/common/app_drop_down.dart';
import 'package:event_app/utils/common/app_text_field.dart';
import 'package:event_app/utils/contants/app_const.dart';
import 'package:event_app/utils/contants/app_snack_bar.dart';
import 'package:event_app/utils/contants/app_utils.dart';
import 'package:event_app/utils/extension/context_extension.dart';
import 'package:event_app/utils/navigation/app_navigation.dart';
import 'package:event_app/utils/theme/app_text_styles.dart';
import 'package:flutter/material.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final formkey = GlobalKey<FormState>();
  final fullNameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final mobileNumberController = TextEditingController();
  final instagramController = TextEditingController();
  final tiktokController = TextEditingController();
  final obscureTextNotifier = ValueNotifier(true);
  final userConsent = ValueNotifier<bool>(false);
  final selectedSpeciality = ValueNotifier<String?>(null);
  final selectedCountry = ValueNotifier<String?>(null);

  @override
  void dispose() {
    obscureTextNotifier.dispose();
    userConsent.dispose();
    selectedSpeciality.dispose();
    selectedCountry.dispose();
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
                        AuthHeaderWidget(title: context.l10n.registration),
                        _fields(context),
                        _userConsentCheckBox(),
                        AppButton(
                          text: context.l10n.register,
                          onPressed: () {
                            if (formkey.currentState?.validate() ?? false) {
                              AppSnackBar().showSuccessSnackBar(
                                context: context,
                                successMessage:
                                    context.l10n.registered_successfully,
                              );
                            } else {
                              AppSnackBar().showErrorSnackBar(
                                context: context,
                                errorMessage:
                                    context.l10n.fill_out_all_the_fields,
                              );
                            }
                          },
                        ),
                        const SizedBox(height: 30),
                        GestureDetector(
                          onTap: () {
                            AppNavigation().navigateBack(context: context);
                          },
                          behavior: HitTestBehavior.opaque,
                          child: Text(
                            context.l10n.login_to_an_account,
                            style: AppTextStyles()
                                .titleSmallTextStyle(
                                  context: context,
                                  textColor:
                                      Colors.black.withValues(alpha: 0.7),
                                )
                                ?.copyWith(fontWeight: AppFontWeight().regular),
                          ),
                        ),
                        const SizedBox(height: 15),
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
            controller: fullNameController,
            title: context.l10n.full_name,
            hintText: context.l10n.full_name_hint,
            validator: AuthValidation().validateFullName,
          ),
          const SizedBox(height: 15),
          AppTextField(
            controller: emailController,
            title: context.l10n.email,
            hintText: context.l10n.enter_a_email,
            validator: AuthValidation().validateEmail,
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
                validator: AuthValidation().validatePassword,
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
              );
            },
          ),
          const SizedBox(height: 15),
          ValueListenableBuilder<String?>(
            valueListenable: selectedSpeciality,
            builder: (context, value, child) {
              return AppDropdown<String>(
                title: context.l10n.select_speciality,
                items: AppUtils().specialityListEn,
                selectedValue: value,
                hintText: context.l10n.select_speciality_hint,
                onChanged: (newValue) {
                  selectedSpeciality.value = newValue;
                },
                validator: AuthValidation().validateSpeciality,
              );
            },
          ),
          const SizedBox(height: 15),
          ValueListenableBuilder<String?>(
            valueListenable: selectedCountry,
            builder: (context, value, child) {
              return AppDropdown<String>(
                title: context.l10n.select_country,
                items: AppUtils().countriesEn,
                selectedValue: value,
                hintText: context.l10n.select_country_hint,
                onChanged: (newValue) {
                  selectedCountry.value = newValue;
                },
                validator: AuthValidation().validateCountry,
              );
            },
          ),
          const SizedBox(height: 15),
          AppTextField(
            controller: mobileNumberController,
            title: '${context.l10n.mobile_number} (${context.l10n.optional})',
            hintText: context.l10n.mobile_number_hint,
          ),
          const SizedBox(height: 15),
          AppTextField(
            controller: instagramController,
            title: '${context.l10n.instagram} @ (${context.l10n.optional})',
            hintText: context.l10n.instagram_hint,
          ),
          const SizedBox(height: 15),
          AppTextField(
            controller: tiktokController,
            title: '${context.l10n.tiktok} @ (${context.l10n.optional})',
            hintText: context.l10n.tiktok_hint,
          ),
        ],
      ),
    );
  }

  Widget _userConsentCheckBox() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 25),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ValueListenableBuilder<bool>(
            valueListenable: userConsent,
            builder: (context, isChecked, child) {
              return Transform.scale(
                scale: 1.5,
                child: Checkbox(
                  checkColor: Colors.white,
                  value: isChecked,
                  shape: const CircleBorder(),
                  side: BorderSide(
                    width: 1.3,
                    color: Colors.grey.shade600,
                  ),
                  onChanged: (bool? value) {
                    userConsent.value = !isChecked;
                  },
                ),
              );
            },
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Text(
              context.l10n.user_consent,
              style: AppTextStyles()
                  .labelSmallTextStyle(context: context)
                  ?.copyWith(
                    fontWeight: AppFontWeight().regular,
                  ),
            ),
          ),
        ],
      ),
    );
  }
}
