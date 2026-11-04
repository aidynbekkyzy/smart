import 'package:flutter/material.dart';

import '../../../core/routes/app_routes.dart';
import '../../../core/state/app_scope.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/utils/responsive.dart';
import '../../../core/utils/validators.dart';
import '../../../core/widgets/app_text_field.dart';
import '../../../core/widgets/primary_button.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _formKey = GlobalKey<FormState>();
  final _name = TextEditingController();
  final _email = TextEditingController();
  final _password = TextEditingController();
  final _confirm = TextEditingController();

  @override
  void dispose() {
    _name.dispose();
    _email.dispose();
    _password.dispose();
    _confirm.dispose();
    super.dispose();
  }

  void _submit() {
    if (!_formKey.currentState!.validate()) return;
    final error = AppScope.of(context)
        .register(_name.text, _email.text, _password.text);
    if (error != null) {
      ScaffoldMessenger.of(context)
        ..hideCurrentSnackBar()
        ..showSnackBar(SnackBar(
            content: Text(error), backgroundColor: AppColors.error));
      return;
    }
    Navigator.pushNamedAndRemoveUntil(context, AppRoutes.home, (_) => false);
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(title: const Text('Тіркелу')),
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
                  Text('Аккаунт құру', style: theme.textTheme.headlineMedium),
                  const SizedBox(height: 6),
                  Text('Деректеріңізді толтырыңыз',
                      style: theme.textTheme.bodyMedium?.copyWith(
                          color: theme.colorScheme.onSurfaceVariant)),
                  const SizedBox(height: 28),
                  AppTextField(
                    controller: _name,
                    label: 'Аты-жөні',
                    hint: 'Аты-жөніңіз',
                    icon: Icons.person_outline,
                    textInputAction: TextInputAction.next,
                    validator: (v) => Validators.required(v, 'Аты-жөні'),
                  ),
                  const SizedBox(height: 18),
                  AppTextField(
                    controller: _email,
                    label: 'Email',
                    hint: 'name@mail.com',
                    icon: Icons.mail_outline,
                    keyboardType: TextInputType.emailAddress,
                    textInputAction: TextInputAction.next,
                    validator: Validators.email,
                  ),
                  const SizedBox(height: 18),
                  AppTextField(
                    controller: _password,
                    label: 'Құпия сөз',
                    hint: 'Кемінде 6 таңба',
                    icon: Icons.lock_outline,
                    isPassword: true,
                    textInputAction: TextInputAction.next,
                    validator: Validators.password,
                  ),
                  const SizedBox(height: 18),
                  AppTextField(
                    controller: _confirm,
                    label: 'Құпия сөзді қайталаңыз',
                    icon: Icons.lock_outline,
                    isPassword: true,
                    textInputAction: TextInputAction.done,
                    validator: (v) =>
                        Validators.confirmPassword(v, _password.text),
                  ),
                  const SizedBox(height: 28),
                  PrimaryButton(label: 'Тіркелу', onPressed: _submit),
                  const SizedBox(height: 12),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('Аккаунтыңыз бар ма?',
                          style: theme.textTheme.bodyMedium),
                      TextButton(
                        onPressed: () => Navigator.pop(context),
                        child: const Text('Кіру'),
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
