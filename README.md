# 🛒 KKN Store - Flutter E-commerce App

**KKN Store** is a modern e-commerce mobile application built using **Flutter** and powered by **Firebase**. It features a clean UI/UX, user authentication, state management, product browsing, and essential commerce functionality like cart, wishlist, search, and payments.

## 🚀 Features

### 🔐 Authentication
- Firebase Authentication integration
- Sign up, Sign in, Forgot Password
- Google Sign-In

### 🏬 Storefront
- Home screen with featured and popular products
- Dynamic product listings
- Product detail pages with image carousel

### ❤️ Wishlist
- Add/remove items to personal wishlist
- Firebase cloud-based sync

### 🛍️ Cart & Checkout
- Add to cart from product screen
- Update quantity, remove products
- View total cost and summary
- Selectable payment methods (demo only)

### 🌗 Theme Support
- Toggle between Light and Dark modes
- Theme persists using shared preferences/local storage

### 👤 Profile & Settings
- View/update profile
- Access order history and preferences
- Logout functionality

### 🔎 Search
- Smart product search with filtering options

### 🔔 Notifications *(optional/coming soon)*
- Firebase Cloud Messaging for push notifications

---

## 📱 Screens Included

- Splash Screen
- Login / Register / Forgot Password
- Home
- Product Details
- Wishlist
- Cart
- Search
- Profile & Settings

---

## 🧰 Tech Stack

| Tech            | Description                             |
|-----------------|-----------------------------------------|
| 🐦 Flutter       | Cross-platform UI toolkit                |
| 🔥 Firebase      | Auth, Firestore, Storage, Cloud Messaging |
| 🎨 GetX / Provider (choose your state management) | State & route management          |
| 💳 Stripe / Razorpay (optional) | Payment gateway integration        |
| 🌙 SharedPreferences | Theme and login state persistence      |

---

## 📁 Folder Structure

It looks like you're asking for a README file that describes the folder structure of your "KKN_STORE" project, based on the provided screenshots. I will create a Markdown-formatted README for you that outlines this structure.

Here's the README file:

