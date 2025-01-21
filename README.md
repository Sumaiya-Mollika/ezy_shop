# ezyShop - Flutter Developer Assignment

## Introduction
**ezyShop** is a Flutter app showcasing API integration, local storage, and promotion handling using **Dio** for API calls, **GetX** for state management, and **GetStorage** for local storage.

## Features
- **Authentication**: Sign in, fetch Bearer Token, and store user details.
- **Product Listing**: Browse and view products with detailed information.
- **Product Search**: Search products with debounce for optimized API calls.
- **Cart Management**: Add products to cart, apply promotions (WEIGHT, GWP), and handle live updates.
- **Offline Support**: Persistent local storage for user and cart data.

## Prerequisites
Before setting up the project on a new machine, ensure the following are installed:

1. **Flutter SDK**: Version 3.27.1 or higher. 
   - [Install Flutter](https://flutter.dev/docs/get-started/install).
2. **Dart SDK**: This will be installed with Flutter.
3. **Android Studio / Xcode**: To run the app on Android or iOS.

## Technical Overview
- **API Calls**: Handled efficiently with **Dio**.
- **State Management**: Reactive updates with **GetX**.
- **Promotion Rules**: Dynamic calculation based on product weight and rules.

## Setup
1. Clone the repository:
   ```bash
   git clone https://github.com/Sumaiya-Mollika/ezy_shop.git
   ```
2. Navigate to the project directory:
   ```bash
   cd ezy_shop
   ```
3. Install dependencies:
   ```bash
   flutter pub get
   ```
4. Run the app:
   ```bash
   flutter run
   ```

## API Details
- **Authentication**: `POST /api/v1/auth/signin`
  ```json
  {
      "identifier": "01711355057",
      "password": "manush@456"
  }
  ```
- **Product Search**: `GET /api/v1/products?title=<query>`
  ```json
  Headers: { Authorization: 'Bearer <token>' }
  ```

## Directory Structure
```plaintext
lib/
├── components/   # Reusable UI components
├── controllers/  # GetX controllers for managing state
├── endpoints/    # API endpoint constants
├── models/       # Data models for API responses
├── network/      # Network configurations and helpers
├── services/     # API logic with Dio
├── utils/        # Utility functions and helpers
├── views/        # UI screens
├── main.dart     # App entry point
```

## Important Note

There is an issue with adding "potato" and "apple" to the cart due to their id being the same. This issue needs to be resolved from the backend API to ensure proper cart functionality.

Here is the response (both entity id are same 16):

```json
{
    "status": 200,
    "message": "Products fetched successfully!",
    "data": {
        "products": [
            {
                "id": 16,
                "uid": "JCMlSRKuVL",
                "title": "Apple",
                "sku": "Apple PCH",
                "weight": 125.5,
                "weightUnit": "gm",
                "minimumOrderQuantity": 12,
                "mrp": 240.25,
                "stock": 120,
                "prouductImages": [
                    {
                        "id": 1,
                        "image": "https://cdn.pixabay.com/photo/2016/11/18/13/47/apple-1834639_1280.jpg"
                    },
                    {
                        "id": 2,
                        "image": "https://cdn.pixabay.com/photo/2016/09/29/08/33/apple-1702316_1280.jpg"
                    }
                ],
                "promotion": null
            },
            {
                "id": 16,
                "uid": "JCMlSRKuVL",
                "title": "Potatos",
                "sku": "Potatos PCH",
                "weight": 150.5,
                "weightUnit": "gm",
                "minimumOrderQuantity": 12,
                "mrp": 240.75,
                "stock": 350,
                "prouductImages": [
                    {
                        "id": 1,
                        "image": "https://cdn.pixabay.com/photo/2016/08/11/08/43/potatoes-1585060_640.jpg"
                    },
                    {
                        "id": 2,
                        "image": "https://cdn.pixabay.com/photo/2014/08/06/20/32/potatoes-411975_640.jpg"
                    }
                ],
                "promotion": null
            }
        ],
        "total": 7
    }
}
```

