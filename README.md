# Zenith AI

A Flutter SaaS dashboard kit built with Riverpod 2.0, Firebase, and the Google Gemini API. Designed as a production-ready starting point for AI-powered applications.

---

## Tech Stack

| Layer | Technology |
|---|---|
| Framework | Flutter 3.24+ |
| State Management | Riverpod 2.0 (Notifier / AsyncNotifier) |
| Database | Firebase Firestore |
| Authentication | Firebase Auth (Email, Google, Apple) |
| AI | Google Gemini 1.5 Flash / Pro |
| Billing | Stripe (Checkout Sessions + Cloud Functions) |
| Backend | Firebase Cloud Functions (TypeScript) |
| Icons | Lucide Icons |

---

## Features

- **AI Chat** — Streaming responses from Gemini with a typewriter rendering effect and haptic feedback
- **Authentication** — Email/password, Google Sign-In, Apple Sign-In, email verification flow
- **Subscription Billing** — Stripe Checkout integration with Firebase Cloud Functions webhook handler
- **Credit System** — Per-message credit consumption with a paywall overlay
- **Admin Dashboard** — Separate admin provider and screen for user management
- **Analytics Screen** — KPI cards, latency chart, request volume, model breakdown
- **API Key Management** — UI for storing and managing user-provided API credentials
- **Notifications** — In-app notification feed with Firestore backing
- **Responsive Layout** — Mobile to ultra-wide desktop via `responsive_framework`
- **Dark Theme** — Glassmorphism UI with custom glow effects and gradient accents

---

## Architecture

Follows a Repository Pattern with Domain-Driven Design (DDD) structure. Each feature is self-contained with its own providers, screens, and widgets. Repositories are defined as abstract interfaces first, with separate Firebase and Mock implementations — allowing full UI development and testing without a live backend.

```
lib/
├── core/
│   ├── config/          # App-wide constants and feature flags
│   ├── models/          # Shared data models (Freezed)
│   ├── providers/       # Cross-feature providers
│   ├── repositories/
│   │   ├── interfaces/  # Abstract contracts
│   │   └── implementations/  # Firebase + Mock
│   ├── router/          # Route definitions
│   └── theme/           # Colors, text styles, extensions
├── features/
│   ├── admin/
│   ├── analytics/
│   ├── api_keys/
│   ├── auth/
│   ├── chat/
│   ├── dashboard/
│   ├── notifications/
│   └── pricing/
└── shared/
    └── widgets/         # GlassCard, Shimmer, GradientBadge, etc.
```

---

## Getting Started

**Prerequisites:** Flutter SDK (latest stable), Firebase project, Gemini API key

```bash
git clone https://github.com/yourusername/zenith_ai.git
cd zenith_ai
flutter pub get
dart run build_runner build --delete-conflicting-outputs
```

Create a `.env` file from the provided `.env.example`:

```env
GEMINI_API_KEY=your_key_here
```

Run the app:

```bash
flutter run --dart-define-from-env-file=.env
```

**Demo Mode:** The app runs without any API key or Firebase config. Mock repositories provide full UI navigation and a simulated streaming chat experience.

---

## Firebase Setup

1. Create a Firebase project and enable Firestore, Authentication, and Cloud Functions
2. Place `google-services.json` in `android/app/`
3. Place `GoogleService-Info.plist` in `ios/Runner/` via Xcode
4. Deploy security rules: `firebase deploy --only firestore:rules`
5. Deploy functions: `cd functions && npm install && firebase deploy --only functions`

Detailed steps are in `FIREBASE_SETUP.md` included in the repository.

---

## Stripe Setup

The Cloud Function `createStripeCheckout` creates a Stripe Checkout Session server-side. The `stripeWebhook` function listens for `checkout.session.completed` and updates the user's plan in Firestore automatically.

Set the following environment variables in `functions/.env`:

```
STRIPE_SECRET_KEY=sk_live_...
STRIPE_WEBHOOK_SECRET=whsec_...
STRIPE_PRICE_PRO=price_...
STRIPE_PRICE_ENTERPRISE=price_...
```

---

## White Labeling

All brand-facing strings (app name, support email, website, social links, system prompt) are centralized in `lib/core/config/app_config.dart`. Rebranding requires editing one file. A full white-labeling guide is included as `WHITE_LABELING_GUIDE.md`.

---

## Platform Notes

- **iOS:** Requires Xcode for `GoogleService-Info.plist` integration and Apple Sign-In capability
- **Android:** Minimum SDK 21
- **Web:** Supported via `flutter build web`

---

Built by [Your Name](https://github.com/yourusername)
