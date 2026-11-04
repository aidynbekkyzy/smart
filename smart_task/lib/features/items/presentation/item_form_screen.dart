import 'package:flutter/material.dart';

import '../../../core/constants/categories.dart';
import '../../../core/state/app_scope.dart';
import '../../../core/utils/formatters.dart';
import '../../../core/utils/responsive.dart';
import '../../../core/utils/validators.dart';
import '../../../core/widgets/app_text_field.dart';
import '../../../core/widgets/primary_button.dart';
import '../data/item_model.dart';

/// Жаңа тапсырма қосу (item == null) немесе өңдеу (item != null) формасы.
class ItemFormScreen extends StatefulWidget {
  final Item? item;
  const ItemFormScreen({super.key, this.item});

  @override
  State<ItemFormScreen> createState() => _ItemFormScreenState();
}

class _ItemFormScreenState extends State<ItemFormScreen> {
  final _formKey = GlobalKey<FormState>();
  late final TextEditingController _title;
  late final TextEditingController _description;
  late String _category;
  late DateTime _date;

  bool get _isEdit => widget.item != null;

  @override
  void initState() {
    super.initState();
    final i = widget.item;
    _title = TextEditingController(text: i?.title ?? '');
    _description = TextEditingController(text: i?.description ?? '');
    _category = i?.category ?? Categories.names.first;
    _date = i?.date ?? DateTime.now();
  }

  @override
  void dispose() {
    _title.dispose();
    _description.dispose();
    super.dispose();
  }

  Future<void> _pickDate() async {
    final picked = await showDatePicker(
      context: context,
      initialDate: _date,
      firstDate: DateTime(2020),
      lastDate: DateTime(2035),
    );
    if (picked != null) setState(() => _date = picked);
  }

  void _save() {
    if (!_formKey.currentState!.validate()) return;
    final state = AppScope.of(context);
    final messenger = ScaffoldMessenger.of(context);
    if (_isEdit) {
      state.updateItem(widget.item!.copyWith(
        title: _title.text.trim(),
        description: _description.text.trim(),
        category: _category,
        date: _date,
      ));
    } else {
      state.addItem(Item(
        id: state.newId(),
        title: _title.text.trim(),
        description: _description.text.trim(),
        category: _category,
        date: _date,
      ));
    }
    Navigator.pop(context);
    messenger.showSnackBar(SnackBar(
        content: Text(_isEdit ? 'Өзгерістер сақталды' : 'Тапсырма қосылды')));
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(title: Text(_isEdit ? 'Өңдеу' : 'Жаңа тапсырма')),
      body: SafeArea(
        child: ResponsiveCenter(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(20),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  AppTextField(
                    controller: _title,
                    label: 'Атауы',
                    hint: 'Тапсырма атауы',
                    icon: Icons.title,
                    textInputAction: TextInputAction.next,
                    validator: (v) => Validators.required(v, 'Атауы'),
                  ),
                  const SizedBox(height: 18),
                  AppTextField(
                    controller: _description,
                    label: 'Сипаттамасы',
                    hint: 'Толығырақ жазыңыз',
                    maxLines: 4,
                    validator: (v) => Validators.required(v, 'Сипаттамасы'),
                  ),
                  const SizedBox(height: 18),
                  Text('Санат',
                      style: theme.textTheme.bodyMedium
                          ?.copyWith(fontWeight: FontWeight.w600)),
                  const SizedBox(height: 8),
                  DropdownButtonFormField<String>(
                    value: _category,
                    items: [
                      for (final n in Categories.names)
                        DropdownMenuItem(value: n, child: Text(n)),
                    ],
                    onChanged: (v) => setState(() => _category = v ?? _category),
                    validator: (v) => Validators.required(v, 'Санат'),
                  ),
                  const SizedBox(height: 18),
                  Text('Күні',
                      style: theme.textTheme.bodyMedium
                          ?.copyWith(fontWeight: FontWeight.w600)),
                  const SizedBox(height: 8),
                  InkWell(
                    onTap: _pickDate,
                    borderRadius: BorderRadius.circular(14),
                    child: InputDecorator(
                      decoration: const InputDecoration(
                          prefixIcon: Icon(Icons.calendar_today_outlined)),
                      child: Text(formatDate(_date)),
                    ),
                  ),
                  const SizedBox(height: 28),
                  PrimaryButton(
                      label: _isEdit ? 'Сақтау' : 'Қосу', onPressed: _save),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
