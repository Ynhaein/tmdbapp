# TMDB Movie Application

A modern, feature-rich Flutter application for browsing and managing movies from The Movie Database (TMDB). Discover popular movies, explore different genres, view detailed movie information, manage your favorite movies, and book tickets all in one elegant application.

## 📋 Table of Contents

- [Features](#features)
- [Tech Stack](#tech-stack)
- [Project Structure](#project-structure)
- [Installation & Setup](#installation--setup)
- [Getting Started](#getting-started)
- [Project Folder Tree](#project-folder-tree)
- [Architecture](#architecture)
- [Contributors](#contributors)

---

## ✨ Features

### Home Screen

- Display of popular and trending movies
- Quick access to featured content
- Smooth scrollable UI with movie previews
- Real-time data fetching from TMDB API

### Explore Feature

- Browse movies by genre
- Filter movies based on different categories
- Advanced search functionality
- Genre-based filtering system
- Comprehensive movie listings

### Movie Detail Screen

- Comprehensive movie information including:
  - Movie title, poster, and banner images
  - Plot synopsis and storyline
  - Runtime and release date
  - Cast and crew information
  - User ratings and vote averages
  - Production details
- View cast and credits information
- Related or similar movie recommendations

### Profile & Favorites

- Manage your favorite movies collection
- Personal movie watchlist
- User profile customization
- Quick access to saved movies

### Tickets Booking

- Book movie tickets directly from the app
- Select showtimes and venues
- Choose your seats
- Complete booking transactions
- Ticket management and history

### 🎨 User Interface

- Dark mode theme for comfortable viewing
- Responsive design for all device sizes
- Smooth animations and transitions
- Material Design 3 principles
- Edge-to-edge display support

---

## 🛠️ Tech Stack

### Framework & Language

- **Flutter** - Cross-platform mobile framework
- **Dart** - Programming language
- **Minimum SDK**: Dart 3.11.5

### Key Dependencies

| Package                  | Version | Purpose                      |
| ------------------------ | ------- | ---------------------------- |
| `dio`                    | ^5.7.0  | HTTP client for API requests |
| `cupertino_icons`        | ^1.0.8  | iOS-style icons              |
| `flutter_launcher_icons` | ^0.14.4 | App icon generation          |
| `flutter_lints`          | ^6.0.0  | Dart/Flutter linting         |

### Platforms Supported

- ✅ Android
- ✅ iOS
- ✅ Web
- ✅ Windows
- ✅ Linux
- ✅ macOS

---

## 📁 Project Structure

```
tmdb_app/
│
├── 📄 analysis_options.yaml       # Dart analysis configuration
├── 📄 pubspec.yaml                # Flutter dependencies & project config
├── 📄 README.md                   # This file
├── 📄 tmdb_app.iml                # IDE configuration
│
├── 📂 assets/
│   └── 📂 icons/                  # Application icons and branding
│       └── brand_logo.png
│
├── 📂 android/                    # Android native code & configuration
│   ├── build.gradle.kts
│   ├── gradle.properties
│   ├── gradlew & gradlew.bat
│   ├── settings.gradle.kts
│   └── 📂 app/
│       └── 📂 src/
│
├── 📂 ios/                        # iOS native code & configuration
│   ├── 📂 Flutter/
│   ├── 📂 Runner/
│   │   ├── AppDelegate.swift
│   │   ├── GeneratedPluginRegistrant.*
│   │   ├── Info.plist
│   │   └── 📂 Assets.xcassets/
│   ├── Runner.xcodeproj/
│   ├── Runner.xcworkspace/
│   └── 📂 RunnerTests/
│
├── 📂 linux/                      # Linux platform configuration
│   ├── CMakeLists.txt
│   ├── 📂 flutter/
│   └── 📂 runner/
│
├── 📂 macos/                      # macOS platform configuration
│   ├── 📂 Flutter/
│   ├── 📂 Runner/
│   ├── Runner.xcodeproj/
│   ├── Runner.xcworkspace/
│   └── 📂 RunnerTests/
│
├── 📂 windows/                    # Windows platform configuration
│   ├── CMakeLists.txt
│   ├── 📂 flutter/
│   └── 📂 runner/
│
├── 📂 web/                        # Web platform configuration
│   ├── index.html
│   ├── manifest.json
│   └── 📂 icons/
│
├── 📂 build/                      # Generated build files (Git ignored)
│   ├── 📂 app/
│   ├── 📂 native_assets/
│   └── 📂 reports/
│
├── 📂 test/                       # Unit and widget tests
│   └── widget_test.dart
│
└── 📂 lib/                        # Main application code
    ├── main.dart                  # Application entry point
    │
    ├── 📂 config/                 # Application configuration
    │   ├── 📂 constant/           # Constants and API configuration
    │   │   └── app_config.dart    # API keys and base URLs
    │   └── 📂 theme/              # Theme configuration
    │       └── app_theme.dart     # Dark theme and styling
    │
    ├── 📂 core/                   # Core functionality shared across features
    │   └── 📂 presentation/
    │       ├── 📂 models/
    │       │   └── movie_model.dart        # Core movie data model
    │       ├── 📂 page/
    │       │   ├── splash_screen.dart      # App splash/loading screen
    │       │   └── main_navigation.dart    # Navigation structure
    │       └── 📂 widgets/
    │           └── Reusable UI components
    │
    ├── 📂 features/               # Feature modules (MVVM/CLEAN ARCHITECTURE)
    │   ├── 📂 home/
    │   │   ├── 📂 page/           # Home screen UI
    │   │   ├── 📂 widgets/        # Home-specific widgets
    │   │   └── 📂 models/         # Home data models
    │   │
    │   ├── 📂 explore/
    │   │   ├── 📂 page/           # Explore/Browse screen
    │   │   ├── 📂 widgets/        # Genre filters and search widgets
    │   │   ├── 📂 models/         # Genre model, filter models
    │   │   └── genre_model.dart   # Genre data structure
    │   │
    │   ├── 📂 detail/
    │   │   ├── 📂 page/           # Movie detail screen
    │   │   ├── 📂 widgets/        # Detail page components
    │   │   ├── 📂 models/
    │   │   │   ├── movie_detail_model.dart
    │   │   │   └── credits_model.dart
    │   │
    │   ├── 📂 profile/
    │   │   ├── 📂 page/           # User profile screen
    │   │   ├── 📂 widgets/        # Profile UI components
    │   │   └── 📂 models/         # Profile/user data models
    │   │
    │   └── 📂 tickets/
    │       ├── 📂 page/           # Tickets booking screen
    │       ├── 📂 widgets/        # Booking UI components
    │       └── 📂 models/         # Ticket and booking data models
    │
    └── 📂 services/               # Service layer
        └── api_services.dart      # TMDB API integration & HTTP requests
```

---

## 🏗️ Architecture

This application follows **Clean Architecture** principles with clear separation of concerns:

### Layer Structure

```
Presentation Layer (UI/Pages/Widgets)
           ↓
State Management (If implemented)
           ↓
Business Logic Layer (Models/ViewModels)
           ↓
Data Layer (API Services)
           ↓
External Services (TMDB API)
```

### Key Components

| Component    | Purpose                                    |
| ------------ | ------------------------------------------ |
| **Pages**    | Screens/pages that users interact with     |
| **Widgets**  | Reusable UI components                     |
| **Models**   | Data structures and API response models    |
| **Services** | API calls and external service integration |
| **Config**   | Application-wide configuration and theming |
| **Core**     | Shared utilities and base components       |

---

## 📲 Installation & Setup

### Prerequisites

- Flutter SDK (3.11.5 or higher)
- Android SDK (for Android development)
- Xcode (for iOS development)
- Git

### Step 1: Clone the Repository

```bash
git clone <repository-url>
cd tmdb_app
```

### Step 2: Install Dependencies

```bash
flutter pub get
```

### Step 3: Configure API Key

1. Create a `.env` file or update `lib/config/constant/app_config.dart`
2. Add your TMDB API key:

```dart
class AppConfig {
  static const String apiKey = 'YOUR_TMDB_API_KEY';
  static const String baseUrl = 'https://api.themoviedb.org/3';
}
```

Get your API key from [TMDB API](https://www.themoviedb.org/settings/api)

### Step 4: Generate Icons (Optional)

```bash
flutter pub run flutter_launcher_icons
```

### Step 5: Run the Application

**For Android:**

```bash
flutter run -d android
```

**For iOS:**

```bash
flutter run -d ios
```

**For Web:**

```bash
flutter run -d chrome
```

**For Windows:**

```bash
flutter run -d windows
```

---

## 🚀 Getting Started

### Running in Development Mode

```bash
flutter run
```

### Building for Production

**Android APK:**

```bash
flutter build apk --release
```

**iOS IPA:**

```bash
flutter build ios --release
```

**Web Build:**

```bash
flutter build web
```

### Running Tests

```bash
flutter test
```

### Code Analysis

```bash
flutter analyze
```

---

## 📝 Feature Descriptions

### 1. Home Screen

The home screen is the first screen users encounter after the splash screen. It displays:

- Popular movies in the current trending list
- Movie cards with images and brief information
- Quick access buttons for other features
- Pull-to-refresh functionality for latest data

**Location:** `lib/features/home/page/`

### 2. Explore Screen

Users can discover movies in multiple ways:

- Browse by genre (Action, Comedy, Drama, etc.)
- Use search functionality to find specific movies
- Filter results by various criteria
- View grid or list layouts

**Location:** `lib/features/explore/page/`
**Models:** `lib/features/explore/models/genre_model.dart`

### 3. Movie Detail Screen

Comprehensive view of individual movies:

- High-resolution poster and banner images
- Complete movie synopsis
- Cast and crew information
- Runtime, release date, and ratings
- IMDB score and user votes

**Location:** `lib/features/detail/page/`
**Models:**

- `lib/features/detail/models/movie_detail_model.dart`
- `lib/features/detail/models/credits_model.dart`

### 4. Profile Screen

User account and preferences management:

- User profile information
- Saved/favorited movies
- Watch history
- Settings and preferences

**Location:** `lib/features/profile/page/`

### 5. Tickets Screen

Movie ticket booking system:

- Select movie and showtime
- Choose cinema/venue
- Seat selection interface
- Booking confirmation
- Ticket management

**Location:** `lib/features/tickets/page/`

---

## 🎨 Theming & Styling

### Theme Configuration

The app uses a dark theme by default with the following characteristics:

- Modern dark color scheme for reduced eye strain
- Material Design 3 principles
- Edge-to-edge display support
- Consistent typography and spacing

**Theme File:** `lib/config/theme/app_theme.dart`

### Customization

To modify the theme:

1. Edit `app_theme.dart`
2. Update colors, fonts, and styling
3. Run `flutter run` to see changes

---

## 🔌 API Integration

### TMDB API Service

The app uses Dio for HTTP requests with the following features:

- Singleton pattern for API client
- Automatic retry on timeout
- Query parameter handling
- Response parsing to models

**Service File:** `lib/services/api_services.dart`

### Available API Endpoints

- `GET /movie/popular` - Popular movies
- `GET /movie/{id}` - Movie details
- `GET /movie/{id}/credits` - Cast and crew
- `GET /genre/movie/list` - Available genres

---

## 📊 Build Configuration

### Version Information

- **Version:** 1.0.0+1
- **Target SDK:** Dart 3.11.5+

### Build Variants

- **Debug:** Development with verbose logging
- **Release:** Optimized production build

### Icon Configuration

- Android: Uses Material Design adaptive icons
- iOS: Uses standard app icons
- Background: `#0A0A0A` (dark)
- Logo: `assets/icons/brand_logo.png`

---

## 📦 Deployment

### Android

1. Build APK/AAB:

```bash
flutter build apk --release
```

2. Sign the APK with your keystore

3. Upload to Google Play Console

### iOS

1. Build IPA:

```bash
flutter build ios --release
```

2. Archive and submit to App Store Connect

### Web

1. Build web files:

```bash
flutter build web --release
```

2. Deploy `build/web` directory to your hosting service

---

## 🐛 Troubleshooting

### Common Issues

| Issue                | Solution                                       |
| -------------------- | ---------------------------------------------- |
| API key errors       | Verify API key in `app_config.dart` is correct |
| Build fails          | Run `flutter clean` then `flutter pub get`     |
| iOS build issues     | Run `cd ios && pod install && cd ..`           |
| Android build errors | Update Android SDK and Gradle                  |

---

## 📚 Additional Resources

- [Flutter Documentation](https://flutter.dev/docs)
- [TMDB API Documentation](https://developers.themoviedb.org/3)
- [Dart Language Guide](https://dart.dev/guides)
- [Material Design Guidelines](https://material.io/design)

---

## 📄 License

This project is private and for educational purposes. All rights reserved.

---

## 👤 Contributors

- **Developer:** [Ynhaein]
- **Last Updated:** May 2026

---

## 🤝 Support

For issues, questions, or suggestions, please contact the development team or open an issue in the project repository.

---
