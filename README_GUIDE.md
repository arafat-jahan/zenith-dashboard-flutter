# Zenith AI UI Kit - Production Setup Guide

Welcome to the **Zenith AI UI Kit**. This project is architected for scale, security, and maintainability using **DDD (Domain-Driven Design)** principles and the **Repository Pattern**.

---

## 🚀 Environment Setup

This project uses `String.fromEnvironment` to manage secrets securely. This prevents API keys from being hardcoded in your source control.

### 1. Create a `.env` file
Copy the `.env.example` to a new file named `.env` (this file is gitignored).

```bash
cp .env.example .env
```

### 2. Run with Dart Defines
To pass these variables to your Flutter app, use the `--dart-define-from-file` flag:

**VS Code (`launch.json`):**
```json
{
  "args": ["--dart-define-from-file=.env"]
}
```

**Terminal:**
```bash
flutter run --dart-define-from-file=.env
```

**Required Keys:**
- `GEMINI_API_KEY`: Your Google AI Studio key.
- `FIREBASE_WEB_API_KEY`: From your Firebase Console.
- `FIREBASE_ANDROID_API_KEY`: From your Firebase Console.
- `FIREBASE_IOS_API_KEY`: From your Firebase Console.

### 3. Android Studio Run Configuration
To set up your environment in Android Studio:

1. Go to **Run** > **Edit Configurations**.
2. Click the **+** icon and select **Flutter**.
3. In the **"Additional run args"** field, add:
   `--dart-define-from-file=.env`
   *(Or individually: `--dart-define=GEMINI_API_KEY=your_key_here`)*
4. Click **OK** and click the **Run** icon.


---

## 🏗 Architecture Pattern

We follow a modular **DDD + Repository** pattern to ensure a clean separation of concerns:

- **`lib/core/`**: Shared infrastructure, themes, and global models.
- **`lib/features/`**: Modularized features (Auth, Chat, Analytics). Each feature is self-contained.
- **`lib/shared/`**: Atomic UI components used across multiple features.

### Repository Pattern
All data fetching is abstracted behind **Interfaces** (`lib/core/repositories/interfaces/`). This allows you to:
1. Swap Firebase for a custom backend without touching the UI.
2. Unit test features using Mock repositories.
3. Maintain a "Single Source of Truth" for data logic.

---

## 💳 Billing & Stripe Integration

Currently, the billing logic is handled by `MockBillingRepository` for demonstration purposes.

### How to connect a real Stripe Webhook:
1. **Backend**: Deploy a server (Node.js/Go) or Firebase Cloud Function to handle Stripe Webhooks.
2. **Update Repository**: Replace `MockBillingRepository` with a real implementation in `lib/core/repositories/implementations/`.
3. **Flow**:
   - The app calls your backend to create a `Checkout Session`.
   - The user completes payment on Stripe's hosted page.
   - Your backend receives the `invoice.paid` webhook.
   - Your backend updates the user's `plan` field in Firestore.
   - The Flutter app (listening via `userProfileProvider`) automatically reflects the new plan status.

---

## 🔐 Security Best Practices

- **Secrets**: NEVER hardcode keys. Always use `--dart-define`.
- **API Access**: For production, we recommend moving Gemini/LLM calls to a **Firebase Cloud Function**. This protects your API key from being extracted via app decompilation and allows you to implement server-side rate limiting and usage validation.
- **ProGuard/R8**: Always enable obfuscation in your release builds to further protect your business logic.
