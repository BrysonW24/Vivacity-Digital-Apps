import 'package:flutter/material.dart';

/// Theme preset options for the journal app
enum ThemePreset {
  modernMinimalist,
  calmingZen,
}

/// Extended color palette for the journal app with support for multiple theme presets
class AppColors {
  // Prevent instantiation
  AppColors._();

  // ==================== MODERN MINIMALIST PRESET ====================

  // Modern Minimalist - Light Mode
  static const modernMinimalistLightPrimary = Color(0xFF6366F1); // Vibrant Indigo
  static const modernMinimalistLightSecondary = Color(0xFF8B5CF6); // Purple
  static const modernMinimalistLightAccent = Color(0xFFEC4899); // Pink
  static const modernMinimalistLightBackground = Color(0xFFFAFAFA);
  static const modernMinimalistLightSurface = Color(0xFFFFFFFF);
  static const modernMinimalistLightSurfaceVariant = Color(0xFFF8FAFC);
  static const modernMinimalistLightOnSurface = Color(0xFF0F172A); // Darker for better contrast
  static const modernMinimalistLightOnSurfaceVariant = Color(0xFF475569); // Darker for better contrast
  static const modernMinimalistLightOutline = Color(0xFFCBD5E1);

  // Modern Minimalist - Dark Mode
  static const modernMinimalistDarkPrimary = Color(0xFF818CF8); // Light Indigo
  static const modernMinimalistDarkSecondary = Color(0xFFA78BFA); // Light Purple
  static const modernMinimalistDarkAccent = Color(0xFFF472B6); // Light Pink
  static const modernMinimalistDarkBackground = Color(0xFF0F172A);
  static const modernMinimalistDarkSurface = Color(0xFF1E293B);
  static const modernMinimalistDarkSurfaceVariant = Color(0xFF334155);
  static const modernMinimalistDarkOnSurface = Color(0xFFF8FAFC); // Brighter for better contrast
  static const modernMinimalistDarkOnSurfaceVariant = Color(0xFFE2E8F0); // Brighter for better contrast
  static const modernMinimalistDarkOutline = Color(0xFF475569);

  // ==================== CALMING ZEN PRESET ====================

  // Calming Zen - Light Mode (Soft pastels, nature-inspired)
  static const calmingZenLightPrimary = Color(0xFF84A59D); // Sage Green
  static const calmingZenLightSecondary = Color(0xFFF6BD60); // Warm Sand
  static const calmingZenLightAccent = Color(0xFFF28482); // Coral
  static const calmingZenLightBackground = Color(0xFFF7F4F0); // Warm White
  static const calmingZenLightSurface = Color(0xFFFFFBF5); // Cream
  static const calmingZenLightSurfaceVariant = Color(0xFFE8E3DB);
  static const calmingZenLightOnSurface = Color(0xFF1A1D28); // Darker for better contrast
  static const calmingZenLightOnSurfaceVariant = Color(0xFF4A5566); // Darker for better contrast
  static const calmingZenLightOutline = Color(0xFFD4CFC5);

  // Calming Zen - Dark Mode (Muted, earthy tones)
  static const calmingZenDarkPrimary = Color(0xFF9DB4A8); // Light Sage
  static const calmingZenDarkSecondary = Color(0xFFE8C68A); // Light Sand
  static const calmingZenDarkAccent = Color(0xFFE8A09A); // Light Coral
  static const calmingZenDarkBackground = Color(0xFF1C1E26);
  static const calmingZenDarkSurface = Color(0xFF2A2D3A);
  static const calmingZenDarkSurfaceVariant = Color(0xFF363A48);
  static const calmingZenDarkOnSurface = Color(0xFFF0EEE8); // Brighter for better contrast
  static const calmingZenDarkOnSurfaceVariant = Color(0xFFC5C2BA); // Brighter for better contrast
  static const calmingZenDarkOutline = Color(0xFF4F5362);

  // ==================== MOOD COLORS ====================

  // Modern Minimalist Mood Colors (Vibrant gradients)
  static const modernMoodVeryHappy = LinearGradient(
    colors: [Color(0xFFFBBF24), Color(0xFFF59E0B)], // Amber gradient
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );
  static const modernMoodHappy = LinearGradient(
    colors: [Color(0xFF34D399), Color(0xFF10B981)], // Emerald gradient
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );
  static const modernMoodNeutral = LinearGradient(
    colors: [Color(0xFF60A5FA), Color(0xFF3B82F6)], // Blue gradient
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );
  static const modernMoodSad = LinearGradient(
    colors: [Color(0xFFA78BFA), Color(0xFF8B5CF6)], // Purple gradient
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );
  static const modernMoodVerySad = LinearGradient(
    colors: [Color(0xFFF87171), Color(0xFFEF4444)], // Red gradient
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  // Calming Zen Mood Colors (Soft, muted gradients)
  static const zenMoodVeryHappy = LinearGradient(
    colors: [Color(0xFFFAD785), Color(0xFFF6BD60)], // Soft gold
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );
  static const zenMoodHappy = LinearGradient(
    colors: [Color(0xFFA8C5B8), Color(0xFF84A59D)], // Soft sage
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );
  static const zenMoodNeutral = LinearGradient(
    colors: [Color(0xFFB3C5D4), Color(0xFF94A9BE)], // Soft blue
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );
  static const zenMoodSad = LinearGradient(
    colors: [Color(0xFFB8A8C8), Color(0xFF9E8FB2)], // Soft lavender
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );
  static const zenMoodVerySad = LinearGradient(
    colors: [Color(0xFFE8A09A), Color(0xFFF28482)], // Soft coral
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  // ==================== SEMANTIC COLORS ====================

  static const success = Color(0xFF10B981);
  static const warning = Color(0xFFF59E0B);
  static const error = Color(0xFFEF4444);
  static const info = Color(0xFF3B82F6);

  // ==================== SHADOW COLORS ====================

  static const modernShadowLight = Color(0x1A000000);
  static const modernShadowDark = Color(0x33000000);

  static const zenShadowLight = Color(0x0D000000);
  static const zenShadowDark = Color(0x1F000000);

  // ==================== HELPER METHODS ====================

  /// Get mood gradient based on theme preset
  static LinearGradient getMoodGradient(String mood, ThemePreset preset) {
    final isModern = preset == ThemePreset.modernMinimalist;

    switch (mood.toLowerCase()) {
      case 'veryhappy':
        return isModern ? modernMoodVeryHappy : zenMoodVeryHappy;
      case 'happy':
        return isModern ? modernMoodHappy : zenMoodHappy;
      case 'neutral':
        return isModern ? modernMoodNeutral : zenMoodNeutral;
      case 'sad':
        return isModern ? modernMoodSad : zenMoodSad;
      case 'verysad':
        return isModern ? modernMoodVerySad : zenMoodVerySad;
      default:
        return isModern ? modernMoodNeutral : zenMoodNeutral;
    }
  }

  /// Get solid mood color (first color from gradient)
  static Color getMoodColor(String mood, ThemePreset preset) {
    final gradient = getMoodGradient(mood, preset);
    return gradient.colors.first;
  }
}
