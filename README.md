# 🎵 Jingle - Music Social Discovery & Dating App

A Flutter application combining music discovery, lifestyle vibes, and social dating. Connect your Spotify, Apple Music, and streaming services to discover and match with people based on shared musical taste, top tracks, favorite artists, and streaming habits.

---

## ✨ Features

- **🌙 Dark Neon Aesthetics**: Sleek dark mode (`#09080D` / `#15141A`) with electric neon lime accents (`#B5F23D`) and fluid micro-animations.
- **⚡ Smart Compatibility Engine**:
  - Calculates detailed taste compatibility scores across shared artists, genres, and shows.
  - Interactive breakdown modal showing categorical match percentages and tiers (*Super Compatible*, *Very Strong Match*, *Good Vibe*).
- **🔥 Swipe Discovery**:
  - Card swipe stack with gesture feedback (drag left to skip, drag right to like).
  - In-card multi-photo gallery browser with tap zones and segment indicators.
  - Real-time listening ticker showing the song the user is currently playing.
  - Detailed profile view showcasing dating badges, bio, top 5 frequently listened songs, favorite shows, and playlists.
- **📸 6-Photo Gallery Manager**:
  - Tinder-style interactive 3x2 photo grid.
  - Supports image capture via camera and picking from device gallery.
  - Set primary cover photo and reorder/delete photos seamlessly.
- **🎧 Streaming & Media Connections**:
  - Connect external media platforms: Spotify, Apple Music, YouTube, Netflix, Amazon Prime, and Instagram.
  - Automatically surfaces top 5 frequently played songs sorted descending by playback volume.
- **🌟 3-Step Guided Onboarding**:
  - Lifestyle vibes, musical genres, and mood selection.
  - Dating preferences setup (gender identity, looking for, relationship status, and intent).
  - Social & media account linking.

---

## 🛠️ Tech Stack & Architecture

- **Framework**: [Flutter](https://flutter.dev) (SDK `^3.9.2`)
- **State Management & Routing**: [GetX](https://pub.dev/packages/get)
- **Typography**: [Google Fonts](https://pub.dev/packages/google_fonts)
- **Image Caching**: [cached_network_image](https://pub.dev/packages/cached_network_image)
- **Media Capture**: [image_picker](https://pub.dev/packages/image_picker)
- **Architecture**: Clean, Layered & Feature-First:
  - `lib/app/`: Navigation shell, bindings, route definitions.
  - `lib/core/`: Centralized theme tokens, dimensions, responsive utils, reusable UI components.
  - `lib/data/`: Data models, repositories, mock data pipelines, compatibility and photo services.
  - `lib/features/`: Feature modules (`authentication`, `home`, `interests`, `profile`, `splash`, `swipe`).

---

## 🚀 Getting Started

### Prerequisites
- Flutter SDK (3.9.2 or higher)
- Android Studio / VS Code / Xcode (for iOS)
- An Android device/emulator or iOS simulator

### Installation

1. **Clone the repository**:
   ```bash
   git clone https://github.com/shikhargahlaut/jingle.git
   cd jingle
   ```

2. **Install dependencies**:
   ```bash
   flutter pub get
   ```

3. **Run code analysis**:
   ```bash
   flutter analyze
   ```

4. **Run test suite**:
   ```bash
   flutter test
   ```

5. **Run the application**:
   ```bash
   flutter run
   ```

---

## 🧪 Testing

The project includes unit, service, and widget test suites:
```bash
flutter test
```
- Dating Preference models & enum serialization
- Photo management pipeline (max 6 photos, primary cover assignment, reordering)
- Media service & playback frequency sorting
- Dynamic compatibility engine & tier resolution
- Application root widget smoke test

---

## 📱 Permissions Configured

- **Android** (`AndroidManifest.xml`):
  - `INTERNET`, `ACCESS_NETWORK_STATE`
  - `CAMERA`
  - `READ_MEDIA_IMAGES`, `READ_MEDIA_VIDEO` (Android 13+ / API 33+)
  - `READ_EXTERNAL_STORAGE`, `WRITE_EXTERNAL_STORAGE` (API <= 32)
- **iOS** (`Info.plist`):
  - `NSPhotoLibraryUsageDescription`
  - `NSCameraUsageDescription`
  - `NSMicrophoneUsageDescription`
  - `NSPhotoLibraryAddUsageDescription`

---

## 📄 License
This project is licensed under the MIT License - see the LICENSE file for details.
