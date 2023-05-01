import 'package:admin_shop/domain/models/user.dart';
import 'package:admin_shop/presentation/Bloc/bloc/auth_bloc.dart';
import 'package:admin_shop/presentation/Bloc/events/auth_events.dart';
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
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UserBloc, User>(
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            title: const Text('Admin App'),
            actions: [
              ElevatedButton.icon(
                onPressed: () => {Navigator.of(context).pushNamed('/add-product')},
                icon: const Icon(Icons.add_box_outlined),
                label: const Text('Add a product'),
              )
            ],
          ),
          drawer: Drawer(
            child: ListView(
              children: [
                DrawerHeader(
                    child: Text(
                  state.name.toUpperCase(),
                  style: const TextStyle(
                    fontSize: 30,
                  ),
                )),
                const ListTile(
                  title: Text('Profile', style: TextStyle(fontSize: 20)),
                  leading: Icon(Icons.person),
                ),
                ListTile(
                  title: const Text('My Products', style: TextStyle(fontSize: 20)),
                  leading: const Icon(Icons.sell),
                  onTap: () => Navigator.of(context).popAndPushNamed('/products'),
                ),
                const ListTile(
                  title: Text('Sales Report', style: TextStyle(fontSize: 20)),
                  leading: Icon(Icons.show_chart_sharp),
                ),
                const ListTile(
                  title: Text('Settings', style: TextStyle(fontSize: 20)),
                  leading: Icon(Icons.settings),
                ),
                const SizedBox(height: 100),
                ListTile(
                  title: const Text('Sign out', style: TextStyle(fontSize: 20)),
                  leading: const Icon(Icons.logout),
                  onTap: () {
                    context.read<AuthStatusBloc>().add(SignOutEvent());
                    context.read<AuthStatusBloc>().add(AuthStateEvent());
                    Navigator.of(context).pushReplacementNamed('/sign-in');
                  },
                ),
              ],
            ),
          ),
          body: const Center(
            child: Text('Admin Sales Metrics'),
          ),
        );
      },
    );
  }
}
