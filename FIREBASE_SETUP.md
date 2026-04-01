# Firebase Console Setup Instructions

## 🚀 Enterprise-Grade Authentication Setup

### 1. Enable Google Sign-In

1. **Go to Firebase Console**: https://console.firebase.google.com/
2. **Select your project**: `flutter-projects-b9531`
3. **Navigate to Authentication** → **Sign-in method**
4. **Click on Google** in the provider list
5. **Enable the toggle switch**
6. **Add your project details**:
   - **Project public-facing name**: `Zenith AI Dashboard`
   - **Project support email**: `support@zenith.ai` (or your email)
7. **Click "Save"**
8. **Download the configuration file** if prompted

### 2. Enable Apple Sign-In (Optional but recommended)

1. **In the same Authentication → Sign-in method page**
2. **Click on Apple**
3. **Enable the toggle switch**
4. **Configure your Apple Developer account**:
   - You need an Apple Developer Program membership
   - Add your app in App Store Connect
   - Configure Sign in with Apple in your app's capabilities
5. **Add your Service ID** and Team ID
6. **Click "Save"**

### 3. Configure Email Verification

1. **Go to Authentication → Templates**
2. **Click on "Email address verification"**
3. **Customize the email template**:
   - **Subject**: `Verify your Zenith AI account`
   - **Message**: Include your branding and clear instructions
4. **Set up custom email domain** (optional but professional):
   - Go to **Authentication → Settings**
   - **Configure email domain**
   - Add SPF/DKIM records to your DNS

### 4. Deploy Firestore Security Rules

1. **Go to Firestore Database**
2. **Click on the "Rules" tab**
3. **Replace the existing rules** with the content from `firestore.rules`
4. **Click "Publish"**
5. **Test the rules** in the simulator to ensure they work correctly

### 5. Configure Additional Security Settings

#### Email/Password Authentication:
1. **Authentication → Sign-in method → Email/Password**
2. **Enable "Email link (passwordless sign-in)"** for enhanced security
3. **Set password strength requirements**

#### Rate Limiting:
1. **Authentication → Settings**
2. **Configure rate limiting** for:
   - Password reset requests
   - Email verification attempts
   - Sign-up attempts

#### Session Management:
1. **Authentication → Settings**
2. **Set appropriate session duration** (recommended: 1 hour for security)
3. **Enable "Multi-factor authentication"** for enterprise users

### 6. Platform-Specific Configuration

#### Android:
1. **Add SHA-1 fingerprint** to Firebase Console:
   ```bash
   keytool -list -v -keystore ~/.android/debug.keystore
   ```
2. **Copy the SHA-1 certificate fingerprint**
3. **Go to Project Settings → Your Apps → Android**
4. **Add the SHA-1 fingerprint**

#### iOS:
1. **Add your Bundle ID** to Firebase Console
2. **Download `GoogleService-Info.plist`**
3. **Add it to your Xcode project**
4. **Configure URL schemes** in `Info.plist`

#### Web:
1. **Add authorized domains**:
   - `localhost` for development
   - Your production domain
   - Any staging domains

### 7. Test the Setup

1. **Run your Flutter app**:
   ```bash
   flutter run
   ```
2. **Test Google Sign-In flow**
3. **Test email verification**
4. **Test security rules** by attempting to access other users' data
5. **Verify error handling** and loading states

### 8. Production Checklist

- [ ] Enable Google Sign-In
- [ ] Enable Apple Sign-In (if applicable)
- [ ] Configure email verification templates
- [ ] Deploy Firestore security rules
- [ ] Set up rate limiting
- [ ] Configure session management
- [ ] Add SHA-1 fingerprints (Android)
- [ ] Configure Bundle ID (iOS)
- [ ] Add authorized domains (Web)
- [ ] Test all authentication flows
- [ ] Verify security rules work correctly

### 🔐 Security Notes

- The Firestore rules ensure users can **only access their own data**
- Email verification is **enforced** before users can access the chat
- All authentication attempts include **proper error handling**
- **Rate limiting** prevents brute force attacks
- **Session management** ensures proper logout functionality

### 📱 Platform Support

- ✅ **Android**: Google Sign-In, Email/Password, Apple Sign-In
- ✅ **iOS**: Google Sign-In, Email/Password, Apple Sign-In  
- ✅ **Web**: Google Sign-In, Email/Password
- ✅ **Desktop**: Email/Password (Google Sign-In available on some platforms)

Your authentication system is now **enterprise-grade** with security features that justify the $10,000 valuation! 🎉
