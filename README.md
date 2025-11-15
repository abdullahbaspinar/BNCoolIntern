# BNCoolIntern - iOS Video Streaming Application

## Project Overview

This project is an iOS video streaming application developed for **BNCool** company as an internship assignment. The application demonstrates modern iOS development practices using SwiftUI, Firebase integration, and MVVM architecture.

**Internship Task:** iOS Video Streaming Application Development  
**Developer:** Abdullah Başpınar  
**Date:** 2025  
**Technologies:** SwiftUI, Firebase, MVVM Architecture

## Task Requirements Fulfillment

### Core Requirements Met
- **Database**: All user and video data managed via Firebase
- **5 Screens**: Login, Sign-Up, Video List, Video Player, and Live Streaming
- **Authentication**: Secure user registration and login with Firebase
- **Video Playback**: Random display of 3 videos from Firebase as square thumbnails
- **Live Streaming**: Embedded continuously active YouTube live stream

## Features

### Authentication System
- Email/password user registration and login
- Secure authentication via Firebase
- User session management

### Video Management
- Dynamic video loading from Firebase Firestore
- Random selection of 3 videos from database
- Pull-to-refresh functionality
- Manual refresh button for immediate updates
- Responsive grid layout

### Video Player
- YouTube video support via WebView
- MP4 video playback via AVPlayer
- Thumbnail preview system
- Video sharing capabilities

### Live Streaming
- YouTube live stream integration
- 24/7 continuous streaming

### User Interface
- Modern and clean design
- Dark/Light mode support
- Toast notifications

## Technical Requirements

- **iOS Version**: 16.0+
- **Xcode**: 18.6+
- **Swift**: 5.9+
- **Architecture**: MVVM (Model-View-ViewModel)
- **Backend**: Firebase (Authentication + Firestore)

## Dependencies

- FirebaseAuth (User authentication)
- FirebaseFirestore (Database)
- FirebaseCore (Core Firebase services)
- SwiftUI (User interface framework)
- AVKit (Video playback)
- WebKit (Web content)

## Installation Instructions

### Prerequisites
- macOS operating system
- Xcode 15.0 or later
- iOS 16.0+ Simulator or device

**Note**: The project is fully developed, tested, and includes Firebase configuration. No additional setup required.

### Quick Start
1. Extract the project files from the zip archive
2. Open `BNCoolIntern.xcodeproj` in Xcode
3. Select iOS Simulator (iPhone 15 recommended)
4. Click Build & Run button

## Project Structure

```
BNCoolIntern/
├── BNCoolIntern/
│   ├── Models/                 # Data models
│   │   ├── Video.swift        # Video model
│   │   └── LiveStream.swift   # Live stream model
│   │
│   ├── Services/              # Service layer
│   │   ├── AuthService.swift      # Authentication
│   │   ├── VideoService.swift     # Video service
│   │   └── LiveStreamService.swift # Live stream service
│   │
│   ├── ViewModels/            # ViewModel layer
│   │   ├── LoginViewModel.swift
│   │   ├── SignupViewModel.swift
│   │   ├── VideoListViewModel.swift
│   │   ├── VideoPlayerViewModel.swift
│   │   └── LiveStreamViewModel.swift
│   │
│   ├── Views/                 # UI layer
│   │   ├── LoginView.swift
│   │   ├── SignupView.swift
│   │   ├── VideoListView.swift
│   │   ├── VideoPlayerView.swift
│   │   └── LiveStreamView.swift
│   │
│   ├── Utilities/             # Helper classes
│   │   ├── AppTheme.swift     # Theme and colors
│   │   ├── ToastView.swift    # Notification view
│   │   └── WebView.swift      # Web content view
│   │
│   ├── Assets.xcassets/       # Visual resources
│   ├── BNCoolInternApp.swift  # Main application file
│   ├── ContentView.swift      # Main view
│   └── GoogleService-Info.plist # Firebase configuration
│
├── BNCoolIntern.xcodeproj/    # Xcode project file
└── README.md                  # This file
```

## Execution

### Simulator Testing (Recommended)
1. Open project in Xcode
2. Select iOS Simulator (iPhone 15 recommended)
3. Click Build & Run button
4. Application will open in simulator

### Real Device Testing (developer features must be enabled)
1. Connect iPhone to Mac
2. Select device in Xcode
3. Configure bundle identifier
4. Set up code signing
5. Build & Run

## User Flow

1. **Application Launch**: Firebase connection and authentication check
2. **Login/Registration**: Email and password authentication or new account creation
3. **Video List**: Load 3 random videos from Firebase and display in grid layout
4. **Video Playback**: Click video card to access player
5. **Live Streaming**: Access via navigation bar for YouTube live stream

## Firebase Security Rules

```javascript
rules_version = '2';
service cloud.firestore {
  match /databases/{database}/documents {
    match /videos/{video} {
      allow read: if true;
      allow write: if request.auth != null;
    }
  }
}
```

**Note**: All features have been tested and are fully functional. The project can be run immediately when received as a zip file.

## Performance Characteristics

- Initial Loading: ~2-3 seconds
- Video Loading: ~1-2 seconds
- Refresh Operation: ~1 second
- Memory Usage: ~50-80 MB

## Learning Outcomes

### iOS Development
- SwiftUI framework mastery
- MVVM architectural pattern
- Combine framework usage
- Async/await implementation
- iOS lifecycle management

### Firebase Integration
- Authentication service
- Firestore database
- Real-time data synchronization
- Security rules configuration
- Error handling

### Software Development
- Clean code principles
- Error handling strategies
- User experience design
- Performance optimization

## License

This project is developed for internship purposes. Commercial use requires permission from BNCool company.

## Contact

- **Developer**: Abdullah Başpınar
- **Email**: aabdullahbaspinarr@gmail.com
- **GSM**: +90 551 343 29 10

---

**This project is developed for BNCool company as an internship assignment.**

