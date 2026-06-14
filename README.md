# Currency Hub

## Project Idea
Currency Hub is a modern Flutter mobile application that consumes a real public Currency Exchange API and displays exchange rates in a professional, responsive UI.

## Features
- Real-time exchange rates.
- Full text search for currencies.
- Detailed currency info and conversion.
- Favorites system with local storage (SharedPreferences).
- Dark Mode support.
- Multilingual support (English and Arabic).
- Modern UI using Material Design 3 and animations.

## Packages Used
- `http`: For API requests.
- `provider`: For State Management.
- `easy_localization`: For multilingual support.
- `shared_preferences`: For local storage of settings and favorites.
- `flutter_animate`: For UI animations.
- `cupertino_icons`: Standard icon package.

## Team Member Responsibilities
- **Member 1**: API Integration (`api_service.dart`) & Models (`currency.dart`).
- **Member 2**: Home Screen (`home_screen.dart`, `main_screen.dart`) & Details Screen (`details_screen.dart`).
- **Member 3**: Favorites Feature (`favorites_screen.dart`, `favorites_provider.dart`).
- **Member 4**: Settings (`settings_screen.dart`), Localization (`en.json`, `ar.json`), & Dark Mode (`theme_provider.dart`).

## API Source
Exchange rates provided by [Exchange Rate API](https://open.er-api.com/).
