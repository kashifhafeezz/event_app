import 'package:event_app/core/localization/l10n/l10n.dart';
import 'package:flutter/material.dart';

class AuthValidation {
  factory AuthValidation() => _singleton;
  AuthValidation._internal();
  static final AuthValidation _singleton = AuthValidation._internal();

  ///--------- Sign up Validation ----------///

  String? validateFullName(String? value, BuildContext context) {
    if (value == null || value.isEmpty) {
      return context.l10n.full_name_required;
    }
    return null;
  }

  String? validateEmail(String? value, BuildContext context) {
    if (value == null || value.isEmpty) {
      return context.l10n.email_required;
    }
    final emailRegex = RegExp(r'^[^@]+@[^@]+\.[^@]+');
    if (!emailRegex.hasMatch(value)) {
      return context.l10n.valid_email;
    }
    return null;
  }

  String? validatePassword(String? value, BuildContext context) {
    if (value == null || value.isEmpty) {
      return context.l10n.password_required;
    }
    if (value.length < 6) {
      return context.l10n.valid_password;
    }
    return null;
  }

  String? validateSpeciality(String? value, BuildContext context) {
    if (value == null || value.isEmpty) {
      return context.l10n.please_select_speciality;
    }
    return null;
  }

  String? validateCountry(String? value, BuildContext context) {
    if (value == null || value.isEmpty) {
      return context.l10n.please_select_country;
    }
    return null;
  }

  ///--------- Sign In Validation ----------///

  String? validateSignInEmail(String? value, BuildContext context) {
    if (value == null || value.isEmpty) {
      return context.l10n.email_required;
    }
    return null;
  }

  String? validateSignInPassword(String? value, BuildContext context) {
    if (value == null || value.isEmpty) {
      return context.l10n.password_required;
    }

    return null;
  }
}
