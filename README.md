# Maintix — Facilities Maintenance Ticketing System

A Flutter and Firebase application prototype for creating, assigning, tracking, and updating facilities-maintenance tickets.

> **Project type:** Modern technical prototype  
> **Status:** In development; architecture and core ticket data flows are present, but the repository is not yet production-ready

## العربية

Maintix نموذج لنظام إدارة بلاغات وصيانة المرافق. يهدف إلى تمكين المستخدم من إنشاء البلاغات وإرفاق الصور، ومتابعة الحالة، وإسناد التذاكر إلى المسؤولين باستخدام Firebase.

## Implemented Scope

- Firebase authentication structure
- Real-time Firestore ticket streams
- Ticket filtering by status, assignee, and creator
- Image upload to Firebase Storage
- Ticket creation and status updates
- BLoC / Cubit state-management foundation
- Repository and data-source separation
- GetIt dependency-injection structure

## Tech Stack

- Flutter and Dart
- Firebase Authentication
- Cloud Firestore
- Firebase Storage
- Firebase Messaging
- Cloud Functions foundation
- Flutter BLoC
- Freezed
- GetIt
- Dartz

## Architecture

```text
lib/
├── core/
│   ├── di/
│   └── theme/
├── features/
│   ├── auth/
│   │   ├── data/
│   │   ├── domain/
│   │   └── presentation/
│   └── tickets/
│       ├── data/
│       ├── domain/
│       └── presentation/
├── app.dart
└── main.dart
```

## Development Status

This repository is preserved as an active development prototype, not as a completed production system. Remaining work includes final dependency registration, completing role and permission flows, hardening Firebase rules, testing notifications and functions, adding automated tests, and validating the full application on Android and iOS.

## Running Locally

1. Configure your own Firebase project.
2. Generate the required Firebase platform configuration.
3. Install dependencies and run the app:

```bash
flutter pub get
flutter run
```

## Author

**Mohammed Alsharjabi**  
Flutter Developer and Founder of TechnoVizen
