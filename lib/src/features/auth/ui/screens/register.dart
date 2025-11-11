import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import 'package:live_beer_ex/src/ui/ui.dart';

import '../../state/provider.dart';

class RegisterScreen extends ConsumerStatefulWidget {
  const RegisterScreen({super.key});

  @override
  ConsumerState<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends ConsumerState<RegisterScreen> {
  final _formKey = GlobalKey<FormState>();
  final _phoneController = TextEditingController();
  final _nameController = TextEditingController();
  DateTime? _selectedDate;
  String? _selectDateError;
  bool _agreementAccepted = false;

  @override
  void dispose() {
    _phoneController.dispose();
    _nameController.dispose();
    _selectedDate = null;
    _selectDateError = null;
    super.dispose();
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );
    if (picked != null && picked != _selectedDate) {
      setState(() => _selectedDate = picked);
      await _validateBirthsDate();
    }
  }

  Future<void> _submitForm() async {
    final isBirthsDayValid = await _validateBirthsDate();
    if (_formKey.currentState!.validate() && isBirthsDayValid && _agreementAccepted) {
      ref
          .read(authProvider.notifier)
          .register(
            phone: _phoneController.text,
            name: _nameController.text,
            birthDate: _selectedDate!,
          );
    }
  }

  String? _validatePhone(String? value) {
    if (value == null || value.isEmpty) {
      return 'Введите номер телефона';
    }
    final digitsOnly = value.replaceAll(RegExp(r'[^0-9]'), '');
    if (digitsOnly.length != 11) {
      return 'Номер должен содержать 11 цифр';
    }
    return null;
  }

  String? _validateName(String? value) {
    if (value == null || value.isEmpty) {
      return 'Введите имя';
    }
    if (value.length < 2) {
      return 'Имя должно содержать минимум 2 символа';
    }
    return null;
  }

  Future<bool> _validateBirthsDate() async {
    if (_selectedDate == null) {
      setState(() => _selectDateError = 'Введите дату вашего рождения');
      return false;
    }

    setState(() => _selectDateError = null);

    final now = DateTime.now();
    final age = now.year - _selectedDate!.year;
    if (age < 18) {
      await AppDialogs.showOkDialog(context, title: Text('Регистрация доступна с 18 лет'));
      setState(() => _selectedDate = null);
      return false;
    }

    return true;
  }

  @override
  Widget build(BuildContext context) {
    final authState = ref.watch(authProvider);
    final textTheme = TextTheme.of(context);
    return Scaffold(
      appBar: AppBar(
        leading: IOSBackButton(onPressed: context.pop),
        leadingWidth: IOSBackButton.width,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('Регистрация аккаунта', style: textTheme.displaySmall),
              SizedBox(height: 8.0),
              Text(
                'Заполните поля данных ниже',
                style: textTheme.labelSmall?.copyWith(fontSize: 15.0, color: AppColors.label),
                textAlign: TextAlign.left,
              ),
              SizedBox(height: 24.0),
              _FieldLabel(text: Text('Номер телефона')),
              TextFormField(
                controller: _phoneController,
                decoration: InputDecoration(
                  floatingLabelStyle: TextStyle(color: AppColors.textBlack),
                  border: OutlineInputBorder(),
                  hintText: 'Введите номер',
                ),
                keyboardType: TextInputType.phone,
                validator: _validatePhone,
              ),
              const SizedBox(height: 16),
              _FieldLabel(text: Text('Ваше имя')),
              TextFormField(
                controller: _nameController,
                decoration: const InputDecoration(
                  floatingLabelStyle: TextStyle(color: AppColors.textBlack),
                  border: OutlineInputBorder(),
                  hintText: 'Введите имя',
                ),
                validator: _validateName,
              ),
              const SizedBox(height: 16),
              _FieldLabel(text: Text('Дата рождения')),
              InkWell(
                onTap: () => _selectDate(context),
                child: InputDecorator(
                  decoration: InputDecoration(
                    floatingLabelStyle: TextStyle(color: AppColors.textBlack),
                    border: OutlineInputBorder(),
                    errorText: _selectDateError,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        _selectedDate == null
                            ? 'ДД.ММ.ГГ'
                            : DateFormat('dd.MM.yyyy').format(_selectedDate!),
                        style: TextStyle(
                          color: _selectedDate == null ? Theme.of(context).hintColor : null,
                        ),
                      ),
                      const Icon(Icons.calendar_today),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 16),
              Row(
                children: [
                  Checkbox(
                    value: _agreementAccepted,
                    onChanged: (bool? value) {
                      setState(() => _agreementAccepted = value ?? false);
                    },
                  ),
                  Expanded(
                    child: GestureDetector(
                      onTap: () => setState(() => _agreementAccepted = !_agreementAccepted),
                      child: Text(
                        'Я согласен с условиями обработки персональных данных',
                        style: TextStyle(
                          color: _agreementAccepted ? AppColors.textBlack : AppColors.label,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 24),
              AppButton.primary(
                enabled: _agreementAccepted,
                loading: authState.isLoading,
                onPressed: _submitForm,
                child: const Text('Зарегистрироваться'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _FieldLabel extends StatelessWidget {
  const _FieldLabel({required this.text});
  final Widget text;

  @override
  Widget build(BuildContext context) {
    return DefaultTextStyle.merge(
      style: TextTheme.of(context).labelSmall?.copyWith(color: AppColors.label),
      child: Column(children: [text, SizedBox(height: 4.0)]),
    );
  }
}
