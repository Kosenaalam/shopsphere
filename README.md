# ShopSphere

A production-ready Flutter e-commerce application built using Riverpod, Dio, and Hive. The application provides a scalable architecture with product discovery, search, filtering, wishlist management, pagination, and responsive UI.

---

# Features

# Product Listing

* Fetch products from remote API
* Responsive grid layout
* Cached product images
* Infinite scrolling pagination

# Product Details

* Detailed product information
* Product image preview
* Price display
* Rating display
* Wishlist integration

# Search & Filtering

* Real-time product search
* Category-based filtering
* Price range filtering

# Wishlist

* Add products to wishlist
* Remove products from wishlist
* Persistent local storage using Hive
* Dedicated wishlist screen

# User Experience

* Pull-to-refresh
* Shimmer loading effect
* Error handling
* Empty state handling
* Material 3 UI

---

# Tech Stack

# State Management

* Flutter Riverpod

# Networking

* Dio

# Local Storage

* Hive

# Image Handling

* Cached Network Image

# Architecture

* Feature-Based Architecture
* Repository Pattern
* Clean Folder Structure

---

# Project Structure

lib/

├── core

│   ├── network

│   └── utils

│

├── features

│   └── products

│       ├── data

│       │   ├── datasources

│       │   ├── models

│       │   └── repositories

│       │

│       ├── presentation

│       │   ├── providers

│       │   ├── screens

│       │   └── widgets

│       │

│       └── domain

│

└── main.dart

---

# API

Base URL:

https://dummyjson.com

Endpoint:

https://dummyjson.com/products

---

# Pagination Strategy

The application implements infinite scrolling pagination using:

* limit parameter
* skip parameter
* AsyncNotifierProvider
* ScrollController listener

Products are loaded incrementally as the user scrolls to the bottom of the list.

---

# Installation

# Clone Repository

git clone <repository-url>

# Install Dependencies

flutter pub get

# Run Application

flutter run

---

# Packages Used

* flutter_riverpod
* dio
* hive
* hive_flutter
* shimmer

---

# Assignment Requirements Covered

✓ Product Listing

✓ Product Detail Screen

✓ API Integration

✓ Pagination

✓ Search Functionality

✓ Category Filtering

✓ Price Filtering

✓ Wishlist Feature

✓ Pull To Refresh

✓ Loading State

✓ Error State

✓ Empty State

✓ Riverpod State Management

✓ Repository Pattern

✓ Local Persistence Using Hive

---

## Author

Kosen Aalam

Flutter Developer
