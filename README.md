# Base Mobile - Flutter App

A beautiful Flutter mobile application with modern UI design and comprehensive API integration.

## Features

- 🎨 **Modern UI Design**: Material 3 design system with beautiful animations
- 🔐 **Authentication**: Complete login/register system with secure token management
- 📱 **Responsive Design**: Optimized for all screen sizes
- 🌐 **API Integration**: Robust HTTP client with Dio and Retrofit
- 📊 **State Management**: Riverpod for efficient state management
- 💾 **Local Storage**: SharedPreferences and Hive for data persistence
- 🎭 **Animations**: Smooth animations with flutter_animate
- 🖼️ **Image Handling**: Cached network images with shimmer loading
- 🧭 **Navigation**: GoRouter for type-safe navigation
- 📝 **Form Validation**: Comprehensive form validation
- 🔄 **Pull to Refresh**: Built-in refresh functionality
- 🌙 **Dark Mode**: Automatic dark/light theme support

## Architecture

The project follows **Clean Architecture** principles with clear separation of concerns:

```
lib/
├── core/                    # Core functionality
│   ├── config/             # App configuration
│   ├── di/                 # Dependency injection
│   ├── network/            # HTTP client and interceptors
│   ├── storage/            # Local storage services
│   └── utils/              # Utility functions
├── features/               # Feature modules
│   ├── auth/              # Authentication feature
│   ├── home/              # Home/Posts feature
│   ├── profile/           # User profile feature
│   └── splash/            # Splash screen
└── main.dart              # App entry point
```

## Tech Stack

- **Flutter**: 3.10.0+
- **Dart**: 3.0.0+
- **State Management**: Riverpod
- **HTTP Client**: Dio + Retrofit
- **Navigation**: GoRouter
- **Local Storage**: SharedPreferences + Hive
- **UI**: Material 3 + Custom components
- **Animations**: flutter_animate
- **Images**: cached_network_image
- **Forms**: flutter_form_builder
- **Validation**: form_builder_validators

## Getting Started

### Prerequisites

- Flutter SDK 3.10.0 or higher
- Dart SDK 3.0.0 or higher
- Android Studio / VS Code
- Git

### Installation

1. **Clone the repository**
   ```bash
   git clone <repository-url>
   cd base-mobile
   ```

2. **Install dependencies**
   ```bash
   flutter pub get
   ```

3. **Generate code**
   ```bash
   flutter packages pub run build_runner build
   ```

4. **Run the app**
   ```bash
   flutter run
   ```

## Project Structure

### Core Modules

- **AppConfig**: Centralized configuration constants
- **ThemeConfig**: Material 3 theme configuration
- **RouterConfig**: Navigation setup with GoRouter
- **ApiClient**: HTTP client with Retrofit annotations
- **LocalStorageService**: Local data persistence
- **Logger**: Application logging utility

### Features

#### Authentication
- Login/Register forms with validation
- Token-based authentication
- Secure storage of user credentials
- Auto-logout on token expiration

#### Home Feed
- Posts list with pagination
- Pull-to-refresh functionality
- Create/Edit/Delete posts
- Like and comment interactions
- Beautiful post cards with images

#### Profile
- User profile display
- Profile editing capabilities
- Settings and preferences
- Logout functionality

## API Integration

The app uses a robust API client setup:

- **Base URL**: Configurable in `AppConfig`
- **Authentication**: Bearer token in headers
- **Interceptors**: Logging and auth interceptors
- **Error Handling**: Comprehensive error management
- **Mock Data**: Included for development/testing

## State Management

Uses Riverpod for efficient state management:

- **AsyncNotifier**: For async operations
- **Provider**: For dependency injection
- **AutoDispose**: Automatic cleanup
- **Code Generation**: Type-safe providers

## UI/UX Features

- **Material 3**: Latest Material Design
- **Responsive**: Works on all screen sizes
- **Animations**: Smooth transitions and micro-interactions
- **Loading States**: Shimmer loading effects
- **Error Handling**: User-friendly error messages
- **Dark Mode**: Automatic theme switching

## Development

### Code Generation

Run code generation after making changes to:
- Models with `@JsonSerializable`
- Repositories with `@riverpod`
- API clients with `@RestApi`

```bash
flutter packages pub run build_runner build --delete-conflicting-outputs
```

### Testing

```bash
# Run unit tests
flutter test

# Run integration tests
flutter test integration_test/
```

### Building

```bash
# Build APK
flutter build apk

# Build iOS
flutter build ios

# Build web
flutter build web
```

## Configuration

### API Configuration

Update `lib/core/config/app_config.dart`:

```dart
static const String baseUrl = 'https://your-api.com';
static const String apiVersion = 'v1';
```

### Theme Customization

Modify `lib/core/config/theme_config.dart` to customize:
- Colors
- Typography
- Component themes
- Dark mode variants

## Contributing

1. Fork the repository
2. Create a feature branch
3. Make your changes
4. Add tests if applicable
5. Submit a pull request

## License

This project is licensed under the MIT License - see the LICENSE file for details.

## Support

For support and questions:
- Create an issue in the repository
- Check the documentation
- Review the code examples

---

**Happy Coding! 🚀**
