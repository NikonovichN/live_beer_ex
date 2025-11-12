import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:live_beer_ex/src/navigation/navigator.dart';

import 'package:live_beer_ex/src/ui/ui.dart';

import '../../state/provider.dart';

enum LoginStage { phone, code }

class LoginScreen extends ConsumerStatefulWidget {
  const LoginScreen({super.key});

  @override
  ConsumerState<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends ConsumerState<LoginScreen> {
  static const _durationPageSwitch = Duration(milliseconds: 300);

  LoginStage _stage = LoginStage.phone;
  String _enteredPhone = '';
  bool _loading = false;
  final _pageController = PageController();

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _submitPhone(String phone) async {
    final digitsOnly = phone.replaceAll(RegExp(r'[^\d]'), '');

    if (digitsOnly.length == 11) {
      setState(() => _loading = true);

      await Future.delayed(const Duration(seconds: 1));

      setState(() {
        _enteredPhone = phone;
        _stage = LoginStage.code;
        _loading = false;
      });

      _pageController.nextPage(duration: _durationPageSwitch, curve: Curves.easeIn);
    }
  }

  Future<void> _submitCode() async {
    setState(() => _loading = true);

    Future.delayed(const Duration(seconds: 1));
    ref.read(authProvider.notifier).loginByPhone(_enteredPhone);

    if (mounted) {
      context.go(AppRouteNames.home.path);
    }
  }

  void _onBackPress() {
    if (_stage == LoginStage.phone) {
      if (context.canPop()) {
        context.pop();
        return;
      }

      context.go(AppRouteNames.welcome.path);
    } else {
      setState(() => _stage = LoginStage.phone);
      _pageController.previousPage(duration: _durationPageSwitch, curve: Curves.easeIn);
    }
  }

  String _getMaskedPhone() {
    if (_enteredPhone.length < 5) return _enteredPhone;

    final digits = _enteredPhone.replaceAll(RegExp(r'[^\d]'), '');
    if (digits.length != 11) return _enteredPhone;

    final visiblePart = digits.substring(0, 6);
    final hiddenPart = digits.substring(6);

    return '+$visiblePart ${hiddenPart.replaceAll(RegExp(r'.'), '*')}';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IOSBackButton(onPressed: _onBackPress),
        leadingWidth: IOSBackButton.width,
      ),
      body: PageView(
        controller: _pageController,
        children: [
          _ScrollableState(
            child: _PhoneState(
              key: ValueKey(LoginStage.phone),
              onSubmitPhone: _submitPhone,
              loading: _loading,
              initialPhone: _enteredPhone,
            ),
          ),
          _ScrollableState(
            child: _CodeState(
              key: ValueKey(LoginStage.code),
              onSubmitCode: (v) => _submitCode(),
              loading: _loading,
              onBackPress: _onBackPress,
              maskedPhone: _getMaskedPhone(),
            ),
          ),
        ],
      ),
    );
  }
}

class _ScrollableState extends StatelessWidget {
  const _ScrollableState({required this.child});
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(padding: const EdgeInsets.all(16.0), child: child);
  }
}

class _PhoneState extends StatefulWidget {
  const _PhoneState({
    super.key,
    required this.onSubmitPhone,
    required this.loading,
    required this.initialPhone,
  });
  final Function(String) onSubmitPhone;
  final bool loading;
  final String initialPhone;

  @override
  State<_PhoneState> createState() => __PhoneStateState();
}

