# White-Labeling Configuration Guide

## 🎨 Customizing Your AI Dashboard

The `AppConfig` class in `lib/core/config/app_config.dart` serves as the central configuration hub for white-labeling your AI dashboard. All hardcoded strings have been replaced with configurable variables.

## 🔧 Configuration Options

### Basic Branding
```dart
class AppConfig {
  // App Information
  static const String appName = 'Zenith AI';           // Your app name
  static const String appLogoPath = 'assets/images/logo.png';  // Logo file path
  static const String primaryColorHex = '#6366F1';     // Primary brand color
  
  // Contact Information
  static const String supportEmail = 'support@zenith.ai';
  static const String companyWebsite = 'https://zenith.ai';
}
```

### AI Configuration
```dart
  // AI Configuration
  static const String defaultSystemPrompt = '''You are Zenith AI, an advanced AI assistant...''';
```

### Business Configuration
```dart
  // UI Configuration
  static const String appVersion = '1.0.0';
  static const String appDescription = 'Build, deploy, and monitor AI models...';
  
  // Branding
  static const String tagline = 'The AI platform that scales with your ambition.';
  static const String copyright = '© 2024 Zenith AI. All rights reserved.';
```

### Feature Flags
```dart
  // Feature Flags
  static const bool enableGoogleSignIn = true;
  static const bool enableAppleSignIn = true;
  static const bool enableEmailVerification = true;
  static const bool enableStripeIntegration = true;
```

### Business Limits
```dart
  // Limits
  static const int maxFreeTokens = 100;
  static const int maxProTokens = 1000;
  static const int maxEnterpriseTokens = 10000;
```

## 🚀 Quick White-Labeling Steps

### 1. Update Basic Information
```dart
static const String appName = 'Your AI Company';
static const String supportEmail = 'support@yourcompany.com';
static const String companyWebsite = 'https://yourcompany.com';
```

### 2. Customize AI Persona
```dart
static const String defaultSystemPrompt = '''You are Your AI Company, an advanced AI assistant...''';
```

### 3. Update Business Configuration
```dart
static const String tagline = 'Your unique tagline';
static const String appDescription = 'Your app description';
```

### 4. Configure Feature Flags
```dart
static const bool enableGoogleSignIn = false;  // Disable if not needed
static const bool enableAppleSignIn = false;   // Disable if not needed
```

### 5. Set Business Limits
```dart
static const int maxFreeTokens = 50;          // Adjust based on your business model
static const int maxProTokens = 500;
```

## 🎯 Files That Use AppConfig

### Branding & UI
- `lib/features/auth/widgets/branding_panel.dart` - Login screen branding
- `lib/shared/widgets/app_sidebar.dart` - Sidebar logo and name
- `lib/main.dart` - App title

### Chat & AI
- `lib/features/chat/widgets/chat_input_bar.dart` - Chat placeholder text
- `lib/core/repositories/implementations/gemini_chat_repository.dart` - AI responses
- `lib/core/repositories/implementations/mock_chat_repository.dart` - Demo mode responses

### Authentication
- `lib/core/constants/app_strings.dart` - All auth-related strings
- `lib/features/auth/screens/login_screen.dart` - Login/signup screens

## 🔄 Dynamic Updates

### Colors
Update the primary color in `AppConfig` and also update the theme colors in:
- `lib/core/theme/app_colors.dart`

### Logo
1. Add your logo to `assets/images/`
2. Update `appLogoPath` in `AppConfig`
3. Update `pubspec.yaml` to include the asset:
```yaml
flutter:
  assets:
    - assets/images/your-logo.png
```

### System Prompt
Customize the AI's personality and behavior by updating `defaultSystemPrompt`.

## 📱 Platform-Specific Considerations

### Android
- Update `android/app/src/main/AndroidManifest.xml` app name
- Update app icons in `android/app/src/main/res/`

### iOS
- Update `ios/Runner/Info.plist` CFBundleDisplayName
- Update app icons in `ios/Runner/Assets.xcassets/AppIcon.appiconset/`

### Web
- Update `web/index.html` title tag
- Update favicon in `web/`

## 🧪 Testing Your Changes

1. **Run the app**: `flutter run`
2. **Check all screens** for proper branding
3. **Test authentication** with your company name
4. **Verify chat interface** shows your AI name
5. **Test feature flags** work correctly

## 📦 Deployment Checklist

- [ ] Update `AppConfig` with your branding
- [ ] Replace logo assets
- [ ] Update app colors
- [ ] Configure feature flags
- [ ] Set business limits
- [ ] Test on all platforms
- [ ] Update platform-specific configurations
- [ ] Verify all hardcoded strings are replaced

## 🎨 Advanced Customization

### Custom Themes
For deeper customization, modify:
- `lib/core/theme/app_colors.dart` - Color schemes
- `lib/core/theme/app_text_styles.dart` - Typography
- `lib/core/theme/app_theme.dart` - Material Design themes

### Custom Components
For UI changes, modify:
- `lib/shared/widgets/` - Reusable widgets
- `lib/features/*/widgets/` - Feature-specific widgets

### Custom Business Logic
For business rules, modify:
- `lib/core/repositories/` - Data layer
- `lib/features/*/providers/` - Business logic

## 🔒 Security Considerations

- Keep sensitive configuration in environment variables
- Use different `AppConfig` for different environments
- Never commit API keys or secrets to version control
- Consider using Firebase Remote Config for dynamic updates

## 📞 Support

For white-labeling support:
1. Check this guide first
2. Review the code comments
3. Test changes in a development environment
4. Contact support if needed: `support@zenith.ai`

---

**Note**: This white-labeling system is designed to be flexible and maintainable. All changes should be made through `AppConfig` to ensure consistency across the application.
