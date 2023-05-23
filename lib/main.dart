import 'package:admin_shop/config/routes/route_generator.dart';
import 'package:admin_shop/config/theme/theme.dart';
import 'package:admin_shop/data/local/local_data.dart';
import 'package:admin_shop/domain/models/product.dart';
import 'package:admin_shop/domain/models/user.dart';
import 'package:admin_shop/presentation/Bloc/bloc/auth_bloc.dart';
import 'package:admin_shop/presentation/Bloc/bloc/metric_bloc.dart';
import 'package:admin_shop/presentation/Bloc/bloc/product_bloc.dart';
import 'package:admin_shop/presentation/Bloc/events/auth_events.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  String auth = await JwtProvider.getJwt();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(AdminApp(authState: auth));
}

class AdminApp extends StatelessWidget {
  const AdminApp({super.key, required this.authState});
  final String authState;

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<AuthBloc>(create: (BuildContext context) => AuthBloc()),
        BlocProvider<AuthStatusBloc>(create: (BuildContext context) => AuthStatusBloc(authState != '')),
        BlocProvider<ProductBloc>(create: (BuildContext context) => ProductBloc(const Product('', '', '', 0, 0, '', '').toMap())),
        BlocProvider<ProductListBloc>(create: (BuildContext context) => ProductListBloc()),
        BlocProvider<UserBloc>(create: (BuildContext context) => UserBloc(User('', '', ''))),
        BlocProvider<DeleteProductBloc>(create: (BuildContext context) => DeleteProductBloc()),
        BlocProvider<MetricBloc>(create: (BuildContext context) => MetricBloc()),
      ],
      child: BlocBuilder<AuthStatusBloc, bool>(
        builder: (context, state) {
          if (state) {
            context.read<UserBloc>().add(AlreadyAuthEvent());
          }
          return MaterialApp(
            initialRoute: state && authState.isNotEmpty ? '/' : '/start',
            onGenerateRoute: RouteGenerator.generateRoute,
            debugShowCheckedModeBanner: false,
            theme: themeData(),
          );
        },
      ),
    );
  }
}
