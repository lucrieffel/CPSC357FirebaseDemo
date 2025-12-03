# CPSC357 Firebase Demo

A simple iOS app demonstrating **MVVM architecture** and **Firebase integration** for authentication.

## Project Structure

```
CPSC357FirebaseDemo/
├── App/
│   ├── CPSC357FirebaseDemoApp.swift   # App entry point, Firebase config
│   └── AppEnvironment.swift           # Singleton holding all ViewModels
├── Model/
│   └── User.swift                     # User data model
├── ViewModels/
│   └── AuthViewModel.swift            # Handles auth logic (sign in, register, sign out)
├── Views/
│   ├── LoginView.swift                # Login screen
│   └── RegistrationView.swift         # Registration screen
└── Root/
    └── ContentView.swift              # Main view + ProfileView
```

## MVVM Pattern

| Layer | File | Purpose |
|-------|------|---------|
| **Model** | `User.swift` | Data structure stored in Firestore |
| **ViewModel** | `AuthViewModel.swift` | Business logic, Firebase calls |
| **View** | `LoginView`, `RegistrationView`, `ContentView` | UI layer |

## Key Concepts

### 1. AppEnvironment
All ViewModels are accessed through a shared single instance to prevent the view models from being re-initialized in each view:
```swift
@ObservedObject var authViewModel = AppEnvironment.shared.authViewModel
```

### 2. Firebase Auth
- `Auth.auth().signIn(withEmail:password:)` — Sign in
- `Auth.auth().createUser(withEmail:password:)` — Register
- `Auth.auth().signOut()` — Sign out

### 3. Firestore
User data is stored in a `users` collection:
```swift
db.collection("users").document(uid).setData(userData)
```

## Setup

1. Add your `GoogleService-Info.plist` to the project
2. Ensure Firebase SDK is installed via Swift Package Manager
3. Build and run

## Flow

```
App Launch
    ↓
FirebaseApp.configure()
    ↓
ContentView checks userSession
    ↓
┌─────────────────┬──────────────────┐
│ userSession nil │ userSession set  │
│       ↓         │        ↓         │
│   LoginView     │   ProfileView    │
└─────────────────┴──────────────────┘
```

