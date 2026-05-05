# Architecture: introspection_note_mvp

The project follows a clean architecture pattern adapted for GetX.

## Layers

### 1. Presentation Layer (`lib/screens`, `lib/widget`)
- **Screens**: Each page (List, Create/Modify, Settings) is a Flutter widget managed by a corresponding GetX controller.
- **Widgets**: Reusable UI components.
- **Bindings**: (`lib/binding`) Define the dependencies needed for each screen.

### 2. Logic Layer (`lib/controller`)
- **Controllers**: Contain business logic and state. They interact with repositories to fetch and save data.

### 3. Data Layer (`lib/data`)
- **Models**: (`lib/data/models`) Data structures using `freezed`.
- **Repositories**: (`lib/data/repositories`) Abstract the data source, providing a clean API to the controllers.
- **DB**: (`lib/data/db`) Database helper for SQLite operations.
- **SharedPref**: (`lib/data/sharedpref`) Helper for local settings.

### 4. Utilities (`lib/util`, `lib/constant`)
- **NotificationUtil**: Handles notification logic.
- **Constants**: Global constants like colors, keys, etc.

## Routing
Managed by `GetMaterialApp` in `main.dart` using named routes.
