# 🍔 BreakBite — Canteen Ordering App

BreakBite is a full-stack canteen food ordering application that lets students browse the canteen menu and place orders digitally — eliminating queues and manual order-taking. It features a Flutter-based mobile and web frontend (for both student/faculty and admin) with Express.js as a backend.

> **Note:** The backend is hosted on a free-tier instance. Please allow ~30 seconds for "cold start" activation upon the first request.
> 
> **Live Web App:** [https://breakbite-c33c3.web.app](https://breakbite-c33c3.web.app)

---

## 🚀 Key Features

### 👤 Student Experience
* **Digital Marketplace:** Browse categorized menu items with real-time price updates.
* **Order Orchestration:** Seamless cart management and secure checkout.
* **Live Status Tracking:** Real-time push notifications (via FCM) for status changes (Processing → Preparing → Completed).
* **Anti-Fraud Digital Receipt:** A proprietary security feature featuring:
    * **Screenshot Prevention:** Visual cues to discourage unauthorized duplication.
    * **Dynamic Animation:** Ensures the receipt is live and not a static image.
    * **Self-Destruct Timer:** A 2-minute validity window to prevent re-use.

### 🛠️ Admin Management
* **Order Fulfillment Dashboard:** Centralized view to manage and update incoming order states.
* **Inventory Control:** Interface to add/edit menu items and manage availability.
* **Operational Analytics:** Overview of daily volume to assist in inventory forecasting.

---

## 🏗️ Tech Stack

| Layer | Technology | Role |
| :--- | :--- | :--- |
| **Frontend** | Flutter | Cross-platform UI for Android, iOS, and Web. |
| **Backend** | Express.js / Node.js | RESTful API for order logic and business rules. |
| **Database** | MongoDB | Document-based storage for flexible menu and order schemas. |
| **Security** | Firebase Auth | Secure, token-based user authentication. |
| **Real-time** | Firebase Cloud Messaging | Low-latency status notifications. |
| **CI/CD** | GitHub Actions | Automated build and deployment pipelines. |

---

## 🛠️ Technical Challenges & Solutions

* **The Problem:** Preventing order fraud (students showing the same screenshot twice).
* **The Solution:** Developed a **Time-Locked Receipt** logic. The frontend generates a unique animated hash that expires after 120 seconds, requiring staff to verify the "live" state of the UI before dispensing food.

* **The Problem:** Handling sudden bursts of traffic during short college breaks.
* **The Solution:** Optimized backend performance by moving heavy calculations to the JavaScript layer and utilizing efficient MongoDB indexing to ensure sub-second response times for order fetches.

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

## 🛠️ Setup & Installation

### Prerequisites
* Flutter SDK (v3.x+)
* Node.js & npm
* Firebase Project Credentials

### 1. Environment Configuration
The backend requires few environment variables to function (MongoDB connection strings and Firebase Service Account keys).
* Navigate to the `Backend` directory.
* Create a `.env` file based on the provided `.env.example`.
* Populate the fields with your specific credentials.

### 2. Quick Start
1. **Backend:**
   ```bash
   cd Backend
   npm install
   node index.js
   ```

2. **Frontend**
   ```bash
   cd Frontend
   flutter pub get
   flutter run -d chrome  # For Web Admin
   flutter run            # For Mobile App
   ```

---

## ⚙️ CI/CD

This project uses **GitHub Actions** for continuous integration. The workflow is defined in `.github/workflows/` and runs automatically on pushes to the `main` branch.

---

## 👨‍💻 Author

**Farhan Shaikh**  
[GitHub](https://github.com/Farhan-Shaikh-25)
