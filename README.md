# flutter-firebase-projects
Flutter Firebase Projects

A curated collection of Flutter applications showcasing Firebase integration and mobile development best practices.

---

## 📱 Included Projects

### 1. ✅ To-Do Application
- **Features**: Add tasks.
- **Firebase Integration**: 
  - Firestore for real-time task syncing across devices
  - Firebase Authentication for secure login/signup
- **Highlights**:
  - Offline support with automatic sync when online
  - Real-time updates using Firestore streams
  - User-specific task lists with data isolation
  - Task search and filtering capabilities

### 2. 🌍 Trip Destination App
- **Features**: Add trips with city/country details, view trip locations on interactive maps, plan famous spots to visit
- **Firebase Integration**:
  - Firestore for storing trips and user data
  - Firebase Auth for user authentication
  - Firebase Storage.

- **Highlights**:
  - Interactive map integration using `flutter_map`
  - Manual addition and management of famous attractions
  - Clean, intuitive UI with Material Design 3
  - Offline trip planning with sync capabilities

---

## 🛠️ Getting Started

### 🔧 Prerequisites
- Flutter SDK (latest stable version)
- Firebase account & project setup
- IDE: Android Studio or VS Code with Flutter plugins
- Xcode (for iOS development - macOS only)

### 📥 Installation Steps

1. **Clone the repository**
   ```bash
   git clone https://github.com/ImaanZahra/flutter-firebase-projects.git
   cd flutter-firebase-projects
   ```

2. **Navigate to the desired app**
   ```bash
   cd todoapplication   # or tripdestinationapp
   ```

3. **Install dependencies**
   ```bash
   flutter pub get
   ```

4. **Set up Firebase**
   - Add `google-services.json` in `android/app/`
   - Add `GoogleService-Info.plist` in `ios/Runner/`
   - Configure Firebase settings in the app if needed

5. **Run the app**
   ```bash
   flutter run
   ```

---

## 🧰 Tech Stack

- **Flutter** — Cross-platform mobile app development framework
- **Firebase Services:**
  - Authentication (Email, Google Sign-in)
  - Firestore (Cloud NoSQL database)
  - Firebase Storage 

- **Key Packages Used:**
  - `provider` — State management
  - `flutter_map` — Interactive mapping
  - `shared_preferences` — Local data storage


---

## 🗂️ Project Structure

```
flutter-firebase-projects/
├── todoapplication/
│   ├── lib/
│   │   ├── models/
│   │   ├── services/
│   │   ├── providers/
│   │   ├── screens/
│   │   └── widgets/
│   ├── android/
│   ├── ios/
│   └── pubspec.yaml
├── tripdestinationapp/
│   ├── lib/
│   │   ├── models/
│   │   ├── services/
│   │   ├── providers/
│   │   ├── screens/
│   │   └── widgets/
│   ├── android/
│   ├── ios/
│   └── pubspec.yaml
└── README.md
```

---

## 🎯 Learning Objectives

- Firebase setup and integration in Flutter applications
- User authentication implementation with multiple providers
- Real-time data synchronization using Firestore
- State management best practices using Provider
- Offline-first app architecture with automatic sync
- Interactive map implementation and location services
- Modern UI design with Material Design 3
- Clean code architecture and project organization

---

## 🤝 Contributing

1. Fork this repository
2. Create your feature branch: `git checkout -b feature/your-feature`
3. Commit your changes: `git commit -m "Add your feature"`
4. Push to the branch: `git push origin feature/your-feature`
5. Open a Pull Request

---

## 📬 Contact

**Imaan Zahra**
- 📧 Email: imaanzahra529@gmail.com
- 🔗 GitHub: [Your GitHub Profile](https://github.com/ImaanZahra)
- 💼 LinkedIn: [Your LinkedIn Profile](https://linkedin.com/in/imaan-zahra-)

---

## 🙌 Acknowledgments

- **Flutter Team** — For the amazing cross-platform framework
- **Firebase Team** — For comprehensive backend services
- **flutter_map Contributors** — For excellent mapping capabilities
- **Open Source Community** — For continuous inspiration and support