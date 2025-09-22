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

  ![Home](https://github.com/user-attachments/assets/c300c201-ee51-4eaf-96bb-5ebc9e7ba757)

- Users enter **departure and destination locations**, as well as the **dates** for their stay (from–to).  

  ![Booking form](https://github.com/user-attachments/assets/0af7c2ed-827e-4d35-b044-39adab66f758)

- Attempting to book will prompt **user account creation** and then a **login** to continue.  

  ![Register](https://github.com/user-attachments/assets/f83afbd1-cfd2-417d-8aa3-8e172ca1c137)  
  ![Login](https://github.com/user-attachments/assets/7b93977f-197e-4e8b-a1d3-909976ea9801)

---

## 🛫 Flights
- Displays **available flights** with details like departure, arrival, and price.  

  ![Flights](https://github.com/user-attachments/assets/2f4a1e28-9bcf-478a-a7b7-cddf38cf49ac)

---

## 🏨 Hotels
- Lists **available hotels** at the selected destination.  

  ![Hotels](https://github.com/user-attachments/assets/6de22f5c-51a3-4022-9aa1-1b39a5c8aeb6)

---

## 🚕 Taxi Booking
- Shows **taxi services** available for booking at the destination.  

  ![Taxi](https://github.com/user-attachments/assets/17de6bb8-6316-4e52-963c-95d63ac87e23)

---

## 🧾 Receipt
- After booking, users receive a **receipt page** showing booking details and confirmation.  

  ![Receipt](https://github.com/user-attachments/assets/0a0efb27-f627-4632-ae27-cf3d755d3f19)

---

## ⚙️ Tech Stack
- **Frontend:** Flutter, Dart  
- **State Management:** Provider  
- **Navigation:** GNav (Bottom Navigation)  
- **Backend:** [DreamScape Backend](https://github.com/antoniastajkovska/DreamScape_backend) (Spring Boot)  
- **Database:** PostgreSQL  

---


   git clone https://github.com/antoniastajkovska/DreamScape.git
   cd DreamScape
