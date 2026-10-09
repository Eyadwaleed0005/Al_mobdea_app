import 'package:flutter/material.dart';

class ColorPalette {
  // Primary: Deep Crimson/Maroon
  static const Color crimsonDeep = Color(0xFF6B0F2A);
  static const Color crimsonDark = Color(0xFF4A0A1C);
  static const Color crimsonHover = Color(0xFF8B1535);
  static const Color palePink = Color(0xFFFFF0F3);
  static const Color softRose = Color(0xFFF2C4CC);
  static const Color paleRose = Color(0xFFFAE4E8);

  // Accent / Gold highlight
  static const Color goldHighlight = Color(0xFFC89B3C);
  static const Color goldLight = Color(0xFFE8C97A);
  static const Color goldPale = Color(0xFFFDF3DC);

  // Neutral / Background tones
  static const Color creamWhite = Color(0xFFFDF8F5);
  static const Color warmBeige = Color(0xFFF5EDE8);
  static const Color lightCream = Color(0xFFFAF5F0);
  static const Color dustyRose = Color(0xFFEAD8D8);

  // Semantic / State colors
  static const Color oceanBlue = Color(0xFF28729F);
  static const Color textDark = Color(0xFF1A0A0A);
  static const Color mutedWine = Color(0xFF7A3A48);
  static const Color lightGrayWarm = Color(0xFFB09AA0);
  static const Color dividerWarm = Color(0xFFEADCDC);
  static const Color borderWarm = Color(0xFFE0CFCF);

  // ===== Primary & Brand Semantics — Elmobde3 =====
  static const Color primary = crimsonDeep;
  static const Color primaryHover = crimsonHover;
  static const Color primaryPressed = crimsonDark;
  static const Color primarySoftBackground = palePink;
  static const Color deepSurface = Color(0xFF2C060F);

  static const Color secondary = oceanBlue;
  static const Color accent = softRose;
  static const Color highlight = goldHighlight;
  static const Color navActiveGlow = Color(0xFFB94C6C);
  static const Color navActiveText = Color(0xFFE8A0B0);

  // ===== Background & Surface =====
  static const Color background = creamWhite;
  static const Color surface = Color(0xFFFFFFFF);
  static const Color cardBackground = Color(0xFFFFFFFF);
  static const Color ligthBlackShadow = Color(0x33000000);

  // ===== Border & Divider =====
  static const Color border = borderWarm;
  static const Color divider = dividerWarm;

  // ===== Text Color Tokens =====
  static const Color textPrimary = textDark;
  static const Color textSecondary = mutedWine;
  static const Color textMuted = lightGrayWarm;
  static const Color textLight = Color(0xFFFFFFFF);
  static const Color textHighLight = goldHighlight;
  static const Color textSoftSaga = softRose;
  static const Color textBlack = Color(0xFF000000);
  static const Color textOceanBlue = oceanBlue;
  static const Color textRed = Color(0xFFB94C4C);

  // ===== Alias / backward compat =====
  static const Color paleSage = paleRose;
  static const Color softSage = softRose;
  static const Color paleMint = palePink;

  // ===== State Colors =====
  static const Color disabled = Color(0xFFCABCBE);
  static const Color success = Color(0xFF2E7D32);
  static const Color warning = Color(0xFFB8860B);
  static const Color error = Color(0xFFC0392B);
  static const Color info = oceanBlue;
}
