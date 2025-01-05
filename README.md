# **SHOPPY (SHOPPING APP)**

## **Overview**
This shopping app is a mobile application built using Flutter, designed to provide a seamless and visually appealing shopping experience. The app includes key functionalities such as product listing, product details, user authentication, cart management, checkout, and receipt generation.

---

## **Tech Stack**
- Frontend : The app is built using **Flutter** for a cross-platform mobile experience  
- Backend Implementation: **Firebase** is used for Authentication and firestore activities   

---

## **Usage Instructions**

1. User Authentication
   - New users can sign up using the OTP authentication system.
   - Upon successful sign-up, new users will receive a scratch card.
     
2. Product Browsing
   - Browse through the products displayed on the main screen.
   - Tap on a product to view detailed information.

3. Product details
   - Displays the product details.
   - Tap the "Add to Cart" button to add a product to your cart.
   - Tap the "Buy Now" button to place order.

4. Cart Management
   - View all added products in the cart.
   - Remove products from the cart as needed.
   - The total cost of items in the cart is displayed for user convenience.
   - Proceed to checkout by tapping the "Continue" button.

6. Checkout and Receipt
   - Select the address and proceed.
   - Simulate the payment by selecting the payment option.
   - Users can finalize their purchase by tapping the "Place order" button.
   - Share the generated receipt

---

## **Installation Guide**

1. Clone the repository:
```bash
git clone https://github.com/AbhinandhanaPU/shoppy.git
```

2. Navigate to the project directory:
```bash
cd shoppy
```
3.Install dependencies:
```yaml
dependencies:
  flutter:
    sdk: flutter
  get: ^4.6.6
  fluttertoast: ^8.0.9
  pinput: ^5.0.0
  scratcher: ^2.5.0
  confetti: ^0.7.0
  flutter_staggered_animations: ^1.1.1
  lottie: ^3.1.3
  firebase_core: ^3.4.0
  firebase_auth: ^5.2.0
  cloud_firestore: ^5.4.0
  uuid: ^4.5.1
  path_provider: ^2.1.4
  pdf: ^3.11.1
  printing: ^5.12.0
```
```bash
flutter pub get
```

4. Run the app:
```bash
flutter run
```

---

### Contributors
- **Abhinandhana PU** - Flutter Developer
- If you have any questions or feedback, feel free to reach out to me at abhinandhanapu@gmail.com.

---
