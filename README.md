# 🍔 BreakBite — Canteen Ordering App

BreakBite is a full-stack canteen food ordering application that lets students browse the canteen menu and place orders digitally — eliminating queues and manual order-taking. It features a Flutter-based mobile and web frontend (for both student/faculty and admin) with Express.js as a backend.

live web app link: https://breakbite-c33c3.web.app

(You may have to wait 30 seconds for the server to wake up as its deployed on a free tier platform)


---

## 🚀 Features

### 👤 Student 
- Browse the canteen menu with item details and prices
- Add items to cart and place orders
- Track order status in real time and recieve notification once order status is set to complete by the admin
- User authentication (login / sign-up)
- A one time unique digital receipt with screenshot prevention, animation and a 2 minute timer to prevent reuse of the receipt.

### 🛠️ Admin
- View and manage incoming orders
- Update order status (Processing → Preparing → Completed)
- Add menu itme
- Dashboard overview of daily orders

---

## 🏗️ Tech Stack

| Layer | Technology |
|---|---|
| Mobile Frontend | Flutter (Dart) |
| Backend / Database | Express.js / MongoDB|
| Authentication | Firebase Auth |
| Notification System | Firebase Cloud Messaging |
| CI/CD | GitHub Actions |

---

## 📁 Project Structure

```
BreakBite/
├── Frontend/          # Flutter mobile app (Dart)
│   ├── lib/
│   ├── pubspec.yaml
│   └── ...
├── Backend/           # Express.js with MongoDB, Firebase Auth and Cloud Messaging (Javascript)
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

###

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

The admin panel is a static web app. The admin panel can be accessed by entering the admin credentials on the login page. The code for the admin page is availiable in `Frontend/lib/admin_utils` & `Frontend/lib/admin_widgets` directories.

---

## ⚙️ CI/CD

This project uses **GitHub Actions** for continuous integration. The workflow is defined in `.github/workflows/` and runs automatically on pushes to the `main` branch.

---

## 👨‍💻 Author

**Farhan Shaikh**  
[GitHub](https://github.com/Farhan-Shaikh-25)
