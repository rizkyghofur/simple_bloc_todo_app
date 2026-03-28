# Simple Bloc Todo App

A modern, simple Todo application built with Flutter using Clean Architecture, BloC state management, and Dio.

## Screenshots

| List Screen | Search & States | Detail & Share |
| :---: | :---: | :---: |
| ![List Screen](assets/screenshots/list_screen.png) | ![Search State](assets/screenshots/search_state.png) | ![Detail Screen](assets/screenshots/detail_screen.png) |

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
- [x] **Properly handle UI states** (Loading, Empty, Error)

### Bonus Features

- [x] **Implement a Detail Screen with Share Content**
- [x] **Use Dependency Injection** (`get_it`)
- [x] **Deeplink handled for open Share Content Link** (`https://rizkyghofur.my.id`)
- [x] **Unit Testing Implementation** (16 Tests Passed)
- [x] **Dark/Light Mode Support** (Custom Blue Theme)
- [x] **Pretty Logging** (`talker_dio_logger`)

## 🛠 Tech Stack

- **Framework:** [Flutter](https://flutter.dev)
- **State Management:** [Bloc/Cubit](https://pub.dev/packages/flutter_bloc)
- **Networking:** [Dio](https://pub.dev/packages/dio) & [Talker](https://pub.dev/packages/talker_dio_logger)
- **DI:** [GetIt](https://pub.dev/packages/get_it)
- **Routing:** [GoRouter](https://pub.dev/packages/go_router)
- **Testing:** [Mocktail](https://pub.dev/packages/mocktail) & [BlocTest](https://pub.dev/packages/bloc_test)

## Getting Started

1. **Clone the repository**
2. **Install dependencies:** `flutter pub get`
3. **Run the app:** `flutter run`

## Architecture

The project follows **Clean Architecture** principles to ensure maintainability and scalability:

- **Domain Layer:** Contains Entities, Use Cases, and Repository Interfaces (Pure Dart).
- **Data Layer:** Contains Models, Repositories Implementation, and Data Sources.
- **Presentation Layer:** Contains Blocs/Cubits, Pages, and Reusable Widgets.

## Themes

Supports **Light** and **Dark** modes based on system settings. Custom **Material 3 Blue** color scheme is used to provide a premium and consistent look across both modes.

## Deeplinks & App Links

Standard `https` URLs are used for better compatibility with messaging apps.

- **Domain:** `https://rizkyghofur.my.id/`
- **Verification:** Requires `assetlinks.json` (Android) and `apple-app-site-association` (iOS) in the `.well-known/` directory.

### Testing on Android (ADB)

```bash
adb shell am start -W -a android.intent.action.VIEW -d "https://rizkyghofur.my.id/todo-detail/1" com.example.simple_bloc_todo_app
```

## Testing

Comprehensive unit test suite covering all layers.

- **Total Tests:** 16
- **Command:** `flutter test`
