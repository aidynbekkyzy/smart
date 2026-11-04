import 'package:flutter/material.dart';

class AppTextField extends StatefulWidget {
  final TextEditingController? controller;
  final String label;
  final String? hint;
  final IconData? icon;
  final bool isPassword;
  final TextInputType? keyboardType;
  final TextInputAction? textInputAction;
  final String? Function(String?)? validator;
  final int maxLines;
  final ValueChanged<String>? onChanged;

  const AppTextField({
    super.key,
    this.controller,
    required this.label,
    this.hint,
    this.icon,
    this.isPassword = false,
    this.keyboardType,
    this.textInputAction,
    this.validator,
    this.maxLines = 1,
    this.onChanged,
  });

  @override
  State<AppTextField> createState() => _AppTextFieldState();
}

class _AppTextFieldState extends State<AppTextField> {
  bool _hidden = true;

  @override
  Widget build(BuildContext context) {
    final obscure = widget.isPassword && _hidden;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(widget.label,
            style: Theme.of(context)
                .textTheme
                .bodyMedium
                ?.copyWith(fontWeight: FontWeight.w600)),
        const SizedBox(height: 8),
        TextFormField(
          controller: widget.controller,
          obscureText: obscure,
          keyboardType: widget.keyboardType,
          textInputAction: widget.textInputAction,
          validator: widget.validator,
          maxLines: obscure ? 1 : widget.maxLines,
          onChanged: widget.onChanged,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          decoration: InputDecoration(
            hintText: widget.hint,
            prefixIcon: widget.icon == null ? null : Icon(widget.icon),
            suffixIcon: widget.isPassword
                ? IconButton(
                    icon: Icon(
                        _hidden ? Icons.visibility_off : Icons.visibility),
                    onPressed: () => setState(() => _hidden = !_hidden),
                  )
                : null,
          ),
        ),
      ],
    );
  }
}
