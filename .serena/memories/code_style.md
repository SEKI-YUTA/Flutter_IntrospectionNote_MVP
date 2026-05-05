# Code Style: introspection_note_mvp

## General Guidelines
- **Dart Lints**: Follow the rules defined in `analysis_options.yaml` (uses `flutter_lints`).
- **Naming**: Use `UpperCamelCase` for classes and `lowerCamelCase` for variables and functions.
- **Privacy**: Use `_` prefix for private members where appropriate.

## Patterns
- **GetX**: Use `GetView` or `GetBuilder`/`Obx` for reactive UI.
- **Models**: Use `freezed` for immutable models and `json_serializable` for JSON conversion.
- **Dependency Injection**: Use GetX Bindings to inject controllers and services.

## Localization
- Hardcoded strings should be avoided. Use the `intl` package or a dedicated localization system if available.

## Database
- SQLite table and column names should be defined in the model classes as static constants.
