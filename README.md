# Admin Shop

Admin Application for the Full Stack Online Marketplace Project. This App has been built using **Flutter** and uses **Node.js's Express framework** based REST-API for backend server, which in turn uses **MongoDB** as Database.

## Core feautures of User App :
- Create Account & recieve Welcome email
- Log-in to account & Reset password using OTP through email
- Display list of admin products 
- Create, View, Update & Delete product
- Metrics consisting of bar graph  and pie chart representing category-wise:
    - Inventory Cost Distribution
    - Revenue & sales along with Seller's milestone
    - Views by unique users
- Sign out

## Folder Structre:
This Project follows Clean Architecture using BLoC Pattern, where code is seperated into :

```
|- Data Layer
|- Domain Layer
|- Presentation Layer
```
The complete Folder Structe is as follows :

The **lib** folder consists :
```
lib
|- data
|- domain
|- presentation
|- config
|- main.dart
```
The **data** sub-folder handles all calls for data, local or remote

```
data
  |- local
     |- local_data.dart
  |- remote
     |- remote_data.dart
```
The **domain** sub-folder has models and repositories :
```
domain
  |- models
    |- product.dart
    |- user.dart
  |- repositories
    |- auth_repository.dart
    |- metric_repository.dart
    |- product_repository.dart
```
The **presentation** sub-folder consists all UI part and bloc; widgets contain refactored and re-usable widgets.

UI part:

```
presentaion
   |- pages
     |- authentication
        |- start.dart
        |- sign_up.dart
        |- sign_in.dart
        |- reset_password.dart
     |- metrics
         |- sales.dart
         |- views.dart
     |- product
         |- add_product.dart
         |- products.dart
         |- product.dart
     |- profile
         |- prodile.dart
     |- home_page.dart
   |- widgets
      |- metrics
         |- metrics_helper.dart
      |- order_steps
         |- address_step.dart
         |- order_placed.dart
         |- review_details.dart
      |- products
         |- product_helper.dart
         |- products_helper.dart
      |- input_field.dart
```
**BLoc** :
```
presentaion
 |- Bloc
   |- bloc
     |- auth_bloc.dart
     |- metric_bloc.dart
     |- product_bloc.dart
   |- events
     |- auth_events.dart
     |- metric_events.dart
     |- product_events.dart
```