```markdown
# KKN_STORE Project Structure

This document outlines the folder and file structure of the KKN_STORE Flutter project.


KKN_STORE/
├── .dart_tool/
├── .git/
├── .idea/
├── android/
├── assets/
│   ├── fonts/
│   ├── icons/
│   │   └── author_icon/
│   ├── images/
│   │   ├── brands/
│   │   ├── categories/
│   │   ├── onboarding/
│   │   ├── poster/
│   │   ├── products/
│   │   └── user/
│   └── logos/
├── build/
├── ios/
├── lib/
│   ├── bindings/
│   ├── common/
│   │   ├── style/
│   │   │   ├── shadows.dart
│   │   │   └── spacing_style.dart
│   │   └── widgets/
│   │       ├── appbar/
│   │       │   ├── appbar.dart
│   │       │   └── TabBar.dart
│   │       ├── brands/
│   │       │   └── brand_show_case.dart
│   │       ├── choice_chip/
│   │       │   └── choice_chip.dart
│   │       ├── custom_shapes/
│   │       │   ├── container/
│   │       │   │   ├── circular_container.dart
│   │       │   │   └── primary_header_container.dart
│   │       │   └── curved_edges/
│   │       │       ├── curved_edge_widgets.dart
│   │       │       └── curved_edgs.dart
│   │       ├── icon/
│   │       │   └── TCircular_Icon.dart
│   │       ├── image_text/
│   │       │   └── image_text.dart
│   │       ├── images/
│   │       │   └── TCircularImages.dart
│   │       ├── layout/
│   │       │   └── grid_layout.dart
│   │       ├── list_tile/
│   │       │   ├── settings_menu_tile.dart
│   │       │   └── userprofilelisttile.dart
│   │       ├── products_cart/
│   │       │   ├── cart/
│   │       │   │   └── cart_menu_icon.dart
│   │       │   ├── product_card/
│   │       │   │   ├── product_horizontal.dart
│   │       │   │   └── product_vertical.dart
│   │       │   └── success_screen/
│   │       │       └── success_screen.dart
│   │       ├── text/
│   │       │   ├── product_price_text.dart
│   │       │   ├── product_title.dart
│   │       │   ├── reusable_heading.dart
│   │       │   ├── TBrand_title_Text_with_verify_icon.dart
│   │       │   ├── TBrand_title_Text.dart
│   │       │   └── text_sizes.dart
│   │       └── widget_login_singin/
│   │           ├── form_divider.dart
│   │           ├── login_divider.dart
│   │           └── social_button.dart
│   ├── data/
│   │   ├── repository/
│   │   └── services/
│   ├── features/
│   │   ├── authentication/
│   │   │   ├── controller/
│   │   │   │   └── onboarding/
│   │   │   │       └── onboarding_controller.dart
│   │   │   ├── models/
│   │   │   └── screens/
│   │   │       ├── login/
│   │   │       │   └── Widgets/
|   |   |       |   |    |__login_header.dart
│   │   │       │   └── loginscreen.dart
│   │   │       ├── onboarding/
│   │   │       │   └── widgets/
│   │   │       │   |   ├── onboarding_navigation.dart
│   │   │       │   |   ├── onboarding_nextpage_button.dart
│   │   │       │   |   ├── onboarding_skip.dart
│   │   │       │   |   ├── onboarding_pages.dart
│   │   │       │   └── onboarding.dart
│   │   │       ├── password_authetication/
│   │   │       │   ├── forgot_password.dart
│   │   │       │   └── reset_password.dart
│   │   │       └── singup/
│   │   │           └── widgets/
│   │   │           |     ├── singup_form.dart
│   │   │           |     ├── term&condition_checkbox.dart
│   │   │           ├── singupscreen.dart
│   │   │           └── varify_email.dart
│   │   ├── personalization/
│   │   │   ├── controller/
│   │   │   ├── models/
│   │   │   └── screens/
│   │   │       ├── address/
│   │   │       ├── profile/
│   │   │       │   └── Widgets/
│   │   │       │       └── profile_menu.dart
│   │   │       └── settings
|   |   |           |__settings.dart
│   │   └── shop/
│   │       ├── controller/
│   │       │   └── home_controller.dart
│   │       ├── models/
│   │       └── screens/
│   │           ├── Home/
│   │           │   └── widgets/
│   │           │       ├── home_appbar.dart
│   │           │       ├── home_slider.dart
│   │           │       ├── searchbar.dart
│   │           │       ├── THomeCategory.dart
│   │           │       ├── TPosterImageSet.dart
│   │           │       ├── TRoundedContainer.dart
│   │           │       ├── home.dart
│   │           │       └── product_list.dart  
│   │           └── Store/
│   │           |   └── widgets/
│   │           |       ├── category_tab.dart
│   │           |       ├── TCard.dart
│   │           |       └── store.dart
|   |           └── Sub_category/
│   │           |        └── sub_category.dart
|   |           |
│   |           └── wishlist/
│   |           |        └── widgets/
│   |           |                └── wishlist.dart
│   │           └── Product_review/
│   │           |    |   └── widgets/
│   │           |    |     ├── all_over_rating.dart
│   │           |    |     ├── one_indicator_bar.dart
│   │           |    |     └── user_review_card.dart
|   |           |    └── product_review.dart
|   |           └── product_details/
|   |           |    |   └── widgets/
|   |           |    |     ├── bottom_add_to_cart.dart
|   |           |    |     ├── product_Attribute.dart
|   |           |    |     ├── product_description.dart
|   |           |    |     ├── product_image_slider.dart
|   |           |    |     ├── product_meta_data.dart
|   |           |    |     └── Rating_Share_widgets.dart
|   |           |    └──product_details.dart
│   │           └── order/
│   │           |    |   └── widgets/
│   │           |    |     ├── order_list.dart
│   │           |    └── order_status.dart
│   │           └── Checkout/
│   │           |    |   └── widgets/
│   │           |    |     ├── billing_address_section.dart
│   │           |    |     ├── billing_amount_section.dart
│   │           |    |     ├── billing_payment_section.dart
│   │           |    └── checkout.dart
│   │           └── Brands/
│   │           |       ├──all_brands.dart
│   │           |       └──brands_products.dart
│   │           └── all_products/
|   |           |        └──all_products.dart
|   |           └── cart/
│   │           |    |  └── widgets/
|   |           |    |         └── cart_items.dart
|   |           |    └── cart.dart 
|   |   
│   ├── localization/
│   ├── utils/
│   │   ├── constants/
│   │   │   ├── api_constants.dart
│   │   │   ├── colors.dart
│   │   │   ├── enums.dart
│   │   │   ├── image_strings.dart
│   │   │   ├── sizes.dart
│   │   │   ├── text_string.dart
│   │   │   └── texts.dart
│   │   ├── device/
│   │   │   └── device_utility.dart
│   │   ├── formatters/
│   │   │   └── formatters.dart
│   │   ├── helpers/
│   │   │   ├── helper_function.dart
│   │   │   └── pricing_calculator.dart
│   │   ├── http/
│   │   │   └── http_client.dart
│   │   ├── local_storage/
│   │   │   └── storage_utility.dart
│   │   ├── logging/
│   │   │   └── logger.dart
│   │   └── theme/
│   │   │    ├── Custom_themes/
│   │   │    │   ├── appbar_theme.dart
│   │   │    │   ├── bottom_sheet_theme.dart
│   │   │    │   ├── checkbox_theme.dart
│   │   │    │   ├── chip_theme.dart
│   │   │    │   ├── elevated_button_theme.dart
│   │   │    │   ├── outlined_button_theme.dart
│   │   │    │   ├── text_theme.dart
│   │   │    │   ├── textfield_theme.dart
│   │   │    │   └── theme.dart
│   │   │    └── theme.dart
│   │   ├── validators/
│   │   └── validation.dart
│   ├── app.dart
│   ├── main.dart
│   └── navigation_menu.dart
├── linux/
├── macos/
├── test/
│   └── widget_test.dart
├── web/
├── windows/
├── .flutter-plugins
├── .flutter-plugins-dependencies
├── .gitignore
├── .metadata
├── analysis_options.yaml
├── kkn_store.iml
├── pubspec.lock
├── pubspec.yaml
└── README.md

```
## Explanation of Key Directories:

