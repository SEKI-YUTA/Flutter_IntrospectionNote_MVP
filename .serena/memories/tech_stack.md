# Tech Stack: introspection_note_mvp

## Frontend / Mobile
- **Flutter (Dart)**: Primary framework for cross-platform development.
- **GetX**: Used for state management, dependency injection, and routing.
- **Table Calendar**: For calendar-based UI interactions.

## Data & Storage
- **SQFlite**: Local SQL database for persisting introspection notes.
- **Shared Preferences**: For storing simple settings and flags (e.g., notification preferences).
- **Freezed & Json Serializable**: For type-safe data models and JSON mapping.

## Infrastructure & Services
- **Firebase AI**: Integrated for potential AI-assisted introspection features.
- **Flutter Local Notifications**: For scheduling and handling push notifications.
- **Timezone**: For handling date and time logic across different regions.

## Utilities
- **Intl**: For internationalization and localization support (en_US, ja_JP).
- **Uuid**: For generating unique identifiers for notes.
