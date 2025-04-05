# Wendy's Challenge

Wendy's Challenge is a robust Flutter application that demonstrates clean architecture, modular feature development, and effective dependency management. This project is designed to showcase best practices in Flutter development with well-organized features.

## Table of Contents

- [Overview](#overview)
- [Features](#features)
- [CI/CD Integration](#cicd-integration)
- [Tech Stack](#tech-stack)
- [Architecture & Folder Structure](#architecture--folder-structure)
- [Getting Started](#getting-started)
- [Testing](#testing)
- [Contributing](#contributing)
- [License](#license)

## Overview

Wendy's Challenge starts with an engaging splash screen and seamlessly navigates users through a menu-driven interface. The app leverages:
- Declarative navigation with go_router.
- Business logic encapsulated in cubits.
- Dependency injection using a custom injection framework.
- Network calls via Dio, with response caching using an ETag-based interceptor.

## Main Features

- **Splash:** An animated logo with a fade-in effect ([AnimatedLogo](lib/features/splash/presentation/widgets/animated_logo.dart)) that initializes dependencies before routing to the home screen.
- **Home:**
  - **HomeScreen:** The main interface displaying a list of menu categories ([HomeScreen](lib/features/home/presentation/screens/home_screen.dart)).
  - **SubMenuScreen:** Displays the menu items for a selected category ([SubMenuScreen](lib/features/home/presentation/screens/sub_menu_screen.dart)).
  - **ProductScreen:** Shows detailed information about a selected menu item with options to add it to the cart ([ProductScreen](lib/features/home/presentation/screens/product_screen.dart)).
- **Cart:** Allows users to add products to the shopping cart using the CartCubit ([CartCubit](lib/features/cart/presentation/cubit/cart_cubit.dart)), with real-time updates shown on the CartIcon widget.
- **Response Caching:** Implements ETag and response caching using an [ETagInterceptor](lib/core/services/http_service/interceptors/e_tag_interceptor.dart) and [ETagModel](lib/core/services/http_service/models/e_tag_model.dart) to reduce bandwidth and improve performance by caching server responses.
  
## CI/CD Integration

The project integrates with a CI/CD pipeline to ensure code quality and fast feedback. The integration includes:
- Build automation using [GitHub Actions](https://github.com/features/actions).
- Automated testing and linting on every pull request.

## Tech Stack

- **Flutter:** Cross-platform mobile development.
- **Dartz:** Functional programming for error handling.
- **Freezed:** Immutable models and unions.
- **flutter_bloc:** State management using Cubits/Blocs.
- **Dio:** Networking with advanced response caching.
- **go_router:** Declarative navigation.
- **ETag Interceptor:** Manages ETag headers and caches responses to optimize network usage.
- **Loader Overlay & Loading Animation Widget:** Global loading indicators.
- **Google Fonts:** Custom typography.

## Architecture & Folder Structure

All the business logic and UI components are clearly separated:

- **app/**: Application-wide setups like dependency injections ([app_injections.dart](lib/app/app_injections.dart)) and route logging.
- **core/**: Shared utilities, base classes (e.g., [BaseInjection](lib/core/base/base_injection.dart)), services, and widgets ([ExceptionWidget](lib/core/widgets/exception_widget.dart)).
- **features/**: Each feature is modularized:
  - **cart/**: Contains the state management and UI for the shopping cart.
  - **home/**: Comprises data sources, domain entities, cubits, and UI for the menu and home screens.
  - **splash/**: Handles the animated splash screen and its cubit.
  
This structure ensures maintainability and scalability across different parts of the app.

## Getting Started

### Prerequisites

- [Flutter SDK](https://docs.flutter.dev/get-started/install)
- Xcode for iOS development or an Android device/emulator.

### Installation

1. **Clone the repository:**

    ```bash
    git clone https://github.com/CaioVSR/wendys_challenge.git
    
    cd wendys_challenge
    ```

2. **Install dependencies:**

    ```bash
    flutter pub get
    ```

3. **Run build runner:**

    ```bash
    flutter pub run build_runner build --delete-conflicting-outputs
    ```

4. **Run the app:**

    ```bash
    flutter run
    ```

## Testing

Wendy's Challenge includes unit tests and widget tests to ensure code quality. Run all tests with:

```bash
flutter test
```

## License

This project is licensed under the MIT License. See the [LICENSE](LICENSE) file for details.

---

📱 Happy coding!
