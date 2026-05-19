import 'package:flutter/material.dart';

import '../../core/localization/app_localizations.dart';
import '../../core/navigation/app_routes.dart';
import '../../widgets/app_text_field.dart';
import '../../widgets/cookly_logo.dart';
import '../../widgets/primary_button.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final _nameController = TextEditingController();
  final _phoneController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  bool _hidePassword = true;
  bool _hideConfirmPassword = true;
  bool _agreedToTerms = true;

  @override
  void dispose() {
    _nameController.dispose();
    _phoneController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final colorScheme = Theme.of(context).colorScheme;
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            if (Navigator.canPop(context)) {
              Navigator.pop(context);
            } else {
              Navigator.pushReplacementNamed(context, AppRoutes.login);
            }
          },
          icon: const Icon(Icons.arrow_back_ios_new_rounded),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(20, 8, 20, 20),
          child: Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 520),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                    child: Column(
                      children: [
                        const CooklyLogo(size: 185),
                        const SizedBox(height: 14),
                        Text(
                          l10n.tr('createAccount'),
                          style: Theme.of(context).textTheme.headlineMedium,
                        ),
                      ],
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
                          controller: _nameController,
                          hintText: l10n.tr('fullName'),
                          prefixIcon: Icons.person_outline_rounded,
                          textInputAction: TextInputAction.next,
                        ),
                        const SizedBox(height: 14),
                        AppTextField(
                          controller: _phoneController,
                          hintText: l10n.tr('phoneNumber'),
                          keyboardType: TextInputType.phone,
                          prefixIcon: Icons.phone_outlined,
                          textInputAction: TextInputAction.next,
                        ),
                        const SizedBox(height: 14),
                        AppTextField(
                          controller: _emailController,
                          hintText: l10n.tr('email'),
                          keyboardType: TextInputType.emailAddress,
                          prefixIcon: Icons.mail_outline_rounded,
                          textInputAction: TextInputAction.next,
                        ),
                        const SizedBox(height: 14),
                        AppTextField(
                          controller: _passwordController,
                          hintText: l10n.tr('password'),
                          obscureText: _hidePassword,
                          prefixIcon: Icons.lock_outline_rounded,
                          textInputAction: TextInputAction.next,
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
                        const SizedBox(height: 14),
                        AppTextField(
                          controller: _confirmPasswordController,
                          hintText: l10n.tr('confirmPassword'),
                          obscureText: _hideConfirmPassword,
                          prefixIcon: Icons.lock_outline_rounded,
                          textInputAction: TextInputAction.done,
                          suffixIcon: IconButton(
                            onPressed: () => setState(
                              () =>
                                  _hideConfirmPassword = !_hideConfirmPassword,
                            ),
                            icon: Icon(
                              _hideConfirmPassword
                                  ? Icons.visibility_outlined
                                  : Icons.visibility_off_outlined,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 12),
                  Row(
                    children: [
                      Checkbox(
                        value: _agreedToTerms,
                        onChanged: (value) {
                          setState(() => _agreedToTerms = value ?? false);
                        },
                        activeColor: colorScheme.primary,
                      ),
                      Expanded(
                        child: Text.rich(
                          TextSpan(
                            text: '${l10n.tr('agreeTerms')} ',
                            style: Theme.of(context).textTheme.bodyMedium,
                            children: [
                              TextSpan(
                                text: l10n.tr('termsAndConditions'),
                                style: TextStyle(
                                  color: colorScheme.primary,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  PrimaryButton(
                    text: l10n.tr('sendOtp'),
                    onPressed: _agreedToTerms
                        ? () {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text(l10n.tr('sendOtp')),
                                duration: const Duration(seconds: 1),
                              ),
                            );
                          }
                        : null,
                    icon: Icons.sms_rounded,
                  ),
                  const SizedBox(height: 18),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(l10n.tr('alreadyHaveAccount')),
                      TextButton(
                        onPressed: () => Navigator.pushReplacementNamed(
                          context,
                          AppRoutes.login,
                        ),
                        child: Text(l10n.tr('login')),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
