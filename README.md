# Al-Mobdea

Al-Mobdea is an educational mobile application for secondary school students, providing grade-based lessons, study materials, exams, results, and live-session links.

## Features

- Student authentication and profile information
- Personal information editing with password confirmation
- Email updates through Cloud Functions
- Account deletion with password confirmation and a warning dialog
- Logout confirmation
- Subscription status and details
- Support for accounts without subscription dates
- WhatsApp support for account and subscription inquiries
- Teacher information and social links
- Grade-based lessons and educational videos
- Free and subscription-based lessons
- Lesson search and access-type filtering
- YouTube thumbnails and custom fullscreen video controls
- Video playback-speed controls and seeking
- PDF study materials
- Online exams, quizzes, and results
- Live-session links
- Push notifications and announcements
- Network connection monitoring
- Optional and forced application updates
- Screenshot and screen-recording protection

## Account Management

Students can view and update their name, phone number, and email address. Saving changes requires confirmation of the current password.

Students can delete their account from the profile screen after reviewing a warning and confirming their password. Successful deletion clears local preferences and secure storage, signs the student out, and returns them to the login screen.

Downloaded PDF files and notification-topic subscriptions are not cleared by the current local deletion flow.

## Content Access

Lessons can be marked as free or subscription-based.

- Free lessons can be opened without an active subscription.
- Subscription-based lessons require an active subscription.
- Subscription access is checked before entering lesson content.
- Students can search lessons and filter them by access type.

Lessons without an `isFree` field default to free.

## Subscriptions and Support

The subscription screen displays the student's subscription status and available start and end dates. Accounts without subscription dates are supported.

Students can contact support through WhatsApp. Subscription inquiries include a prepared message containing the student's name, phone number, and email address, which the student can review and send.

## Backend

Cloud Functions handle server-side operations, including:

- Student email updates
- Account deletion
- Exam attempts and submissions
- Content notifications

Exam-start and submission transactions check whether the student account is being deleted before writing exam data.

## Tech Stack

Flutter, Dart, Firebase Authentication, Cloud Firestore, Firebase Storage, Cloud Functions, Firebase Cloud Messaging, Bloc/Cubit, GetIt, Flutter Secure Storage, and SharedPreferences.

## Architecture

The project follows Clean Architecture, organizing features into:

- **Data:** Data sources, models, and repository implementations
- **Domain:** Entities, repository contracts, and use cases
- **Presentation:** Screens, widgets, validation, and state management

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
