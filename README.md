# 🍔 BreakBite — Canteen Ordering App

BreakBite is a full-stack canteen food ordering application that lets students browse the canteen menu and place orders digitally — eliminating queues and manual order-taking. It features a Flutter-based mobile frontend and a web-based backend admin panel, all powered by Firebase.

---

## 🚀 Features

### 👤 Student (Mobile App)
- Browse the canteen menu with item details and prices
- Add items to cart and place orders
- Track order status in real time
- User authentication (login / sign-up)

### 🛠️ Admin (Web Panel)
- View and manage incoming orders
- Update order status (pending → preparing → ready)
- Manage menu items (add, edit, remove)
- Dashboard overview of daily orders

---

## 🏗️ Tech Stack

| Layer | Technology |
|---|---|
| Mobile Frontend | Flutter (Dart) |
| Web Admin Panel | HTML, CSS, JavaScript |
| Backend / Database | Firebase Firestore |
| Authentication | Firebase Auth |
| Realtime Updates | Firebase Realtime Database |
| CI/CD | GitHub Actions |

---

## 📁 Project Structure

```
BreakBite/
├── Frontend/          # Flutter mobile app (Dart)
│   ├── lib/
│   ├── pubspec.yaml
│   └── ...
├── Backend/           # Web admin panel (HTML/JS)
│   └── ...
└── .github/
    └── workflows/     # CI/CD pipeline
```

---

## 🛠️ Getting Started

### Prerequisites
- [Flutter SDK](https://flutter.dev/docs/get-started/install) (v3.x or above)
- A Firebase project with Firestore and Authentication enabled
- A modern web browser (for the admin panel)

---

### 🔥 Firebase Setup

1. Go to the [Firebase Console](https://console.firebase.google.com/) and create a new project.
2. Enable **Firestore Database** and **Firebase Authentication** (Email/Password).
3. Register an **Android/iOS app** and download the `google-services.json` (Android) or `GoogleService-Info.plist` (iOS).
4. Place the config file in `Frontend/android/app/` or the appropriate iOS directory.
5. For the web admin panel, copy your Firebase config object into the Backend's JavaScript config file.

---

### 📱 Running the Flutter App

```bash
# Navigate to the Flutter project
cd Frontend

# Install dependencies
flutter pub get

# Run the app
flutter run
```

---

### 🌐 Running the Admin Panel

The admin panel is a static web app. Simply open `Backend/index.html` in your browser, or deploy it to any static hosting service (e.g., Firebase Hosting, GitHub Pages, Vercel).

```bash
# If using Firebase Hosting
firebase deploy --only hosting
```

---

## ⚙️ CI/CD

This project uses **GitHub Actions** for continuous integration. The workflow is defined in `.github/workflows/` and runs automatically on pushes to the `main` branch.

---

## 📸 Screenshots

> *(Add screenshots of the mobile app and admin panel here)*

---

## 🤝 Contributing

Contributions are welcome! To contribute:

1. Fork the repository
2. Create a new branch (`git checkout -b feature/your-feature`)
3. Commit your changes (`git commit -m 'Add your feature'`)
4. Push to the branch (`git push origin feature/your-feature`)
5. Open a Pull Request

---

## 📄 License

This project is open source and available under the [MIT License](LICENSE).

---

## 👨‍💻 Author

**Farhan Shaikh**  
[GitHub](https://github.com/Farhan-Shaikh-25)
