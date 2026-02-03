# 🛒 Product Catalog Application

A Flutter-based product catalog application built as part of a technical assessment. The project demonstrates clean architecture, REST API integration, proper state management using GetX, and real-world UI/UX handling including loading, error, empty states, and theme support.

---

## 📌 Project Overview

This application simulates a basic e-commerce flow where users can log in, browse products fetched from a public API, view product details, add or remove items from a cart, manage quantities, and switch between light and dark themes. The app is designed with scalability, maintainability, and clean separation of concerns in mind.

---

## ✨ Features

### 🔐 Authentication (Mock)
- Email & password login
- Input validation (email format, password length)
- Mock authentication (no backend dependency)
- Authentication state managed using GetX

### 🏠 Home Screen – Product Listing
- Fetches products from **Fake Store API**
- Displays products in a responsive grid layout
- Product cards include image, title, price, and category
- Pull-to-refresh functionality
- Product search by title
- Handles loading, error, empty, and no-internet states gracefully

### 📄 Product Detail Screen
- Fetches product details using product ID
- Displays large product image, full title, description, category, price, and rating
- Add to Cart / Remove from Cart functionality
- Real-time cart state updates

### 🛒 Cart Screen
- Displays all added products
- Increase or decrease product quantity
- Remove items from cart
- Displays total cart value
- Graceful empty cart state handling

### 🌗 Theme Support
- Light and Dark theme toggle
- App-wide theme handling using GetX
- UI adapts automatically across all screens

---

## 🧱 Architecture

```text
lib/
├── controllers/
├── core/
│   ├── constants/
│   ├── theme/
│   └── utils/
├── data/
│   ├── models/
│   ├── repositories/
│   └── services/
├── views/
│   ├── auth/
│   ├── home/
│   ├── product/
│   └── cart/
├── widgets/
└── main.dart
