import 'package:admin_shop/domain/models/product.dart';
import 'package:admin_shop/presentation/Bloc/bloc/auth_bloc.dart';
import 'package:admin_shop/presentation/Bloc/bloc/product_bloc.dart';
import 'package:admin_shop/presentation/Bloc/events/product_events.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProductsPage extends StatefulWidget {
  const ProductsPage({super.key});

  @override
  State<ProductsPage> createState() => _ProductsPageState();
}

class _ProductsPageState extends State<ProductsPage> {
  @override
  void initState() {
    super.initState();
    context.read<ProductListBloc>().add(GetAllProductsEvent());
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProductListBloc, Map>(
      builder: (context, state) {
        List<Product> products = state['data'] ?? [];
        return Scaffold(
          //can add slive app bar containing details about no. of products, units, inventory cost, sales
          appBar: AppBar(
            title: Text("${context.read<UserBloc>().state.name}'s Shop".toUpperCase()),
            centerTitle: true,
          ),
          body: state.isEmpty
              ? const Center(child: CircularProgressIndicator())
              : ListView.builder(
                  itemCount: products.length,
                  itemBuilder: (context, index) {
                    return SizedBox(
                      height: 250,
                      child: Card(
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                        elevation: 20,
                        margin: const EdgeInsets.all(10.0),
                        child: InkWell(
                          onTap: () => Navigator.of(context).pushNamed('/product', arguments: products[index]),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              SizedBox(
                                height: 200,
                                child: Row(
                                  children: [
                                    ProductImage(products: products, index: index),
                                    ProductOverview(products: products, index: index),
                                  ],
                                ),
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: const [
                                  Icon(Icons.info_outline_rounded),
                                  Text('Tap to View Product\'s Performance & Details', style: TextStyle(fontStyle: FontStyle.italic, fontSize: 10)),
                                ],
                              )
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                ),
        );
      },
    );
  }
}

class ProductImage extends StatelessWidget {
  const ProductImage({
    super.key,
    required this.products,
    required this.index,
  });

  final List<Product> products;
  final int index;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        width: 150,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: PhysicalModel(
            elevation: 20,
            color: const Color.fromARGB(255, 0, 30, 44).withOpacity(0.1),
            shadowColor: const Color.fromARGB(255, 217, 213, 213),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(10.0),
              child: Hero(
                tag: '${products[index].id}',
                child: Image.network(
                  products[index].imageUrl,
                  fit: BoxFit.contain,
                ),
              ),
            ),
          ),
        ));
  }
}

class ProductOverview extends StatelessWidget {
  const ProductOverview({super.key, required this.products, required this.index});

  final List<Product> products;
  final int index;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            products[index].title,
            style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          const Spacer(flex: 2),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [Text('Price: \$ ${products[index].price}'), Text('Qty. : ${products[index].quantity}')],
          ),
          const Spacer(flex: 1),
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Chip(avatar: const Icon(Icons.money_outlined), label: Text('Units sold: ${products[index].sales}')),
              Chip(avatar: const Icon(Icons.remove_red_eye_sharp), label: Text('views: ${products[index].views}')),
            ],
          ),
        ],
      ),
    );
  }
}
