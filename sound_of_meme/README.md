You can add a section in your README for "Handy Commands" that includes these useful commands for building and maintaining your Flutter project. Here's how you can incorporate them into your existing README:

---

# Sound Of Meme

Welcome to **Sound Of Meme** – an application that lets users create, listen to, and interact with meme sounds. Built using Flutter, this app follows Clean Architecture principles, ensuring a scalable and maintainable codebase.

## Features

- **Dynamic Theme Switching**: Automatically adapts to system light and dark themes.
- **Authentication**: Login, sign-up, and Google sign-in (via Firebase).
- **Song Management**: Browse all songs, view user-specific songs, and create new meme sounds.
- **Music Player**: Persistent mini-player across the app, with full-screen player support. Continues playback in the foreground, background, and on the lock screen.
- **Cross-Platform**: Fully supported on both Android and iOS.

## Tech Stack

- **Architecture**: Clean Architecture
- **Framework**: Flutter
- **State Management**: Bloc and Notifiers
- **Service Locator**: get_it
- **Major Dependencies**:
    - [just_audio](https://pub.dev/packages/just_audio) - Audio playback
    - [adaptive_theme](https://pub.dev/packages/adaptive_theme) - Theme management
    - [retrofit](https://pub.dev/packages/retrofit) - API calls
    - [dartz](https://pub.dev/packages/dartz) - Functional programming
    - [dio](https://pub.dev/packages/dio) - HTTP requests
    - [firebase_auth](https://pub.dev/packages/firebase_auth) - Firebase authentication for Google sign-in

## Project Structure

```
lib/
│
├── core/
│   ├── error/
│   │   ├── exceptions.dart
│   │   └── failures.dart
│   ├── usecases/
│   │   └── usecase.dart
│   └── utils/
│       └── constants.dart
│
├── data/
│   ├── datasources/
│   │   ├── remote/
│   │   │   └── song_remote_data_source.dart
│   ├── models/
│   │   └── song_model.dart
│   └── repositories/
│       └── song_repository_impl.dart
│
├── domain/
│   ├── entities/
│   │   └── song.dart
│   ├── repositories/
│   │   └── song_repository.dart
│   └── usecases/
│       ├── fetch_songs.dart
│       └── like_song.dart
│
├── presentation/
│   ├── pages/
│   │   ├── meme_sound_page.dart
│   ├── viewmodels/
│   │   └── meme_sound_viewmodel.dart
│   └── widgets/
│       └── song_list.dart
│
└── main.dart
```

## Getting Started

### Prerequisites

- Flutter SDK: [Installation Guide](https://flutter.dev/docs/get-started/install)
- Android Studio or Xcode for running on Android or iOS devices

### Installation

1. **Clone the Repository**
   ```bash
   git clone <your-repository-url>
   cd sound_of_meme
   ```

2. **Install Dependencies**
   ```bash
   flutter pub get
   ```

3. **Run the App**
    - For Android:
      ```bash
      flutter run
      ```
    - For iOS:
      ```bash
      flutter run
      ```

4. **Build for Release Mode (Required for Google Sign-In)**
   ```bash
   flutter build apk --release
   ```
   Ensure you are using the attached JKS file for the release mode.

## Handy Commands

- **Build Runner**: Generates code for the project, especially useful for things like JSON serialization.
  ```bash
  dart run build_runner build --delete-conflicting-outputs
  ```

- **Flutter Native Splash**: Generates native splash screens for Android and iOS.
  ```bash
  dart run flutter_native_splash:create
  ```

- **Icons Launcher**: Generates app launcher icons for Android and iOS.
  ```bash
  dart run icons_launcher:create
  ```

## APK and Videos

- **[Download Android APK](#)**
- **[Android Overview Video](#)**
- **[iOS Overview Video](#)**
- **[App Walkthrough Video](#)**

## License

This project is licensed under the MIT License. See the [LICENSE](LICENSE) file for more details.

## Contact

For any inquiries, please contact raghavverma.dev@gmail.com.