class __PhoneStateState extends State<_PhoneState> {
  final _phoneController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _phoneController.text = widget.initialPhone.isNotEmpty ? widget.initialPhone : '+7';
  }

  @override
  void dispose() {
    _phoneController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final digitsOnly = _phoneController.text.replaceAll(RegExp(r'[^\d]'), '');
    final isValid = digitsOnly.length == 11;
    final textTheme = TextTheme.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Введите ваш номер телефона', style: textTheme.displaySmall),
        const SizedBox(height: 8.0),
        Text(
          'Мы вышлем вам проверочный код',
          style: textTheme.labelSmall?.copyWith(fontSize: 15.0, color: AppColors.label),
        ),
        const SizedBox(height: 32.0),

        TextFormField(
          controller: _phoneController,
          decoration: InputDecoration(
            border: const OutlineInputBorder(),
            hintText: '+7 XXX XXX XX XX',
          ),
          style: textTheme.bodyLarge?.copyWith(fontSize: 18),
          keyboardType: TextInputType.phone,
          onChanged: (value) => setState(() {}),
        ),

        const SizedBox(height: 24.0),

        AppButton.primary(
          loading: widget.loading,
          onPressed: isValid ? () => widget.onSubmitPhone(_phoneController.text) : null,
          child: const Text('Продолжить'),
        ),
      ],
    );
  }
}

class _CodeState extends StatefulWidget {
  const _CodeState({
    super.key,
    required this.onSubmitCode,
    required this.loading,
    required this.onBackPress,
    required this.maskedPhone,
  });

  final Function(String) onSubmitCode;
  final VoidCallback onBackPress;
  final String maskedPhone;
  final bool loading;

  @override
  State<_CodeState> createState() => __CodeStateState();
}

class __CodeStateState extends State<_CodeState> {
  final _codeControllers = List.generate(4, (index) => TextEditingController());
  final _focusNodes = List.generate(4, (index) => FocusNode());

  @override
  void initState() {
    super.initState();
    _setupCodeFocusListeners();
  }

  @override
  void dispose() {
    for (final controller in _codeControllers) {
      controller.dispose();
    }
    for (final focusNode in _focusNodes) {
      focusNode.dispose();
    }
    super.dispose();
  }

  void _setupCodeFocusListeners() {
    for (int i = 0; i < _focusNodes.length; i++) {
      _focusNodes[i].addListener(() {
        if (_codeControllers[i].text.isNotEmpty && i < _focusNodes.length - 1) {
          _focusNodes[i + 1].requestFocus();
        }
      });
    }
  }

  void _submitCode() {
    final code = _codeControllers.map((c) => c.text).join();
    if (code.length == 4) {
      widget.onSubmitCode(code);
    }
  }

  void _handleCodeInput(int index, String value) {
    if (value.isNotEmpty && index < _codeControllers.length - 1) {
      _focusNodes[index + 1].requestFocus();
    }

    if (index == _codeControllers.length - 1 && value.isNotEmpty) {
      final fullCode = _codeControllers.map((c) => c.text).join();
      if (fullCode.length == 4) {
        _submitCode();
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final code = _codeControllers.map((c) => c.text).join();
    final isValid = code.length == 4;
    final textTheme = TextTheme.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Введите номер активации', style: textTheme.displaySmall),
        const SizedBox(height: 8.0),
        Text(
          'Мы выслали его на номер ${widget.maskedPhone}',
          style: textTheme.labelSmall?.copyWith(fontSize: 15.0, color: AppColors.label),
        ),
        const SizedBox(height: 32.0),

        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: List.generate(4, (index) {
            return SizedBox(
              width: 60.0,
              child: TextFormField(
                controller: _codeControllers[index],
                focusNode: _focusNodes[index],
                decoration: InputDecoration(
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
                  counterText: '',
                ),
                textAlign: TextAlign.center,
                style: textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.w600),
                keyboardType: TextInputType.number,
                maxLength: 1,
                onChanged: (value) {
                  _handleCodeInput(index, value);
                  setState(() {});
                },
              ),
            );
          }),
        ),

        const SizedBox(height: 24.0),

        AppButton.primary(
          loading: widget.loading,
          onPressed: isValid ? _submitCode : null,
          child: const Text('Подтвердить'),
        ),

        const SizedBox(height: 16.0),

        Center(
          child: TextButton(
            onPressed: widget.loading ? null : widget.onBackPress,
            child: const Text('Изменить номер телефона'),
          ),
        ),
      ],
    );
  }
}
