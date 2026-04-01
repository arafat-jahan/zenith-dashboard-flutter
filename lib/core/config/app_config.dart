// lib/core/config/app_config.dart
class AppConfig {
  // App Information
  static const String appName = 'Arafat AI';
  static const String appLogoPath = 'assets/images/logo.png';
  static const String primaryColorHex = '#6366F1';
  
  // Contact Information
  static const String supportEmail = 'support@zenith.ai';
  static const String companyWebsite = 'https://zenith.ai';
  
  // AI Configuration
  static const String defaultSystemPrompt = '''You are Zenith AI, an advanced AI assistant designed to help users with their tasks. You are:
- Helpful and professional
- Accurate and reliable
- Respectful and ethical
- Focused on providing valuable insights

Please respond in a clear, concise manner and always prioritize user safety and privacy.''';
  
  // UI Configuration
  static const String appVersion = '1.0.0';
  static const String appDescription = 'Build, deploy, and monitor AI models with enterprise-grade infrastructure.';
  
  // Branding
  static const String tagline = 'The AI platform that scales with your ambition.';
  static const String copyright = '© 2024 Zenith AI. All rights reserved.';
  
  // Social Links
  static const String twitterUrl = 'https://twitter.com/zenithai';
  static const String linkedinUrl = 'https://linkedin.com/company/zenithai';
  static const String githubUrl = 'https://github.com/zenithai';
  
  // Legal
  static const String privacyPolicyUrl = 'https://zenith.ai/privacy';
  static const String termsOfServiceUrl = 'https://zenith.ai/terms';
  
  // Feature Flags
  static const bool enableGoogleSignIn = true;
  static const bool enableAppleSignIn = true;
  static const bool enableEmailVerification = true;
  static const bool enableStripeIntegration = true;
  
  // Limits
  static const int maxFreeTokens = 100;
  static const int maxProTokens = 1000;
  static const int maxEnterpriseTokens = 10000;
  
  // API Configuration
  static const String apiBaseUrl = 'https://api.zenith.ai';
  static const int apiTimeoutSeconds = 30;
  
  // Cache Configuration
  static const int cacheMaxAgeMinutes = 60;
  static const int chatHistoryLimit = 50;
  
  // Security
  static const int sessionTimeoutMinutes = 60;
  static const int maxLoginAttempts = 5;
  
  // Private constructor to prevent instantiation
  AppConfig._();
  
  // Getters for computed properties
  static String get fullAppName => '$appName $appDescription';
  static String get supportEmailLink => 'mailto:$supportEmail';
  static String get copyrightWithYear => '© ${DateTime.now().year} $appName. All rights reserved.';
}
