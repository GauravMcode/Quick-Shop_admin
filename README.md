# Quickly Admin

Admin Application for the Full Stack Online Marketplace Project **Quickly**. This App has been built using **Flutter** and uses **Node.js's Express framework** based REST-API for backend server, which in turn uses **MongoDB** as Database.
  
**Download .apk for this app** : [Quickly admin](https://apkfab.com/quickly-admin/com.example.admin_shop/apk?h=75201492ffc43b4a568cc4fb5012dd8a84fcb6b057c46047c890289ed1d3d6f9)

https://github.com/GauravMcode/Quick-Shop_admin/assets/51371766/449ed980-0aa6-4044-9920-9b0ec188e2b9


  
Also see :
   **User App** : [Quickly](https://github.com/GauravMcode/Quick-Shop_user)<br>
   **Rest-Api**  : [Quickly Api](https://github.com/GauravMcode/Quick-shop_API)  

## Core feautures of Admin App :
- Create Account & recieve Welcome email
- Log-in to account & Reset password using OTP through email
- Display list of admin products 
- Create, View, Update & Delete product
- Metrics consisting of bar graph  and pie chart representing category-wise:
    - Inventory Cost Distribution
    - Revenue & sales along with Seller's milestone
    - Views by unique users to know attention a product & category is getting
- Sign out

## App screens:
The App starts with a splash screen, followed by a Start page, that specifies outlook of the app & link for authentication :

<p align="center">
<img src="https://github.com/GauravMcode/Quick-Shop_admin/assets/51371766/466343ba-5f6c-410e-9273-4bc8f5146b89" width="300" height="600" alt="Quickly-admin-start" >
</p>

### The Authentication Pages : 
SignUp & LogIn:
On Sign-up, an account is created for user & user recieves a Welcome email from **Quickly**, user can log-in with the credentials. 

<pre>
<p align="center">
<img src="https://github.com/GauravMcode/Quick-Shop_admin/assets/51371766/52d12a8a-db39-4813-b2fb-9293b6321a6e" width="250" height="500" alt="Sign up" >               <img src="https://github.com/GauravMcode/Quick-Shop_admin/assets/51371766/5f71e900-96bf-4c14-ad72-8e8728f8bb08" width="250" height="500" alt="log-in" >         
</p>
</pre>

Reset Password : 
User has to enter email and OTP to change password would be sent to their email address.
<pre>
<p align="center">
<img src="https://github.com/GauravMcode/Quick-Shop_user/assets/51371766/e4283dc8-46ed-47ab-951b-abd9e39fd4af" width="250" height="500" alt="reset" >            <img src="https://github.com/GauravMcode/Quick-Shop_user/assets/51371766/e9538e22-1a0d-47f2-84d2-5385159416c0" width="250" height="500" alt="reset-email" >      <img src="https://github.com/GauravMcode/Quick-Shop_user/assets/51371766/c44e5ea2-b107-43e9-85e7-ff4b67c9c4ce" width="250" height="500" alt="reset-otp" >   
</p>
</pre>

### Home-Page :
App bar with Inventory Cost Metrics and general details of admin trade. The body consists of list of products. Other pages : sales, views and  profile.

<pre>
<p align="center">
    <img src="https://github.com/GauravMcode/Quick-Shop_admin/assets/51371766/71482398-779c-4d39-882e-754919f7511e" width="250" height="500" alt="Quickly-admin-homepage" >            <img src="https://github.com/GauravMcode/Quick-Shop_admin/assets/51371766/def2a5d9-a5ab-4785-86a9-d38f858e5e89" width="250" height="500" alt="sales" >      <img src="https://github.com/GauravMcode/Quick-Shop_admin/assets/51371766/477d8080-51d9-47de-b920-7c35d6f4772c" width="250" height="500" alt="views" >             <img src="https://github.com/GauravMcode/Quick-Shop_admin/assets/51371766/73deda93-f327-4866-bdcb-c929b1eb2d63" width="250" height="500" alt="profile" >
</p>
</pre>

### Product :
View Produc , Add a Prodcut, update product, delete product.


<pre>
<p align="center">
    <img src="https://github.com/GauravMcode/Quick-Shop_admin/assets/51371766/e146b47f-3371-4b90-9bc1-c200a2750408" width="250" height="500" alt="Quickly-admin-crud" >           <img src="https://github.com/GauravMcode/Quick-Shop_admin/assets/51371766/210bba52-fab2-4521-9a92-29488f7d4e42" width="250" height="500" alt="product" >         <img src="https://github.com/GauravMcode/Quick-Shop_admin/assets/51371766/c722f8f6-bec7-4128-8f71-d1df2bb288a1" width="250" height="500" alt="add-product" >         <img src="https://github.com/GauravMcode/Quick-Shop_admin/assets/51371766/7fb82647-1677-4dd8-8175-fc6d4feb8645" width="250" height="500" alt="update-product" >             <img src="https://github.com/GauravMcode/Quick-Shop_admin/assets/51371766/591e26e4-8459-429d-ad65-53fba88c94b9" width="250" height="500" alt="delete-product" >
</p>
</pre>

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



