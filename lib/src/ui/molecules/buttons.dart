import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../atoms/atoms.dart';

class AppButton extends StatelessWidget {
  final VoidCallback? onPressed;
  final bool enabled;
  final Widget child;
  final bool loading;
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
    this.enabled = true,
    required this.child,
    this.loading = false,
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
    this.enabled = true,
    required this.child,
    this.loading = false,
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
    this.enabled = true,
    required this.child,
    this.loading = false,
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
    this.enabled = true,
    required this.child,
    this.loading = false,
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
        gradient: hasGradient && enabled ? _gradient : null,
        borderRadius: _borderRadius,
      ),
      child: ElevatedButton(
        onPressed: enabled && !loading ? onPressed : null,
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
            if (loading) ...[
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
    if (gradient != null && enabled) {
      return Colors.transparent;
    }

    if (loading) {
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
      if (loading && appButtonTheme.borderColorLoading != null) {
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
  Color get colorCircularProgressIndicator => AppColors.accentYellow;
  @override
  double? get widthBorder => 0.0;
  @override
  Color? get borderColorEnabled => AppColors.accentYellow;
  @override
  Color? get borderColorDisabled => AppColors.greySurface;
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
  Color get colorCircularProgressIndicator => AppColors.accentYellow;
  @override
  double? get widthBorder => 1.0;
  @override
  Color? get borderColorEnabled => AppColors.outlinedButtonBorderEnabled;
  @override
  Color? get borderColorDisabled => AppColors.outlinedButtonBorderDisabled;
  @override
  Color? get borderColorLoading => AppColors.outlinedButtonBorderDisabled;
}

class IOSBackButton extends StatelessWidget {
  final VoidCallback onPressed;
  final Color color;
  final String? text;
  final EdgeInsets? margin;

  const IOSBackButton({
    super.key,
    this.margin,
    required this.onPressed,
    this.color = AppColors.link,
    this.text,
  });

  static const width = 120.0;
  static const _backTitle = 'Назад';

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: margin ?? EdgeInsets.only(left: 16.0),
      child: CupertinoButton(
        alignment: AlignmentGeometry.centerLeft,
        minimumSize: Size.fromWidth(width),
        padding: EdgeInsets.zero,
        onPressed: onPressed,
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.arrow_back_ios, color: color, size: 20),
            const SizedBox(width: 4),
            Text(
              text ?? _backTitle,
              style: TextStyle(color: color, fontSize: 15, fontWeight: FontWeight.w400),
            ),
          ],
        ),
      ),
    );
  }
}
