import 'package:admin_shop/Presentation/Pages/authentication/sign_in.dart';
import 'package:admin_shop/Presentation/Pages/authentication/sign_up.dart';
import 'package:admin_shop/config/routes/route_error_page.dart';
import 'package:admin_shop/domain/models/product.dart';
import 'package:admin_shop/presentation/pages/authentication/reset_psswd.dart';
import 'package:admin_shop/presentation/pages/authentication/start.dart';
import 'package:admin_shop/presentation/pages/home_page.dart';
import 'package:admin_shop/presentation/pages/metrics/sales.dart';
import 'package:admin_shop/presentation/pages/product/add_product.dart';
import 'package:admin_shop/presentation/pages/product/product.dart';
import 'package:admin_shop/presentation/pages/product/products.dart';
import 'package:admin_shop/presentation/pages/profile/profile.dart';
import 'package:flutter/material.dart';

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    final args = settings.arguments;

    switch (settings.name) {
      case '/start':
        return MaterialPageRoute(builder: (_) => const StartPage());
      case '/sign-in':
        return MaterialPageRoute(builder: (_) => const SignInPage());
      case '/sign-up':
        return MaterialPageRoute(builder: (_) => const SignUpPage());
      case '/reset':
        return MaterialPageRoute(builder: (_) => const ResetPage());
      case '/':
        return MaterialPageRoute(builder: (_) => const HomePage());
      case '/sales':
        return MaterialPageRoute(builder: (_) => const SalesReportPage(isPushed: true));
      case '/profile':
        return MaterialPageRoute(builder: (_) => const ProfilePage());
      case '/add-product':
        if (args is Product) {
          return MaterialPageRoute(builder: (_) => AddProductPage(recievedProduct: args));
        }
        return MaterialPageRoute(builder: (_) => const AddProductPage());
      case '/products':
        return MaterialPageRoute(builder: (_) => const ProductsPage());
      case '/product':
        if (args is Product) {
          return MaterialPageRoute(builder: (_) => ProductPage(product: args));
        }
        return MaterialPageRoute(builder: (_) => const RouteErrorPage());
      default:
        return MaterialPageRoute(builder: (_) => const RouteErrorPage());
    }
  }
}
