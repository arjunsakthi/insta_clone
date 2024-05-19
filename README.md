# insta_clone
Sure, here's the updated README without the contributing section:

---

# InstaClone

An Instagram clone built with Flutter, featuring efficient state management, Firebase Authentication, Firebase Storage, and Firebase NoSQL Database. This project is designed to enhance backend data management and processing skills.

## Table of Contents
- [Features](#features)
- [Screenshots](#screenshots)
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

## Screenshots
<!-- Add screenshots here -->
![Home Page](screenshots/home_page.png)
![User Info Page](screenshots/user_info_page.png)
![User Search Page](screenshots/user_search_page.png)

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
   |- models/          # Data models
   |- screens/         # Application screens
   |- services/        # Firebase and other services
   |- widgets/         # Reusable UI components
   |- main.dart        # Application entry point
|- assets/             # Assets (images, fonts, etc.)
|- test/               # Unit and widget tests
|- pubspec.yaml        # Project dependencies and metadata
```

## License
This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

---

Feel free to customize this README further to better suit your project.
