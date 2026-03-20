# 🚀 Zenith AI - Premium Flutter Dashboard Kit

[![Flutter](https://img.shields.io/badge/Flutter-3.24+-02569B?logo=flutter&logoColor=white)](https://flutter.dev)
[![Riverpod](https://img.shields.io/badge/Riverpod-2.0-764ABC?logo=riverpod&logoColor=white)](https://riverpod.dev)
[![License](https://img.shields.io/badge/Certification-Production--Ready-success)](https://github.com)
[![Design](https://img.shields.io/badge/Design-Apple--Standard-black)](https://developer.apple.com/design/human-interface-guidelines/)

**Zenith AI** is an enterprise-grade, pixel-perfect Flutter dashboard kit architected for high-end SaaS applications. It combines the aesthetic of Apple’s Human Interface Guidelines with the power of modern AI streaming.

---

## ✨ ZENITH AI PRODUCTION CERTIFIED
This codebase has been rigorously audited and certified for production use:
- **Architecture:** 100% DDD & Repository Pattern (Decoupled & Testable).
- **State Management:** Riverpod 2.0 (Modern Notifiers/AsyncNotifiers).
- **Security:** Zero-Leak Environment Config (Safe for Public GitHub Repos).
- **Visuals:** Layered Shadows & Interactive Glassmorphism.
- **Performance:** Optimized Sliver Rendering & Adaptive Layouts.
- **AI Logic:** Native Typewriter Streaming with Haptic Feedback.

---

## 💎 Premium Features

### 🎨 Visual "Wow" Factor
- **Staggered Bento Entrance:** Dashboard cards animate sequentially for a high-end feel.
- **Interactive Glassmorphism:** Real-time blur with mouse-following radial gradient glow.
- **Premium Depth:** Custom double-layered BoxShadows for enterprise-grade UI.
- **Adaptive Layout:** Fully responsive from mobile to ultra-wide desktop screens.

### 🧠 Intelligent AI Core
- **Native Typewriter Streaming:** Real-time AI response rendering with a smooth typing effect.
- **Tactile Typing:** Integrated Haptic Feedback (`lightImpact`) for every generated word.
- **Pro-Level Mock Mode:** Test the full UI and animations without an API key.
- **Dynamic Error Handling:** Specialized "Retry Connection" UI for API failures.

### 🏗️ Elite Architecture
- **Clean Code:** Strictly follows the Repository Pattern and Domain-Driven Design (DDD).
- **Config-Driven Navigation:** Centralized `NavConfig` for 1-line menu updates.
- **Zero Mercy Cleanup:** Scrubbed of all unused code, hardcoded strings, and security leaks.

---

## 🛠️ Tech Stack
- **Framework:** Flutter (Latest Stable)
- **State:** Riverpod 2.0 (Notifiers)
- **Database:** Firebase Firestore
- **Auth:** Firebase Auth / Mock Fallback
- **AI:** Google Gemini API
- **Icons:** Lucide Icons
- **Animation:** Flutter Custom Animations & EaseOutExpo Curves

---

## 🚀 Getting Started

### Prerequisites
- Flutter SDK (latest stable)
- Firebase Account (optional for Demo Mode)
- Google Gemini API Key

### Quick Start
1. **Clone & Install:**
   ```bash
   git clone https://github.com/yourusername/zenith_ai.git
   cd zenith_ai
   flutter pub get
   ```

2. **Environment Setup:**
   Create a `.env` file in the root directory (refer to `.env.example`):
   ```env
   GEMINI_API_KEY=your_key_here
   ```

3. **Generate Models:**
   ```bash
   dart run build_runner build --delete-conflicting-outputs
   ```
   *Note: `*.freezed.dart` and `*.g.dart` files are auto-generated.*

4. **Run the App:**
   ```bash
   flutter run --dart-define-from-env-file=.env
   ```

---

## 📱 Platform Specifics

### iOS Setup
1. Download `GoogleService-Info.plist` from Firebase Console.
2. Open `ios/Runner.xcworkspace` in **Xcode**.
3. Drag and drop the plist into the `Runner` folder inside Xcode.
4. Ensure it's added to the **Build Phases** → **Copy Bundle Resources**.

### Android Setup
1. Download `google-services.json` from Firebase Console.
2. Place it in `android/app/`.

---

## 📂 Project Structure (DDD)
```text
lib/
├── core/           # Infrastructure, Shared Models, Constants, Theme
├── features/       # Modular features (Dashboard, Chat, Analytics, etc.)
│   ├── feature/
│   │   ├── providers/
│   │   ├── screens/
│   │   └── widgets/
├── shared/         # Reusable premium UI components (GlassCard, Shimmer)
└── main.dart       # Entry point with ProviderObserver logging
```

---

## 📄 License
This project is built for the Indie Hacker community. Go forth and ship something amazing! 🚀

---
Built with ❤️ by [Your Name/Company]
