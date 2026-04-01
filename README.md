<div align="center">

<img src="https://capsule-render.vercel.app/api?type=waving&color=6366f1,a855f7,06b6d4&height=200&section=header&text=Zenith%20AI&fontSize=80&fontColor=ffffff&fontAlignY=38&desc=Enterprise%20Flutter%20SaaS%20Dashboard%20Kit&descAlignY=60&descSize=18&animation=fadeIn" width="100%"/>

<br/>

[![Flutter](https://img.shields.io/badge/Flutter-3.24+-02569B?style=for-the-badge&logo=flutter&logoColor=white)](https://flutter.dev)
[![Dart](https://img.shields.io/badge/Dart-3.0+-0175C2?style=for-the-badge&logo=dart&logoColor=white)](https://dart.dev)
[![Riverpod](https://img.shields.io/badge/Riverpod-2.0-764ABC?style=for-the-badge&logoColor=white)](https://riverpod.dev)
[![Firebase](https://img.shields.io/badge/Firebase-Latest-FFA000?style=for-the-badge&logo=firebase&logoColor=white)](https://firebase.google.com)
[![Gemini](https://img.shields.io/badge/Gemini_API-1.5-4285F4?style=for-the-badge&logo=google&logoColor=white)](https://ai.google.dev)
[![Stripe](https://img.shields.io/badge/Stripe-Payments-6772E5?style=for-the-badge&logo=stripe&logoColor=white)](https://stripe.com)

<br/>

[![iOS](https://img.shields.io/badge/iOS-supported-black?style=flat-square&logo=apple&logoColor=white)](https://flutter.dev)
[![Android](https://img.shields.io/badge/Android-supported-3DDC84?style=flat-square&logo=android&logoColor=white)](https://flutter.dev)
[![Web](https://img.shields.io/badge/Web-supported-6366F1?style=flat-square&logo=googlechrome&logoColor=white)](https://flutter.dev)

<br/>

> **A production-ready Flutter SaaS starter kit** — AI streaming chat, Firebase auth, Stripe billing, analytics dashboard, and admin panel. Fully modular. White-label ready.

<br/>

</div>

---

## ✦ What's Inside

<table>
<tr>
<td width="50%">

**🧠 AI Streaming Chat**
Real-time Gemini 1.5 Flash/Pro responses with typewriter rendering, haptic feedback per token, and a retry UI for API failures.

**🔐 Complete Auth System**
Email/password, Google Sign-In, Apple Sign-In, email verification — all wired to Firebase Auth with a clean repository interface.

**💳 Stripe Billing**
Checkout Sessions created server-side via Cloud Functions. Webhook handler automatically upgrades user plan in Firestore.

**📊 Analytics Dashboard**
KPI cards, latency charts, request volume graphs, model usage breakdown. Admin panel with separate provider scope.

</td>
<td width="50%">

**🔑 API Key Manager**
Full BYOK (Bring Your Own Key) scaffold — Freezed model, UI screen, and credential storage. Wire the read path and ship.

**🔔 Notification Feed**
In-app notifications backed by Firestore. Unread count, mark-as-read, and animated notification cards.

**🎨 White-Label Ready**
Every brand string — app name, support email, social links, AI system prompt — lives in one file: `AppConfig`.

**📱 Fully Responsive**
Mobile to ultra-wide desktop via `responsive_framework`. Adaptive layouts with Sliver rendering.

</td>
</tr>
</table>

---

## ✦ Tech Stack

| Layer | Technology | Notes |
|---|---|---|
| Framework | Flutter 3.24+ | iOS · Android · Web |
| State Management | Riverpod 2.0 | `Notifier` / `AsyncNotifier` — modern API |
| Database | Firebase Firestore | Real-time sync, subcollection structure |
| Authentication | Firebase Auth | Email · Google · Apple Sign-In |
| AI | Google Gemini API | 1.5 Flash (default) · 1.5 Pro (selectable) |
| Billing | Stripe | Checkout Sessions + Webhook handler |
| Backend | Firebase Cloud Functions | TypeScript v2 — `onCall` + `onRequest` |
| Models | Freezed 2.x | Immutable, copyWith, JSON serialization |
| Icons | Lucide Icons | Consistent icon system |
| Responsive | responsive_framework | Breakpoint-aware layouts |

---

## ✦ Architecture

```
lib/
├── core/
│   ├── config/              ← AppConfig — rebrand entire app in 1 file
│   ├── models/              ← Freezed data models
│   ├── repositories/
│   │   ├── interfaces/      ← Abstract contracts (IBillingRepo, IChatRepo...)
│   │   └── implementations/ ← Firebase + Mock (swap with 1 line)
│   ├── router/              ← Route definitions
│   └── theme/               ← Colors, text styles, glow extensions
│
├── features/                ← Each module is fully self-contained
│   ├── auth/                ← Login · Register · Email verification
│   ├── chat/                ← AI streaming · Paywall · Message history
│   ├── dashboard/           ← Bento stats · Activity feed · Charts
│   ├── analytics/           ← KPIs · Latency · Model breakdown
│   ├── pricing/             ← Plans · Stripe Checkout
│   ├── api_keys/            ← BYOK credential manager
│   ├── notifications/       ← In-app notification feed
│   └── admin/               ← Admin dashboard
│
└── shared/
    └── widgets/             ← GlassCard · BaseShimmer · GradientBadge
```

**Repository Pattern:** Every data source is defined as an abstract interface first. Firebase and Mock implementations exist for all repositories — letting you run the entire app with zero credentials in Demo Mode.

---

## ✦ Getting Started

### Prerequisites
- Flutter SDK (latest stable)
- Firebase project *(optional — Demo Mode works without it)*
- Google Gemini API key *(optional — Mock Mode works without it)*

### 1. Clone & Install

```bash
git clone https://github.com/yourusername/zenith_ai.git
cd zenith_ai
flutter pub get
```

### 2. Generate Models

```bash
dart run build_runner build --delete-conflicting-outputs
```

### 3. Environment

Create `.env` from the included `.env.example`:

```env
GEMINI_API_KEY=your_key_here
```

### 4. Run

```bash
flutter run --dart-define-from-env-file=.env
```

> **No keys?** Run the app as-is. Mock repositories serve the full UI, all animations, and simulated streaming chat — no config needed.

---

## ✦ Firebase Setup

1. Create a project at [console.firebase.google.com](https://console.firebase.google.com)
2. Enable **Authentication** → Email/Password · Google · Apple
3. Create a **Firestore** database in production mode
4. Place `google-services.json` → `android/app/`
5. Place `GoogleService-Info.plist` → `ios/Runner/` via Xcode
6. Deploy rules and functions:

```bash
firebase deploy --only firestore:rules
cd functions && npm install && firebase deploy --only functions
```

Full walkthrough in [`FIREBASE_SETUP.md`](./FIREBASE_SETUP.md)

---

## ✦ Stripe Setup

Set these in `functions/.env`:

```env
STRIPE_SECRET_KEY=sk_live_...
STRIPE_WEBHOOK_SECRET=whsec_...
STRIPE_PRICE_PRO=price_...
STRIPE_PRICE_ENTERPRISE=price_...
```

The `createStripeCheckout` Cloud Function creates the session server-side. The `stripeWebhook` function listens for `checkout.session.completed` and updates the user plan in Firestore — no client-side trust required.

---

## ✦ White Labeling

Edit **one file** to rebrand the entire app:

```dart
// lib/core/config/app_config.dart

static const String appName         = 'Your App Name';
static const String supportEmail    = 'support@yourdomain.com';
static const String companyWebsite  = 'https://yourdomain.com';
static const String defaultSystemPrompt = 'You are [Your AI Name]...';
```

Full guide in [`WHITE_LABELING_GUIDE.md`](./WHITE_LABELING_GUIDE.md)

---

## ✦ Platform Notes

| Platform | Min Version | Notes |
|---|---|---|
| iOS | iOS 12+ | Requires Xcode for `GoogleService-Info.plist` and Apple Sign-In capability |
| Android | SDK 21+ | Place `google-services.json` in `android/app/` |
| Web | All modern browsers | `flutter build web` — deploy to Firebase Hosting |

---

<div align="center">

<img src="https://capsule-render.vercel.app/api?type=waving&color=6366f1,a855f7,06b6d4&height=100&section=footer" width="100%"/>


</div>
