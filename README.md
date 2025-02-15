# Filmy

Filmy is a Flutter application that provides a seamless movie browsing experience with a focus on performance, state management, and offline support. The app features automatic dark mode, pagination, offline user management, and background syncing using WorkManager.

## ✨ Features

- **🌙 Auto Dark Mode**: The app adapts to the system theme and ensures a flawless dark mode experience across all screens.
- **🧩 State Management**: Proper state management using BLoC to handle data efficiently.
- **📌 Main Pages Implemented**:
  - Fetching users list (paginated)
  - Fetching movies list (paginated)
  - Individual movie details page
- **⚠️ Error and Success Alerts**:
  - Toast messages display errors and successes.
  - Toast colors automatically adapt to the current theme.
- **🔄 WorkManager Integration**:
  - Users list is auto-synced in the background using WorkManager.
  - Users are stored in Hive and updated with an API call when online.
- **📶 Offline Support**:
  - If offline while adding a user, they are temporarily stored in Hive.
  - Once back online, the API is called, and the Hive model is updated with an ID and creation timestamp.
  - The users list page shows a ✅ tick or ❌ cross icon indicating whether a user is synced.
- **🖼️ Cached Images**:
  - All images are cached using the `cached_network_image` package for better performance.
- **📡 Connectivity Alerts**:
  - The app notifies the user when the device is offline.
- **⏳ Loading Indicators**:
  - Added wherever necessary to enhance user experience.
- **📱 App Icon & Name**:
  - Custom app icon added.
  - App name: **Filmy**.

## 🏗 Tech Stack

- **Flutter Version**: 3.24.3
- **📦 State Management**: BLoC
- **🗄️ Local Storage**: Hive
- **🌍 Networking**: APIs for user and movie data
- **🔄 Background Sync**: WorkManager
- **🖼️ Image Caching**: cached_network_image

## 📂 Project Structure

```
lib/
 ├── main.dart         # Entry point
 ├── models/           # All models
 ├── resources/        # API services,
 ├── screens/          # UI components, screens
 ├── bloc/             # State management
 ├── widgets/          # Reusable widgets
 ├── utils/            # Remaining components
```

## 🚀 Installation

1. Clone the repository:
   ```sh
   git clone https://github.com/amal-r952/filmy.git
   ```
2. Navigate to the project directory:
   ```sh
   cd filmy
   ```
3. Install dependencies:
   ```sh
   flutter pub get
   ```
4. Run the app:
   ```sh
   flutter run
   ```

## 📦 Build APK
To build the release APK, run:
```sh
flutter build apk --release
```

## 👨‍💻 Author

**Amal Reji** – Flutter Developer

## 📜 License
This project is open-source and available under the MIT License.

