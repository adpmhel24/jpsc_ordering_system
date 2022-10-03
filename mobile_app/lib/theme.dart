import 'package:flutter/foundation.dart';
import 'package:mobile_app/color.dart';
import 'package:system_theme/system_theme.dart';
import 'package:flutter/material.dart' as m;

enum NavigationIndicators { sticky, end }

class AppTheme extends ChangeNotifier {
  AccentColor _color = systemAccentColor;
  AccentColor get color => _color;
  set color(AccentColor color) {
    _color = color;
    notifyListeners();
  }

  m.ThemeMode _mode = m.ThemeMode.system;
  m.ThemeMode get mode => _mode;
  set mode(m.ThemeMode mode) {
    _mode = mode;
    notifyListeners();
  }

  m.TextDirection _textDirection = m.TextDirection.ltr;
  m.TextDirection get textDirection => _textDirection;
  set textDirection(m.TextDirection direction) {
    _textDirection = direction;
    notifyListeners();
  }
}

AccentColor get systemAccentColor {
  if (defaultTargetPlatform == TargetPlatform.windows ||
      defaultTargetPlatform == TargetPlatform.android ||
      kIsWeb) {
    return AccentColor('normal', {
      'darkest': SystemTheme.accentColor.darkest,
      'darker': SystemTheme.accentColor.darker,
      'dark': SystemTheme.accentColor.dark,
      'normal': SystemTheme.accentColor.accent,
      'light': SystemTheme.accentColor.light,
      'lighter': SystemTheme.accentColor.lighter,
      'lightest': SystemTheme.accentColor.lightest,
    });
  }
  return Colors.blue;
}
