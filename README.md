# ✈️ DreamScape (Frontend)

DreamScape is a **Flutter-based mobile application** that allows users to explore and book travel services including flights, hotels, and taxi rides.  
The app focuses on **seamless navigation**, **user-friendly booking management**, and a **responsive design**.

---

## 🚀 Features
- 📱 **Multi-page navigation** (Flights, Hotels, Taxis, Receipt)
- 🔐 **User authentication** with registration & login
- 🗂 **State management** using Provider
- 🧾 **Receipt generation** for completed bookings
- 🎨 **Responsive UI** with bottom navigation (GNav)
- 🗄 **Data pulled from PostgreSQL database** via the backend API

---

## 🏠 Home Page
- The starting point of the app.  

  <img width="349" height="788" alt="Home" src="https://github.com/user-attachments/assets/c300c201-ee51-4eaf-96bb-5ebc9e7ba757" />

- Users enter **departure and destination locations**, as well as the **dates** for their stay (from–to).  

  <img width="356" height="784" alt="Booking Form" src="https://github.com/user-attachments/assets/0af7c2ed-827e-4d35-b044-39adab66f758" />

- Attempting to book will prompt **user account creation** and then a **login** to continue.  

  <img width="355" height="785" alt="Register" src="https://github.com/user-attachments/assets/f83afbd1-cfd2-417d-8aa3-8e172ca1c137" />
  <img width="353" height="787" alt="Login" src="https://github.com/user-attachments/assets/7b93977f-197e-4e8b-a1d3-909976ea9801" />

---

## 🛫 Flights Page
- After logging in, users select a **flight** for their trip.  

  <img width="367" height="797" alt="Flights" src="https://github.com/user-attachments/assets/10d528d4-bf2c-4b63-b43c-89d2ebfe7d24" />

- Includes **ticket options** by category:  
  - Senior  
  - Adult  
  - Child  

---

## 🏨 Hotels Page
- Provides **optional hotel booking**.  

  <img width="352" height="788" alt="Hotels" src="https://github.com/user-attachments/assets/ca5e1ccd-64d2-4a7a-9414-0b91fd76388a" />

- Users may choose a hotel or **skip this step** if they don’t need accommodation.  

---

## 🚕 Taxi Page
- Offers an **optional taxi reservation**.  

  <img width="358" height="794" alt="Taxi" src="https://github.com/user-attachments/assets/7b81eb55-ee17-48da-8ae6-837d9095ea2b" />

- Users can select a taxi service for transportation, or **skip** this step.  

---

## 🧾 Receipt Page
- Displays a **summary of the entire reservation**.  
- Includes details of:  
  - Selected flight(s) and ticket types  
  - Hotel (if booked)  
  - Taxi (if booked)  
- Generates a final **receipt** for the booking.  

  <img width="362" height="796" alt="Receipt" src="https://github.com/user-attachments/assets/2df79efb-2f50-42b0-b0da-192fce6a538c" />

---

## ⚙️ Tech Stack
- **Frontend:** Flutter, Dart  
- **State Management:** Provider  
- **Navigation:** GNav (Bottom Navigation)  
- **Backend:** [DreamScape Backend](https://github.com/antoniastajkovska/DreamScape_backend) (Spring Boot)  
- **Database:** PostgreSQL  

---

## ⚡ Getting Started

### Prerequisites
- Flutter SDK (latest stable recommended)  
- Dart (bundled with Flutter)  
- Android Studio / Xcode for running emulators  
- PostgreSQL database + backend API configured  
