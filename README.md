# DreamScape

DreamScape is a Flutter-based mobile application that allows users to explore and book travel services including flights, hotels, and taxi rides. The app focuses on seamless navigation, user-friendly booking management, and an overall smooth travel planning experience.

---

## ✨ Features

- 📍 **Multi-page navigation** for flight, hotel, and taxi bookings  
- 🔑 **User authentication** with registration and login  
- 📦 **State management** using [Provider](https://pub.dev/packages/provider)  
- 🧾 **Receipt generation** for bookings  
- 📱 **Responsive UI** with bottom navigation powered by [GNav](https://pub.dev/packages/google_nav_bar)  
- 🗄️ **Data persistence**: Pulls and stores booking data from a **PostgreSQL database**  

---

## 🚀 Tech Stack

- **Frontend:** Flutter & Dart  
- **State Management:** Provider  
- **Navigation:** GNav (Google Nav Bar)  
- **Database:** PostgreSQL (via backend API)  
- **Platforms:** Android & iOS  

---

## 📂 Project Structure

The app is organized into multiple pages, each handling a part of the booking process:

### 🏠 Home Page
- The starting point of the app.  
- Users enter **departure and destination locations**, as well as the **dates** for their stay (from–to).  
- Attempting to book will prompt **user account creation** and then a **login** to continue.  

### ✈️ Flights Page
- After logging in, users select a **flight** for their trip.  
- Includes **ticket options** by category:  
  - Senior  
  - Adult  
  - Child  

### 🏨 Hotels Page
- Provides **optional hotel booking**.  
- Users may choose a hotel or **skip this step** if they don’t need accommodation.  

### 🚕 Taxi Page
- Offers an **optional taxi reservation**.  
- Users can select a taxi service for transportation, or **skip** this step.  

### 🧾 Receipt Page
- Displays a **summary of the entire reservation**.  
- Includes details of:  
  - Selected flight(s) and ticket types  
  - Hotel (if booked)  
  - Taxi (if booked)  
- Generates a final **receipt** for the booking.  

---

## ⚡ Getting Started

### Prerequisites
- Flutter SDK (latest stable recommended)  
- Dart (bundled with Flutter)  
- Android Studio / Xcode for running emulators  
- PostgreSQL database + backend API configured  

