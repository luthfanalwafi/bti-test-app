# Flutter News App – Technical Test

## 1. Project Overview
This project is a Flutter mobile application developed as part of a technical assessment.

The application includes:
- Google Sign-In authentication using Firebase
- Guest login
- News browsing using NewsAPI
- News detail page
- Chat support page with chatbot simulation
- Local data persistence using SQLite
- Offline mode support
- Integration testing for the main user flow

---

## 2. Installation Instructions

### Flutter Version
Tested with:
Flutter 3.35.4

### Install Dependencies
Run:
flutter pub get

### Firebase Configuration
1. Create a Firebase project
2. Enable Google Sign-In in Firebase Authentication
3. Download `google-services.json`
4. Place it in:

android/app/

### NewsAPI Configuration
1. Get your API key from:
https://newsapi.org

2. Create file:
lib/config/env.dart

3. Add your API key:
const apiKey = "YOUR_API_KEY";

---

## 3. Run Instructions

Run the application:
flutter run

To build APK:
flutter build apk --release

---

## 4. Folder Structure

lib/
│
├── commons/       # Reusable widgets and shared UI components
├── models/        # Data models
├── services/      # API, database, utilities
├── provider/      # State management
├── router/        # Routing page
├── pages/         # Application pages
│   ├── login/
│   ├── home/
│   ├── news-detail/
│   ├── support-chat/
│   ├── bookmark/
│   └── profile/
│
├── widgets/       # Reusable UI components
└── main.dart      # Application entry point

integration_test/
└── app_test.dart  # Integration test for full user flow

---

## 5. Implemented Features

- Google Sign-In using Firebase Authentication
- Guest login mode
- News list page using NewsAPI
- News detail page
- Bookmark feature
- Chat support page with chatbot replies
- Send text messages and images
- SQLite storage for:
  - logged-in user
  - cached news data
  - chat history
- Offline access for news and chat
- Integration test for the complete user flow

---

## 6. Testing Instructions

Run integration tests:
flutter test integration_test

The test covers:
login → browse news → bookmark → open chat → send message

---

## 7. Additional Notes

- NewsAPI key activation may take some time.
- Offline mode will display cached news and chat history if no internet connection is available.
- Google Sign-In may require a valid SHA-1 configuration in Firebase.
- Emulator devices may require Google Play services for authentication.

---

## APK Build

The release APK can be found at:
build/app/outputs/flutter-apk/app-release.apk