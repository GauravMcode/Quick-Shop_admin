import 'package:admin_shop/domain/models/user.dart';
import 'package:admin_shop/presentation/Bloc/bloc/auth_bloc.dart';
import 'package:admin_shop/presentation/Bloc/bloc/metric_bloc.dart';
import 'package:admin_shop/presentation/Bloc/bloc/product_bloc.dart';
import 'package:admin_shop/presentation/Bloc/events/auth_events.dart';
import 'package:admin_shop/presentation/Bloc/events/metric_events.dart';
import 'package:admin_shop/presentation/Bloc/events/product_events.dart';
import 'package:admin_shop/presentation/pages/metrics/sales.dart';
import 'package:admin_shop/presentation/pages/metrics/views.dart';
import 'package:admin_shop/presentation/pages/product/products.dart';
import 'package:admin_shop/presentation/pages/profile/profile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
    context.read<AuthStatusBloc>().add(AuthStateEvent());
    context.read<ProductListBloc>().add(GetAllProductsEvent());

    context.read<MetricBloc>().add(GetMetricsEvent());
  }

  int _currentIndex = 0;

  List<Widget> pages = [
    const ProductsPage(),
    const SalesReportPage(isPushed: false),
    const MetricsPage(),
    const ProfilePage(),
  ];

  List<String> names = ['Products', 'Sales', 'Views', 'Profile'];
  List<Icon> icons = [
    const Icon(Icons.sell),
    const Icon(Icons.currency_rupee_sharp),
    const Icon(Icons.remove_red_eye_outlined),
    const Icon(Icons.person),
  ];

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UserBloc, User>(
      builder: (context, state) {
        return SafeArea(
          child: Scaffold(
            appBar: AppBar(
              title: Text(names[_currentIndex]),
            ),
            drawer: Drawer(
              child: ListView(
                children: [
                  DrawerHeader(
                      child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(3.0),
                        child: CircleAvatar(
                          maxRadius: 50,
                          foregroundImage: NetworkImage(state.imageUrl!),
                        ),
                      ),
                      Text(
                        state.name,
                        style: TextStyle(
                          fontSize: 25,
                          color: Theme.of(context).primaryColorDark,
                        ),
                      ),
                    ],
                  )),
                  ListTile(
                    title: Text('Profile', style: TextStyle(fontSize: 20, color: Theme.of(context).primaryColorDark)),
                    leading: const Icon(Icons.person),
                    onTap: () => Navigator.of(context).popAndPushNamed('/profile'),
                  ),
                  ListTile(
                    title: Text('My Products', style: TextStyle(fontSize: 20, color: Theme.of(context).primaryColorDark)),
                    leading: const Icon(Icons.sell),
                    onTap: () => Navigator.of(context).popAndPushNamed('/products'),
                  ),
                  ListTile(
                    title: Text('Sales Report', style: TextStyle(fontSize: 20, color: Theme.of(context).primaryColorDark)),
                    leading: const Icon(Icons.show_chart_sharp),
                    onTap: () => Navigator.of(context).popAndPushNamed('/sales'),
                  ),
                  const SizedBox(height: 100),
                  ListTile(
                    title: Text('Sign out', style: TextStyle(fontSize: 20, color: Theme.of(context).primaryColorDark)),
                    leading: const Icon(Icons.logout),
                    onTap: () {
                      context.read<AuthStatusBloc>().add(SignOutEvent());
                      context.read<AuthStatusBloc>().add(AuthStateEvent());
                      Navigator.of(context).pushReplacementNamed('/start');
                    },
                  ),
                ],
              ),
            ),
            body: Center(
              child: pages[_currentIndex],
            ),
            floatingActionButton: FloatingActionButton(
              onPressed: () => {Navigator.of(context).pushNamed('/add-product')},
              child: const Icon(Icons.add_box_outlined),
            ),
            floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
            bottomNavigationBar: BottomAppBar(
              shape: const CircularNotchedRectangle(),
              color: Theme.of(context).primaryColor,
              shadowColor: Colors.black.withOpacity(0),
              notchMargin: 10,
              child: DefaultTextStyle(
                style: TextStyle(fontSize: 15, color: Theme.of(context).primaryColorDark, fontWeight: FontWeight.bold),
                child: SizedBox(
                  height: 70,
                  child: Row(mainAxisAlignment: MainAxisAlignment.start, crossAxisAlignment: CrossAxisAlignment.start, children: [
                    const SizedBox(width: 15),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        IconButton(
                          onPressed: () {
                            setState(() {
                              _currentIndex = 0;
                            });
                          },
                          icon: icons[0],
                          color: _currentIndex != 0 ? Theme.of(context).primaryColorLight : Theme.of(context).primaryColorDark,
                        ),
                        _currentIndex == 0 ? Text(names[0], style: const TextStyle(fontSize: 15)) : const SizedBox.shrink(),
                      ],
                    ),
                    const SizedBox(width: 30),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        IconButton(
                          onPressed: () {
                            setState(() {
                              _currentIndex = 1;
                            });
                          },
                          icon: icons[1],
                          color: _currentIndex != 1 ? Theme.of(context).primaryColorLight : Theme.of(context).primaryColorDark,
                        ),
                        _currentIndex == 1 ? Text(names[1], style: const TextStyle(fontSize: 15)) : const SizedBox.shrink(),
                      ],
                    ),
                    const SizedBox(width: 110),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        IconButton(
                          onPressed: () {
                            setState(() {
                              _currentIndex = 2;
                            });
                          },
                          icon: icons[2],
                          color: _currentIndex != 2 ? Theme.of(context).primaryColorLight : Theme.of(context).primaryColorDark,
                        ),
                        _currentIndex == 2 ? Text(names[2], style: const TextStyle(fontSize: 15)) : const SizedBox.shrink(),
                      ],
                    ),
                    const SizedBox(width: 30),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        IconButton(
                          onPressed: () {
                            setState(() {
                              _currentIndex = 3;
                            });
                          },
                          icon: icons[3],
                          color: _currentIndex != 3 ? Theme.of(context).primaryColorLight : Theme.of(context).primaryColorDark,
                        ),
                        _currentIndex == 3 ? Text(names[3], style: const TextStyle(fontSize: 15)) : const SizedBox.shrink(),
                      ],
                    ),
                  ]),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