* **`android/`, `ios/`, `linux/`, `macos/`, `web/`, `windows/`**: These are standard Flutter platform-specific directories for building your application on different operating systems.
* **`assets/`**: Contains all static assets like images, fonts, and icons used in the application.
    * `assets/fonts/`: For custom fonts.
    * `assets/icons/`: For various icons, including `author_icon`.
    * `assets/images/`: Organized by category (brands, categories, onboarding, poster, products, user) for different types of images.
    * `assets/logos/`: For application logos.
* **`lib/`**: This is the core of your Flutter application's source code.
    * **`bindings/`**: Likely contains GetX or similar bindings for dependency injection.
    * **`common/`**: Reusable UI components and styles.
        * **`style/`**: Defines common styles.
            * `shadows.dart`: For shadow styles.
            * `spacing_style.dart`: For consistent spacing.
        * **`widgets/`**: Contains various custom widgets. This directory is further organized by the type of widget (e.g., `appbar`, `brands`, `custom_shapes`, `icon`, `image_text`, `images`, `layout`, `list_tile`, `products_cart`, `text`, `widget_login_singin`).
    * **`data/`**: Handles data operations.
        * **`repository/`**: Abstractions for data sources.
        * **`services/`**: Implementations for fetching and manipulating data (e.g., API calls, local database operations).
    * **`features/`**: Contains distinct feature modules of the application.
        * **`authentication/`**: Handles user authentication flows.
            * **`controller/`**: Logic for authentication screens.
            * **`models/`**: Data models related to authentication.
            * **`screens/`**: UI for authentication (login, onboarding, password authentication, signup).
        * **`personalization/`**: User personalization features.
            * **`controller/`**: Logic for personalization screens.
            * **`models/`**: Data models related to personalization.
            * **`screens/`**: UI for personalization (address, profile, settings).
        * **`shop/`**: E-commerce related features.
            * **`controller/`**: Logic for shop screens.
            * **`models/`**: Data models related to shop.
            * **`screens/`**: UI for shop (Home, Store).
    * **`wishlist/`**: Handles wishlist functionality.
    * **`localization/`**: For internationalization and localization.
    * **`utils/`**: Utility classes and helper functions.
        * **`constants/`**: Defines constants used throughout the application (API endpoints, colors, enums, image paths, sizes, text strings).
        * **`device/`**: Device-related utilities.
        * **`formatters/`**: Data formatting utilities.
        * **`helpers/`**: General helper functions.
        * **`http/`**: HTTP client for API interactions.
        * **`local_storage/`**: Local storage utilities.
        * **`logging/`**: Logging utilities.
        * **`theme/`**: Application theming.
            * **`Custom_themes/`**: Custom theme definitions for various widgets.
            * `theme.dart`: Overall application theme.
    * **`validators/`**: Contains validation logic for forms.
    * **`app.dart`**: The root widget of the application.
    * **`main.dart`**: The entry point of the Flutter application.
    * **`navigation_menu.dart`**: Defines the main navigation structure.
* **`test/`**: Contains unit and widget tests for your application.
* **`.gitignore`**: Specifies intentionally untracked files to ignore.
* **`analysis_options.yaml`**: Configures the Dart analyzer for linting rules.
* **`pubspec.yaml`**: Defines project dependencies, metadata, and assets.
* **`pubspec.lock`**: Records the specific versions of dependencies used in the project.
* **`README.md`**: This file, providing an overview of the project.

**Note on `Profile \ Widgets` folder:** The name `Profile \ Widgets` (with a backslash) in the `features/personalization/screens/` directory appears unusual for a standard folder name. It's likely an unintended character or a display anomaly in the screenshot. It's recommended to rename it to `Profile/Widgets` or `profile/widgets` for consistency and best practices in file paths.
```