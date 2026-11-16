# Al-Mobdea

Al-Mobdea is an educational mobile application for secondary school students, providing grade-based lessons, study materials, exams, results, and live-session links.

## Features

- Student authentication
- Profile and personal information management
- Account deletion
- Subscription details
- Teacher information and social links
- WhatsApp support
- Free and subscription-based lessons
- Lesson search and filtering
- Educational videos and custom playback controls
- PDF study materials
- Online exams, quizzes, and results
- Live-session links
- Push notifications and announcements
- Network connection monitoring
- Optional and forced application updates
- Screenshot and screen-recording protection

## Tech Stack

Flutter, Dart, Firebase Authentication, Cloud Firestore, Firebase Storage, Cloud Functions, Firebase Cloud Messaging, Bloc/Cubit, GetIt, Flutter Secure Storage, and SharedPreferences.

## Architecture

The project follows Clean Architecture, organizing features into:

- **Data:** Data sources and repository implementations
- **Domain:** Entities, repository contracts, and use cases
- **Presentation:** Screens, widgets, and state management

## Platforms

Android and iOS. Current CI/CD distribution workflows target Android.

## CI/CD

GitHub Actions handles static analysis and Android builds. Fastlane distributes APKs through Firebase App Distribution.

| Workflow | Trigger | Result |
| --- | --- | --- |
| Development CI | Pull request to `development` | Static analysis |
| Development Firebase Distribution | Manual dispatch on `development` | Signed Flutter APK sent to Firebase group `team` |
| Main Firebase Distribution | Merged PR from `development` to `main` in this repository | Signed Flutter APK sent to Firebase group `client` |

Workflow files are located in `.github/workflows/`. Distribution lanes are defined in `android/fastlane/Fastfile`.

Both distribution workflows install dependencies, run static analysis, and build a signed release APK before uploading it to Firebase App Distribution.

Signing credentials and Firebase service account keys are stored in GitHub Actions Secrets.

## Development

Developed by **Eyad Waleed**  
© 2026 Fame X. All rights reserved.
