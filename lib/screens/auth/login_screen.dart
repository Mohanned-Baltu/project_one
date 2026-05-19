import 'package:flutter/material.dart';

import '../../core/localization/app_localizations.dart';
import '../../core/navigation/app_routes.dart';
import '../../widgets/app_text_field.dart';
import '../../widgets/cookly_logo.dart';
import '../../widgets/primary_button.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _phoneController = TextEditingController();
  final _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool _hidePassword = true;
  bool _submitted = false;

  @override
  void dispose() {
    _phoneController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _submit() {
    setState(() => _submitted = true);
    final valid = _formKey.currentState?.validate() ?? false;
    if (!valid) return;
    Navigator.pushNamedAndRemoveUntil(
      context,
      AppRoutes.home,
      (route) => false,
    );
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final colorScheme = Theme.of(context).colorScheme;
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(20, 24, 20, 20),
          child: Form(
            key: _formKey,
            autovalidateMode: _submitted
                ? AutovalidateMode.onUserInteraction
                : AutovalidateMode.disabled,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(child: Column(children: [const CooklyLogo(size: 205)])),
                const SizedBox(height: 28),
                Text(
                  l10n.tr('beginnerChef'),
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    color: colorScheme.onSurfaceVariant,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  l10n.tr('welcomeBack'),
                  style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                    color: colorScheme.onSurfaceVariant,
                  ),
                ),
                const SizedBox(height: 20),
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: colorScheme.surfaceContainerLowest,
                    borderRadius: BorderRadius.circular(24),
                  ),
                  child: Column(
                    children: [
                      AppTextField(
                        controller: _phoneController,
                        hintText: l10n.tr('phoneNumber'),
                        keyboardType: TextInputType.phone,
                        prefixIcon: Icons.phone_outlined,
                        textInputAction: TextInputAction.next,
                        validator: (value) {
                          final text = value?.trim() ?? '';
                          if (text.isEmpty) return l10n.tr('requiredField');
                          final digits = text.replaceAll(
                            RegExp(r'[^0-9+]'),
                            '',
                          );
                          if (digits.length < 7) return l10n.tr('invalidPhone');
                          return null;
                        },
                      ),
                      const SizedBox(height: 14),
                      AppTextField(
                        controller: _passwordController,
                        hintText: l10n.tr('password'),
                        obscureText: _hidePassword,
                        prefixIcon: Icons.lock_outline_rounded,
                        validator: (value) {
                          final text = value ?? '';
                          if (text.isEmpty) return l10n.tr('requiredField');
                          if (text.length < 6) {
                            return l10n.tr('passwordTooShort');
                          }
                          return null;
                        },
                        suffixIcon: IconButton(
                          onPressed: () =>
                              setState(() => _hidePassword = !_hidePassword),
                          icon: Icon(
                            _hidePassword
                                ? Icons.visibility_outlined
                                : Icons.visibility_off_outlined,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 10),
                Align(
                  alignment: AlignmentDirectional.centerEnd,
                  child: TextButton(
                    onPressed: () {},
                    child: Text(l10n.tr('forgotPassword')),
                  ),
                ),
                const SizedBox(height: 24),
                PrimaryButton(
                  text: l10n.tr('login'),
                  onPressed: _submit,
                  icon: Icons.login_rounded,
                ),
                const SizedBox(height: 14),
                Row(
                  children: [
                    Expanded(child: Divider(color: colorScheme.outlineVariant)),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: Text(
                        l10n.tr('or'),
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: colorScheme.onSurfaceVariant,
                        ),
                      ),
                    ),
                    Expanded(child: Divider(color: colorScheme.outlineVariant)),
                  ],
                ),
                const SizedBox(height: 14),
                SizedBox(
                  width: double.infinity,
                  height: 48,
                  child: OutlinedButton.icon(
                    onPressed: () {},
                    icon: Container(
                      width: 24,
                      height: 24,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: colorScheme.primaryContainer,
                        shape: BoxShape.circle,
                      ),
                      child: Text(
                        'G',
                        style: TextStyle(
                          color: colorScheme.primary,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                    ),
                    label: Text(l10n.tr('continueWithGoogle')),
                    style: OutlinedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                      side: BorderSide(color: colorScheme.outlineVariant),
                    ),
                  ),
                ),
                const SizedBox(height: 18),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(l10n.tr('dontHaveAccount')),
                    TextButton(
                      onPressed: () =>
                          Navigator.pushNamed(context, AppRoutes.signup),
                      child: Text(l10n.tr('signup')),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
