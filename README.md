<h1 align="center">Instagram Clone</h1>
<p align="center">

<img src="https://github.com/arjunsakthi/insta_clone/assets/75869725/fb47849d-9ecf-477d-826e-735059348992" width="300" height="300" style="margin-right: 100px;">

<img src="https://github.com/arjunsakthi/insta_clone/assets/75869725/6e63778e-4047-4e89-be11-097d3037b8cd" width="300" height="300" style="margin-right: 20px;">
</p>

<p align="center">
  <em>A Flutter app inspired by Instagram, implementing Firebase and Riverpod for efficient state management. The app is designed for responsiveness across desktop, web, and mobile views, with a solid architecture leveraging Firebase RESTful APIs.</em>
</p>

## Table of Contents
- [Features](#features)
- [Installation](#installation)
- [Usage](#usage)
- [Project Structure](#project-structure)
- [License](#license)

## Features
- **Efficient State Management**: Implemented using providers and stateful widgets.
- **Firebase Authentication**: Secure user authentication with Firebase.
- **Firebase Storage**: Store post images and other related post information.
- **Firebase NoSQL Database**: Store user information and manage data efficiently.
- **Liking Animation**: Smooth liking animation for posts.
- **User Info Page**: Display detailed user information.
- **User Search Page**: Search users with a staggered photo display.
- **Home Page**: View posts and comments.

## Installation

1. **Clone the repository**:
    ```bash
    git clone https://github.com/yourusername/instaclone.git
    cd instaclone
    ```

2. **Install dependencies**:
    ```bash
    flutter pub get
    ```

3. **Set up Firebase**:
    - Create a Firebase project.
    - Add your Android and iOS app to the Firebase project.
    - Download the `google-services.json` (for Android) and `GoogleService-Info.plist` (for iOS) files and place them in the appropriate directories (`android/app` and `ios/Runner` respectively).
    - Enable Firebase Authentication and Firestore in the Firebase console.

4. **Run the app**:
    ```bash
    flutter run
    ```

## Usage
1. **User Authentication**: Sign up or log in using Firebase Authentication.
2. **Post and Like**: Create new posts, view posts, and like posts with animations.
3. **Search Users**: Use the search functionality to find users and view their profiles.
4. **View and Comment**: Browse the home page to view posts and comments.

## Project Structure

```
instaclone/
|- android/            # Android-specific files
|- ios/                # iOS-specific files
|- lib/                # Main application code
   |- model/          # Data models
   |- provider/       # Application screens
   |- resource/       # Firebase and other services
   |- responsive/     # Responsive screens like web or mobile
   |- screens/        # Reusable UI components
   |- utils/          # Reusable UI components
   |- widgets/        # Reusable UI components
   |- main.dart       # Application entry point
|- assets/             # Assets (images, fonts, etc.)
|- test/               # Unit and widget tests
|- pubspec.yaml        # Project dependencies and metadata
```

## License

This project is licensed under the MIT License. See the [LICENSE](LICENSE) file for more information.
