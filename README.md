# Rick and Morty App

Welcome to the **Rick and Morty App**! This Flutter-based mobile application lets you explore characters from the popular TV show *Rick and Morty*. You can browse a list of characters, view their details, and save your favorites to a dedicated favorites screen. The app features a quirky *Rick and Morty* theme with portal-inspired designs, custom fonts, and a toggleable light/dark mode.

---

## Features

- **Character List**: Browse characters from the *Rick and Morty* universe with infinite scroll pagination.
- **Favorites**: Save your favorite characters and view them in a dedicated favorites screen, with sorting by name or status.
- **Thematic Design**: Enjoy a *Rick and Morty*-inspired UI with the "Get Schwifty" font, portal green accents, and cosmic dark themes.
- **Light/Dark Mode**: Toggle between light and dark themes for a personalized experience.
- **State Management**: Uses Flutter BLoC for efficient state handling.
- **Local Storage**: Favorites are saved locally using Hive for persistence.

---

## Screenshots

Here’s a look at the app in action:

### Favorites Screen (Empty State)
When you haven't added any favorites yet, you'll see this playful empty state with Rick and Morty silhouettes.

![Favorites Screen Empty State](https://github.com/user/repo/raw/main/screenshots/favorites_empty.png)

### Favorites Screen (Dark Theme)
The favorites screen in dark mode, showing a list of favorited characters with sorting by name.

![Favorites Screen Dark Theme](https://github.com/user/repo/raw/main/screenshots/favorites_dark.png)

### Favorites Screen (Dark Theme, Sorted by Status)
The same favorites screen in dark mode, but sorted by status.

![Favorites Screen Dark Theme Sorted by Status](https://github.com/user/repo/raw/main/screenshots/favorites_dark_sorted_status.png)

### Favorites Screen (Light Theme)
The favorites screen in light mode, showing characters with their details and favorite toggle.

![Favorites Screen Light Theme](https://github.com/user/repo/raw/main/screenshots/favorites_light.png)

---

## Project Setup

### Prerequisites
- **Flutter SDK**: Version 3.7.0 or higher.
- **Dart SDK**: Included with Flutter.
- A code editor like **VS Code** or **Android Studio**.

### Installation
1. **Clone the Repository**:
   ```bash
   git clone https://github.com/yourusername/rick_and_morty.git
   cd rick_and_morty
   ```

2. **Install Dependencies**:
   Run the following command to install all required packages:
   ```bash
   flutter pub get
   ```

3. **Generate Code**:
   This project uses code generation for JSON serialization and Hive storage. Run the following command to generate necessary files:
   ```bash
   dart run build_runner build --delete-conflicting-outputs
   ```

4. **Run the App**:
   Connect a device or emulator, then run:
   ```bash
   flutter run
   ```

---

## Packages Used

The app leverages several Flutter packages to streamline development and enhance functionality. Here’s a breakdown of the key dependencies listed in the `pubspec.yaml`:

### Core Dependencies
- **flutter**: The core Flutter SDK for building the app.
- **cupertino_icons**: Provides Cupertino-style icons for iOS-like designs.

### Networking
- **dio**: A powerful HTTP client for making API requests to the Rick and Morty API.
- **pretty_dio_logger**: Logs HTTP requests and responses for easier debugging.

### State Management
- **flutter_bloc**: Implements the BLoC pattern for state management, used to handle character data and favorites.
- **equatable**: Simplifies equality comparisons for BLoC states and events.
- **dartz**: Provides functional programming tools like `Either` for handling success/failure in API calls.

### Local Storage
- **hive**: A lightweight, NoSQL database for storing favorite characters locally.
- **hive_flutter**: Flutter-specific extensions for Hive.
- **path_provider**: Finds commonly used locations on the filesystem to store Hive data.

### Dependency Injection
- **get_it**: A simple service locator for dependency injection, used to manage use cases and repositories.

### Serialization
- **json_annotation**: Annotates models for JSON serialization.
- **json_serializable** (dev): Generates serialization code for JSON parsing.
- **build_runner** (dev): Runs code generation for serialization and Hive.

### Storage Code Generation
- **hive_generator** (dev): Generates Hive adapters for storing objects.


## Project Structure

Here’s a high-level overview of the project structure:

- `lib/core/`: Common utilities and constants (e.g., colors).
- `lib/src/domain/`: Business logic, including entities and use cases for fetching characters and managing favorites.
- `lib/src/presentation/`: UI layer, including screens (`CharacterListScreen`, `FavoritesScreen`), widgets (`CharacterCard`), and BLoC for state management.
- `assets/`: Fonts and images used in the app.

---

## How It Works

### Character List Screen
- Fetches characters from the Rick and Morty API using `dio`.
- Displays characters in a scrollable list with infinite pagination.
- Each character is shown in a `CharacterCard` with a favorite toggle button.
- Favorites are saved locally using Hive and managed via `CharacterBloc`.

### Favorites Screen
- Displays a list of favorited characters, with options to sort by name or status.
- Shows a custom empty state with a Rick and Morty silhouette when no favorites are added.
- Uses the "Get Schwifty" font and *Rick and Morty*-themed colors (Portal Green, Morty Yellow, etc.).

### State Management
- `CharacterBloc` handles three main events:
    - `LoadCharacters`: Fetches characters for a given page.
    - `LoadFavorites`: Loads favorite character IDs from Hive.
    - `ToggleFavorite`: Adds or removes a character from favorites.
- The state (`CharacterState`) includes `characters`, `favorites`, and `favoriteEntities` for displaying full character details.

---
