# Simple Bloc Todo App

A modern, simple Todo application built with Flutter using Clean Architecture, BloC state management, and Dio.

## Features Checklist

### Core Requirements

- [x] **Use public/free API** (DummyJson)
- [x] **Apply Clean Architecture**
- [x] **Use Dio for API requests**
- [x] **Use BloC for state management**
- [x] **Implement a List Screen to display data**
- [x] **Add Pull to Refresh functionality**
- [x] **Implement Infinite Scroll / Load More**
- [x] **Implement a Search Feature**
- [x] **Properly handle UI states**:
  - [x] Loading
  - [x] Empty
  - [x] Error

### Bonus Features

- [x] **Implement a Detail Screen with Share Content**
- [x] **Use Dependency Injection** (`get_it`)
- [x] **Deeplink handle for open Share Content Link**
- [x] **Unit Testing Implementation** (12 Tests Passed)
- [x] **Dark/Light Mode Support**
- [x] **Pretty Logging** (`talker_dio_logger`)

## Screenshots

| List Screen | Search & States | Detail & Share |
| :---: | :---: | :---: |
| ![List Screen](assets/screenshots/list_screen.png) | ![Search State](assets/screenshots/search_state.png) | ![Detail Screen](assets/screenshots/detail_screen.png) |

## Tech Stack

- **Framework:** Flutter
- **State Management:** Bloc/Cubit
- **Networking:** Dio & TalkerDioLogger
- **DI:** GetIt
- **Routing:** GoRouter
- **Testing:** Mocktail & BlocTest

## Architecture

The project follows **Clean Architecture** principles:

- **Domain Layer:** Entities, Use Cases, and Repository Interfaces.
- **Data Layer:** Models, Repositories Implementation, and Data Sources.
- **Presentation Layer:** Blocs, Pages, and Widgets.

## Themes

The application supports both **Light** and **Dark** modes based on system settings. Theme configuration is modularized in `lib/src/core/themes/`:

- `light_theme.dart`
- `dark_theme.dart`

## Testing

We have a comprehensive unit test suite covering Domain, Data, and Presentation layers.

- **Total Tests:** 12
- **Command to run:**

```bash
flutter test
```

## Getting Started

1. **Clone the repository**
2. **Install dependencies:** `flutter pub get`
3. **Run the app:** `flutter run`

### Testing Deeplinks

You can test the deeplink using terminal:
**Android:**

```bash
adb shell am start -W -a android.intent.action.VIEW -d "simplebloc://todo-detail/1" com.example.simple_bloc_todo_app
```
