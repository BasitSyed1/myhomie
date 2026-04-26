# MyHomie

A Flutter real-estate marketplace app for browsing, favoriting and listing properties (houses, apartments, shops, plots), backed by Firebase (Auth, Firestore, Realtime Database, Storage).

## Features

- Email/password sign-up and login (Firebase Auth)
- Browse listings by category: House, Apartment, Shop, Property
- Property detail screen with image carousel, contact actions and stats
- Favorite / unfavorite listings (in-memory via `provider`)
- Submit a new listing with multi-image upload to Firebase Storage
- Profile screen with edit-profile and image upload
- Stylish bubble bottom navigation

## Tech Stack

- **Flutter** (Material 3)
- **Firebase**: Auth, Cloud Firestore, Realtime Database, Storage
- **State management**: `provider`
- **Navigation**: named routes via `AppRoutes`
- **Media**: `image_picker`, `multi_image_picker_plus`
- **UI**: `carousel_slider`, `stylish_bottom_bar`

## Project Structure

```
lib/
├── main.dart                          # Bootstrap: Firebase init + runApp
├── app/
│   ├── app.dart                       # Root MaterialApp
│   ├── routes/app_routes.dart         # Named-route definitions
│   └── theme/app_theme.dart           # ThemeData + brand colors
├── core/
│   └── constants/sample_listings.dart # Mock data shared by category screens
├── data/
│   ├── models/property_listing.dart
│   ├── providers/                     # FavoriteProvider, SearchFilterProvider
│   └── services/                      # AuthService, ListingService
├── features/                          # One folder per feature
│   ├── auth/                          # Sign-in, sign-up
│   ├── home/                          # Home screen, bottom nav
│   ├── listings/
│   │   ├── add_listing_page.dart
│   │   ├── detail_page.dart
│   │   └── categories/                # House, Apartment, Shop, Property
│   ├── favorites/                     # Favorites list
│   └── profile/                       # Profile, edit-profile
└── shared/
    └── widgets/                       # SearchWidget, HeadingText, ListingCard, MainListingCard
```

## Getting Started

### Prerequisites
- Flutter SDK >= 3.5.3
- A configured Firebase project with Auth, Firestore, Realtime Database and Storage enabled

### Setup
```bash
flutter pub get
flutter run
```

For production, generate `firebase_options.dart` via the [FlutterFire CLI](https://firebase.google.com/docs/flutter/setup):

```bash
flutterfire configure
```
and pass the generated `DefaultFirebaseOptions.currentPlatform` to `Firebase.initializeApp` in `lib/main.dart`.

### Useful commands
```bash
flutter analyze        # Static analysis
flutter test           # Run tests
flutter build apk      # Build Android release
flutter build ios      # Build iOS release
```

## License

Private project — all rights reserved.
