# small-app-gcp Variant Setup Guide

## Overview

The `small-app-gcp` variant extends the base `small-app` template with Google Cloud Platform services:
- Firebase Authentication (email, Google Sign-In, phone)
- Cloud Firestore for real-time database
- Google Cloud Storage for file uploads
- Cloud Logging for centralized logging
- Cloud Functions for serverless backend

## Prerequisites

- Google Cloud Platform account
- Firebase project created
- Google Cloud CLI installed
- Firebase CLI installed: `npm install -g firebase-tools`
- Flutter 3.19.0 or higher

## Structure

```
small-app-gcp/
├── lib/
│   ├── config/
│   │   └── gcp_config.dart             # Firebase/GCP configuration
│   └── services/
│       └── firebase_service.dart       # Firebase authentication
├── android/google-services.json        # Android Firebase config
├── ios/GoogleService-Info.plist        # iOS Firebase config
├── README_GCP.md                       # This file
└── pubspec_additions.yaml              # Firebase dependencies
```

## Setup Instructions

### 1. Copy Base Template

```bash
cp -r variants/small-app my-gcp-app
cd my-gcp-app
```

### 2. Add GCP Extensions

```bash
mkdir -p lib/config lib/services
cp ../small-app-gcp/lib/config/gcp_config.dart lib/config/
cp ../small-app-gcp/lib/services/firebase_service.dart lib/services/
```

### 3. Create Firebase Project

