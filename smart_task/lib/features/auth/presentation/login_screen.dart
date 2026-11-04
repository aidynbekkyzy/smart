import 'package:flutter/material.dart';

import '../../../core/routes/app_routes.dart';
import '../../../core/state/app_scope.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/utils/responsive.dart';
import '../../../core/utils/validators.dart';
import '../../../core/widgets/app_text_field.dart';
import '../../../core/widgets/primary_button.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final _email = TextEditingController();
  final _password = TextEditingController();

  @override
  void dispose() {
    _email.dispose();
    _password.dispose();
    super.dispose();
  }

  void _submit() {
    if (!_formKey.currentState!.validate()) return;
    final error = AppScope.of(context).login(_email.text, _password.text);
    if (error != null) {
      ScaffoldMessenger.of(context)
        ..hideCurrentSnackBar()
        ..showSnackBar(SnackBar(
            content: Text(error), backgroundColor: AppColors.error));
      return;
    }
    Navigator.pushReplacementNamed(context, AppRoutes.home);
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      body: SafeArea(
        child: ResponsiveCenter(
          maxWidth: 480,
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(24),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 24),
                  Container(
                    width: 64,
                    height: 64,
                    decoration: BoxDecoration(
                      color: AppColors.primary,
                      borderRadius: BorderRadius.circular(18),
                    ),
                    child: const Icon(Icons.task_alt,
                        color: Colors.white, size: 34),
                  ),
                  const SizedBox(height: 28),
                  Text('Қош келдіңіз!', style: theme.textTheme.headlineMedium),
                  const SizedBox(height: 6),
                  Text('Жалғастыру үшін аккаунтыңызға кіріңіз',
                      style: theme.textTheme.bodyMedium?.copyWith(
                          color: theme.colorScheme.onSurfaceVariant)),
                  const SizedBox(height: 32),
                  AppTextField(
                    controller: _email,
                    label: 'Email',
                    hint: 'demo@mail.com',
                    icon: Icons.mail_outline,
                    keyboardType: TextInputType.emailAddress,
                    textInputAction: TextInputAction.next,
                    validator: Validators.email,
                  ),
                  const SizedBox(height: 18),
                  AppTextField(
                    controller: _password,
                    label: 'Құпия сөз',
                    hint: '••••••',
                    icon: Icons.lock_outline,
                    isPassword: true,
                    textInputAction: TextInputAction.done,
                    validator: Validators.password,
                  ),
                  Align(
                    alignment: Alignment.centerRight,
                    child: TextButton(
                      onPressed: () => ScaffoldMessenger.of(context)
                          .showSnackBar(const SnackBar(
                              content: Text(
                                  'Құпия сөзді қалпына келтіру сілтемесі email-ге жіберіледі'))),
                      child: const Text('Құпия сөзді ұмыттыңыз ба?'),
                    ),
                  ),
                  const SizedBox(height: 12),
                  PrimaryButton(label: 'Кіру', onPressed: _submit),
                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('Аккаунт жоқ па?', style: theme.textTheme.bodyMedium),
                      TextButton(
                        onPressed: () =>
                            Navigator.pushNamed(context, AppRoutes.register),
                        child: const Text('Тіркелу'),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Center(
                    child: Text('Демо: demo@mail.com / 123456',
                        style: theme.textTheme.bodySmall?.copyWith(
                            color: theme.colorScheme.onSurfaceVariant)),
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
