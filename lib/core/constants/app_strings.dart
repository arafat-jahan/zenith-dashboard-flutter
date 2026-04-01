// lib/core/constants/app_strings.dart
import '../config/app_config.dart';

class AppStrings {
  // App Branding (Using AppConfig for white-labeling)
  static const String appName = AppConfig.appName;
  static const String appTagline = AppConfig.tagline;
  static const String appDescription = AppConfig.appDescription;
  static const String trustedBy = 'Trusted by 24,000+ developers';
  static const String testimonialText = '"${AppConfig.appName} cut our inference costs by 60% while doubling throughput. Absolute game changer."';
  static const String testimonialAuthor = 'Sarah Kim';
  static const String testimonialAuthorRole = 'CTO at NovaTech';

  // Navigation Labels
  static const String navPlatform = 'PLATFORM';
  static const String navAccount = 'ACCOUNT';
  static const String navDashboard = 'Dashboard';
  static const String navPlayground = 'AI Playground';
  static const String navAnalytics = 'Analytics';
  static const String navApiKeys = 'API Keys';
  static const String navNotifications = 'Notifications';
  static const String navPricing = 'Pricing';
  static const String navSettings = 'Settings';

  // User Profile
  static const String userName = 'John Dev';
  static const String userEmail = 'john@company.com';
  static const String userPlan = 'Pro Plan';
  static const String userTimezone = 'UTC+6 (Dhaka)';
  static const String userCompany = 'Acme Corp';
  static const String userFullName = 'John Developer';

  // Chat Screen
  static const String chatHeaderTitle = 'AI Playground';
  static const String chatHeaderSubtitle = 'Chat with our frontier models';
  static const String chatInputHint = 'Message ${AppConfig.appName}…';
  static const String chatEmptyStateTitle = 'Start a conversation';
  static const String chatEmptyStateSubtitle = 'Ask anything — analyze, generate, reason.';
  static const List<String> chatSuggestions = [
    'Analyze my API usage patterns',
    'Help me optimize model latency',
    'Summarize this quarter\'s metrics',
    'Write a Python script for batch inference',
  ];

  // Auth Screen
  static const String loginTitle = 'Welcome back';
  static const String loginSubtitle = 'Sign in to your ${AppConfig.appName} account';
  static const String orContinueWithEmail = 'or continue with email';
  static const String emailLabel = 'Email';
  static const String passwordLabel = 'Password';
  static const String forgotPassword = 'Forgot password?';
  static const String signIn = 'Sign in';
  static const String dontHaveAccount = "Don't have an account? ";
  static const String signUpFree = 'Sign up free';
  static const String alreadyHaveAccount = 'Already have an account? ';
  static const String signUpTitle = 'Create account';
  static const String signUpSubtitle = 'Join ${AppConfig.appName} to scale your ambition';
  static const String fullNameLabel = 'Full Name';

  // Dashboard Screen
  static const String dashboardGreeting = 'Good morning';
  static const String dashboardSubtitle = 'Here\'s what\'s happening with your platform today.';

  // Errors
  static const String errorAuthRequired = 'User not authenticated';
  static const String errorApiKeyMissing = 'Error: Gemini API Key is missing. Please add it to your environment variables or .env file.';
  static const String errorModelUnavailable = 'Error: AI model is temporarily unavailable. Please check your API key, billing status, and VPN connection.';
}