Go to [Firebase Console](https://console.firebase.google.com):

1. Click "Create Project"
2. Enter project name (e.g., "my-gcp-app")
3. Continue with default settings
4. Wait for project creation

### 4. Configure Flutter for Firebase

```bash
# Install Firebase CLI
npm install -g firebase-tools

# Login to Firebase
firebase login

# Initialize Firebase in Flutter
flutterfire configure
# Select your Firebase project
# Choose Android and iOS platforms
```

This automatically generates:
- `android/google-services.json`
- `ios/GoogleService-Info.plist`
- Updates `pubspec.yaml` with Firebase dependencies

### 5. Update Configuration

Edit `lib/config/gcp_config.dart`:

```dart
// From Firebase Console → Project Settings
static const String firebaseProjectId = 'my-gcp-app';
static const String firebaseApiKey = 'AIza...'; // From Google Services
static const String storageBucket = 'my-gcp-app.appspot.com';
```

### 6. Enable Firebase Services

In Firebase Console, enable:

- **Authentication:** Enable email/password and Google Sign-In
- **Firestore:** Create database in native mode
- **Storage:** Enable Cloud Storage bucket
- **Logging:** Automatically enabled

### 7. Install Dependencies

```bash
flutter pub get
flutter analyze
```

### 8. Run App

```bash
flutter run
```

## Firebase Service Setup Details

### Firebase Authentication

**Email/Password Sign-Up:**
```dart
import 'services/firebase_service.dart';

await FirebaseService.signUpUser(
  email: 'user@example.com',
  password: 'SecurePassword123!',
);
```

**Google Sign-In:**
```dart
await FirebaseService.signInWithGoogle();
```

**Phone Authentication:**
```dart
// Implement phone auth similar to email auth
// Use FirebaseAuth.instance.verifyPhoneNumber()
```

### Cloud Firestore Database

**Real-time data synchronization:**
```dart
import 'package:cloud_firestore/cloud_firestore.dart';

// Create document
FirebaseFirestore.instance.collection('users').doc(userId).set({
  'name': 'John Doe',
  'email': 'john@example.com',
  'createdAt': Timestamp.now(),
});

// Read real-time updates
FirebaseFirestore.instance
  .collection('users')
  .doc(userId)
  .snapshots()
  .listen((doc) {
    print(doc.data());
  });

// Query documents
FirebaseFirestore.instance
  .collection('users')
  .where('age', isGreaterThan: 18)
  .snapshots()
  .listen((snapshot) {
    for (var doc in snapshot.docs) {
      print(doc.data());
    }
  });
```

### Google Cloud Storage

**Upload files:**
```dart
import 'package:firebase_storage/firebase_storage.dart';

final file = File('/path/to/image.jpg');
final ref = FirebaseStorage.instance.ref()
  .child('images')
  .child('${userId}_profile.jpg');

await ref.putFile(file);
final url = await ref.getDownloadURL();
```

**Download files:**
```dart
final ref = FirebaseStorage.instance.ref()
  .child('images/${userId}_profile.jpg');

final bytes = await ref.getData();
final file = File('/path/to/download')..writeAsBytesSync(bytes);
```

### Cloud Logging

**Automatic logging:**
```dart
// Errors and important events automatically logged
// View in Google Cloud Console → Logging

// Manual logging
import 'package:firebase_analytics/firebase_analytics.dart';

FirebaseAnalytics.instance.logEvent(
  name: 'user_signup',
  parameters: {
    'method': 'email',
    'timestamp': DateTime.now().toString(),
  },
);
```

## Configuration Examples

### Scenario 1: Social App with Real-time Chat

```dart
// In gcp_config.dart
static const bool enableFirestore = true;
static const bool enableCloudStorage = true;

// In your chat service
final messagesRef = FirebaseFirestore.instance
  .collection('conversations')
  .doc(conversationId)
  .collection('messages')
  .orderBy('timestamp', descending: true);

messagesRef.snapshots().listen((snapshot) {
  for (var doc in snapshot.docs) {
    // Display new message
  }
});
```

### Scenario 2: Photo Sharing App

```dart
// Upload photo to Cloud Storage
final file = File(imagePath);
final ref = FirebaseStorage.instance.ref()
  .child('photos/${userId}/${uuid()}.jpg');

await ref.putFile(file);

// Save metadata to Firestore
await FirebaseFirestore.instance.collection('photos').add({
  'userId': userId,
  'url': await ref.getDownloadURL(),
  'uploadedAt': Timestamp.now(),
  'likes': 0,
});
```

### Scenario 3: Real-time Collaboration

```dart
// Firestore for collaborative editing
final docRef = FirebaseFirestore.instance
  .collection('documents')
  .doc(documentId);

// Watch for changes from other users
docRef.snapshots().listen((snapshot) {
  final content = snapshot.get('content');
  updateUI(content);
});

// Make changes
await docRef.update({
  'content': newContent,
  'lastModified': Timestamp.now(),
  'lastModifiedBy': userId,
});
```

## Cost Optimization

### Firebase Free Tier Limits
- **Authentication:** Unlimited sign-ins
- **Firestore:** 1GB storage, 50K read/20K write/20K delete daily
- **Cloud Storage:** 1GB/month, 1GB transfer/month
- **Cloud Logging:** 50GB/month logs

### Cost Reduction Strategies
1. **Firestore Pricing:**
   - Use on-demand billing for variable workloads
   - Optimize queries to reduce reads
   - Archive old data to Cloud Storage

2. **Cloud Storage:**
   - Use Cloud Storage Classes for archival (cheaper)
   - Enable automatic deletion of old files
   - Compress images before upload

3. **Cloud Logging:**
   - Set log retention (30-90 days)
   - Filter out debug logs in production
   - Use structured logging for better insights

## Troubleshooting

### Firebase Initialization Fails
- **Error:** "Plugin com.google.android.gms not found"
- **Solution:** Run `flutterfire configure` again
- **Check:** `google-services.json` exists in `android/app/`

### Authentication Not Working
- **Error:** "FirebaseAuth not initialized"
- **Solution:** Call `FirebaseService.initialize()` in main.dart
- **Debug:** Check Firebase Console → Authentication → Users

### Firestore Write Fails
- **Error:** "Permission denied"
- **Solution:** Update Firestore security rules:
  ```
  rules_version = '2';
  service cloud.firestore {
    match /databases/{database}/documents {
      match /{document=**} {
        allow read, write: if request.auth != null;
      }
    }
  }
  ```

### Cloud Storage Upload Fails
- **Error:** "Object not found"
- **Solution:** Check bucket name matches `gcp_config.dart`
- **Verify:** Firebase Console → Storage → Bucket settings

### Sign-In Button Not Appearing
- **Error:** Google Sign-In returns null
- **Solution:** Configure OAuth consent screen in Google Cloud Console
- **Setup:** Google Cloud → APIs & Services → OAuth consent screen

## Security Best Practices

✅ **Do:**
- Enable Firebase Rules to restrict data access
- Use Firebase Authentication for all user-facing features
- Enable two-factor authentication for Firebase Console
- Regularly rotate API keys
- Use Cloud IAM for role-based access control

❌ **Don't:**
- Expose Firebase API keys in public repositories
- Allow unauthenticated Firestore/Storage access
- Store sensitive data unencrypted in Firestore
- Share Firebase credentials across projects
- Hardcode user IDs in rules

## Performance Optimization

### Firestore Query Optimization
```dart
// ❌ Bad: Reads entire collection
FirebaseFirestore.instance.collection('users').get();

// ✅ Good: Filtered and limited query
FirebaseFirestore.instance
  .collection('users')
  .where('active', isEqualTo: true)
  .limit(20)
  .get();
```

### Image Upload Optimization
```dart
// ✅ Compress before upload
final compressed = await FlutterImageCompress.compressAndGetFile(
  originalFile.path,
  '${Directory.systemTemp.path}/image.jpg',
  quality: 85,
);

await ref.putFile(compressed);
```

### Firestore Real-time Listener Efficiency
```dart
// ✅ Only listen to changes you need
FirebaseFirestore.instance
  .collection('users')
  .doc(userId)
  .snapshots()
  .listen((doc) {
    // Only this user's data
  });
```

## Testing

### Test Firebase Auth
```bash
# Use Firebase Emulator Suite for testing
firebase emulators:start

# In your test:
// Connect to emulator
FirebaseAuth.instance.useAuthEmulator('localhost', 9099);
FirebaseFirestore.instance.useFirestoreEmulator('localhost', 8080);
```

### Test Cloud Functions
```bash
# Deploy test function
firebase functions:shell

# In shell:
> myFunction({param: 'value'})
```

## Deployment

### Deploy to Google Play (Android)
```bash
flutter build appbundle --release
# Upload to Google Play Console
```

### Deploy to App Store (iOS)
```bash
flutter build ios --release
# Upload to App Store Connect
```

### Deploy Firestore Rules
```bash
firebase deploy --only firestore:rules
```

## Next Steps

1. Complete Firebase setup with all services enabled
2. Implement authentication screens (sign-up, sign-in, password reset)
3. Create Firestore data models
4. Build real-time data sync features
5. Implement Cloud Storage upload/download
6. Set up Cloud Logging and monitoring
7. Deploy to app stores
8. Monitor usage and costs in Firebase Console

## Resources

- [Firebase Flutter Documentation](https://firebase.flutter.dev/)
- [Cloud Firestore Docs](https://firebase.google.com/docs/firestore)
- [Google Cloud Storage Docs](https://firebase.google.com/docs/storage)
- [Firebase Authentication](https://firebase.google.com/docs/auth)
- [Google Cloud Pricing](https://cloud.google.com/pricing)
