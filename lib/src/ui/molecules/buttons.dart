import 'package:flutter/material.dart';

import '../atoms/atoms.dart';

class AppButton extends StatelessWidget {
  final VoidCallback? onPressed;
  final bool isEnabled;
  final Widget child;
  final bool isLoading;
  final EdgeInsetsGeometry? padding;
  final EdgeInsetsGeometry? margin;
  final LinearGradient? gradient;
  final BorderRadius? borderRadius;
  final double width;
  final double height;
  final ButtonTheme appButtonTheme;

  const AppButton({
    super.key,
    required this.onPressed,
    this.isEnabled = true,
    required this.child,
    this.isLoading = false,
    this.padding,
    this.margin,
    this.gradient,
    this.width = _width,
    this.height = _height,
    this.borderRadius = _borderRadius,
    this.appButtonTheme = const AppPrimaryButtonTheme(),
  });

  const AppButton.primary({
    super.key,
    required this.onPressed,
    this.isEnabled = true,
    required this.child,
    this.isLoading = false,
    this.padding,
    this.margin = _margin,
    this.gradient,
    this.width = _width,
    this.height = _height,
    this.borderRadius = _borderRadius,
    this.appButtonTheme = const AppPrimaryButtonTheme(),
  });

  const AppButton.outlined({
    super.key,
    required this.onPressed,
    this.isEnabled = true,
    required this.child,
    this.isLoading = false,
    this.padding,
    this.margin = _margin,
    this.gradient,
    this.width = _width,
    this.height = _height,
    this.borderRadius = _borderRadius,
    this.appButtonTheme = const AppOutlinedButtonTheme(),
  });

  const AppButton.simple({
    super.key,
    required this.onPressed,
    this.isEnabled = true,
    required this.child,
    this.isLoading = false,
    this.padding,
    this.margin,
    this.gradient,
    this.width = _width,
    this.height = _height,
    this.borderRadius = _borderRadius,
    this.appButtonTheme = const AppPrimaryButtonTheme(),
  });

  static const _width = double.infinity;
  static const _height = 56.0;
  static const _borderRadius = BorderRadius.all(Radius.circular(10.0));
  static const _margin = EdgeInsets.symmetric(vertical: 16.0);
  static const _gradient = LinearGradient(
    begin: Alignment.centerLeft,
    end: Alignment.centerRight,
    colors: [],
  );

  @override
  Widget build(BuildContext context) {
    final hasGradient = gradient != null;
    final textTheme = TextTheme.of(context);
    return Container(
      width: width,
      height: height,
      padding: padding,
      margin: margin,
      decoration: BoxDecoration(
        gradient: hasGradient && isEnabled ? _gradient : null,
        borderRadius: _borderRadius,
      ),
      child: ElevatedButton(
        onPressed: isEnabled && !isLoading ? onPressed : null,
        style: ButtonStyle(
          backgroundColor: WidgetStateProperty.resolveWith(_backgroundColor),
          shape: WidgetStateProperty.resolveWith(_shape),
          padding: WidgetStateProperty.all(EdgeInsets.zero),
          tapTargetSize: MaterialTapTargetSize.shrinkWrap,
          elevation: WidgetStateProperty.all(0.0),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            if (isLoading) ...[
              CircularProgressIndicator(color: appButtonTheme.colorCircularProgressIndicator),
              const SizedBox(width: 12.0),
            ],
            DefaultTextStyle.merge(
              style: textTheme.bodyMedium?.copyWith(color: appButtonTheme.textColor),
              child: child,
            ),
          ],
        ),
      ),
    );
  }

  Color _backgroundColor(Set<WidgetState> states) {
    if (gradient != null && isEnabled) {
      return Colors.transparent;
    }

    if (isLoading) {
      return appButtonTheme.backgroundLoading;
    }
    if (states.contains(WidgetState.disabled)) {
      return appButtonTheme.backgroundDisabled;
    }
    if (states.contains(WidgetState.pressed)) {
      return appButtonTheme.backgroundPressed;
    }
    return appButtonTheme.backgroundEnabled;
  }

  OutlinedBorder? _shape(Set<WidgetState> states) {
    BorderSide? side;
    if (appButtonTheme.widthBorder != null) {
      if (isLoading && appButtonTheme.borderColorLoading != null) {
        side = BorderSide(
          width: appButtonTheme.widthBorder!,
          color: appButtonTheme.borderColorLoading!,
        );
      } else if (states.contains(WidgetState.disabled) &&
          appButtonTheme.borderColorDisabled != null) {
        side = BorderSide(
          width: appButtonTheme.widthBorder!,
          color: appButtonTheme.borderColorDisabled!,
        );
      } else if (appButtonTheme.borderColorEnabled != null) {
        side = BorderSide(
          width: appButtonTheme.widthBorder!,
          color: appButtonTheme.borderColorEnabled!,
        );
      }
    }

    return RoundedRectangleBorder(
      borderRadius: _borderRadius,
      side: side ?? const BorderSide(width: 0.0),
    );
  }
}

class ButtonTheme {
  final Color backgroundLoading;
  final Color backgroundDisabled;
  final Color backgroundPressed;
  final Color backgroundEnabled;

  final Color textColor;

  final Color colorCircularProgressIndicator;

  final double? widthBorder;

  final Color? borderColorEnabled;
  final Color? borderColorDisabled;
  final Color? borderColorLoading;

  const ButtonTheme({
    required this.backgroundLoading,
    required this.backgroundDisabled,
    required this.backgroundPressed,
    required this.backgroundEnabled,
    required this.textColor,
    required this.colorCircularProgressIndicator,
    this.widthBorder,
    this.borderColorEnabled,
    this.borderColorDisabled,
    this.borderColorLoading,
  });
}

class AppPrimaryButtonTheme implements ButtonTheme {
  const AppPrimaryButtonTheme();

  @override
  Color get backgroundLoading => AppColors.greySurface;
  @override
  Color get backgroundDisabled => AppColors.greySurface;
  @override
  Color get backgroundPressed => AppColors.accentYellow;
  @override
  Color get backgroundEnabled => AppColors.activeCameraButtonSaveColor;
  @override
  Color get textColor => AppColors.primaryButtonTextColorEnabled;
  @override
  Color get colorCircularProgressIndicator => AppColors.greyColor;
  @override
  double? get widthBorder => 0.0;
  @override
  Color? get borderColorEnabled => AppColors.accentYellow;
  @override
  Color? get borderColorDisabled => null;
  @override
  Color? get borderColorLoading => null;
}

class AppOutlinedButtonTheme implements ButtonTheme {
  const AppOutlinedButtonTheme();

  @override
  Color get backgroundLoading => AppColors.outlinedButtonBackgroundDisabled;
  @override
  Color get backgroundDisabled => AppColors.outlinedButtonBackgroundDisabled;
  @override
  Color get backgroundPressed => AppColors.outlinedButtonBackgroundPressed;
  @override
  Color get backgroundEnabled => AppColors.outlinedButtonBackgroundEnabled;
  @override
  Color get textColor => AppColors.darkBlue;
  @override
  Color get colorCircularProgressIndicator => AppColors.darkBlue;
  @override
  double? get widthBorder => 1.0;
  @override
  Color? get borderColorEnabled => AppColors.outlinedButtonBorderEnabled;
  @override
  Color? get borderColorDisabled => AppColors.outlinedButtonBorderDisabled;
  @override
  Color? get borderColorLoading => AppColors.outlinedButtonBorderDisabled;
}
