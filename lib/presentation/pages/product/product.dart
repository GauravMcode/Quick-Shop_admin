import 'package:admin_shop/domain/models/product.dart';
import 'package:admin_shop/presentation/Bloc/bloc/product_bloc.dart';
import 'package:admin_shop/presentation/Bloc/events/product_events.dart';
import 'package:admin_shop/presentation/widgets/products/product_helper.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';

class ProductPage extends StatefulWidget {
  final Product product;
  const ProductPage({super.key, required this.product});

  @override
  State<ProductPage> createState() => _ProductPageState(product: product);
}

class _ProductPageState extends State<ProductPage> {
  Product product;
  List<Color> gradColors = [const Color(0xff2f3542), const Color(0xffffa502)];

  _ProductPageState({required this.product});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProductBloc, Map>(
      builder: (context, state) {
        product = context.read<ProductBloc>().state['data'] != null && context.read<ProductBloc>().state['data']?.id == product.id ? context.read<ProductBloc>().state['data'] : product;
        return WillPopScope(
          onWillPop: () async {
            context.read<ProductListBloc>().add(GetAllProductsEvent());
            return true;
          },
          child: Scaffold(
            body: DecoratedBox(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: gradColors,
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight,
                  stops: const [0.5, 0.99],
                ),
              ),
              child: CustomScrollView(
                slivers: <Widget>[
                  SliverAppBar(
                    backgroundColor: Theme.of(context).primaryColorDark,
                    expandedHeight: 300,
                    floating: true,
                    flexibleSpace: Hero(
                      tag: '${product.id}',
                      child: CachedNetworkImage(
                          key: UniqueKey(),
                          imageUrl: product.imageUrl,
                          fit: BoxFit.contain,
                          progressIndicatorBuilder: (context, url, progress) => Center(
                                child: Lottie.asset('assets/143310-loader.json', width: 150, height: 100),
                              )),
                    ),
                  ),
                  SliverToBoxAdapter(
                    child: Column(
                      children: [
                        Text(product.title,
                            style: const TextStyle(
                              fontSize: 25,
                            )),
                        const SizedBox(height: 10),
                        Description(product: product),
                        const SizedBox(height: 10),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [Text('Price: \$ ${product.price}'), Text('Qty. : ${product.quantity}')],
                        ),
                        const SizedBox(height: 10),
                        // Row(
                        //   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        //   crossAxisAlignment: CrossAxisAlignment.start,
                        //   children: [
                        //     Chip(avatar: const Icon(Icons.money_outlined), label: Text('Units sold: ${product.sales}')),
                        //     Chip(avatar: const Icon(Icons.remove_red_eye_sharp), label: Text('views: ${product.views}')),
                        //   ],
                        // ),
                        const SizedBox(height: 10),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            ElevatedButton(
                                onPressed: () => Navigator.of(context).pushNamed('/add-product', arguments: product),
                                child: const SizedBox(
                                  width: 150,
                                  child: Text('Edit Product', textAlign: TextAlign.center),
                                )),
                            ElevatedButton(
                              onPressed: () {
                                showDialog(
                                    context: context,
                                    builder: (context) {
                                      String title = product.title;
                                      String? id = product.id;
                                      return DeleteAlertDialog(
                                        title: title,
                                        id: id,
                                        url: product.imageUrl,
                                      );
                                    });
                              },
                              child: const SizedBox(width: 150, child: Text('Delete Product', textAlign: TextAlign.center)),
                            ),
                          ],
                        ),
                        const SizedBox(height: 20),
                        const Text('Product\'s Performance :'),
                        const SizedBox(height: 20),
                        FittedBox(
                          child: DataTable(decoration: BoxDecoration(border: Border.all(color: Theme.of(context).primaryColorLight)), border: TableBorder.all(), columns: [
                            DataColumn(label: Text('Views', style: TextStyle(fontSize: 20, color: Theme.of(context).primaryColorLight))),
                            DataColumn(label: Text('Units Sold', style: TextStyle(fontSize: 20, color: Theme.of(context).primaryColorLight))),
                          ], rows: [
                            DataRow(cells: [
                              DataCell(Center(child: Text(product.views.toString()))),
                              DataCell(Center(child: Text(product.sales.toString()))),
                            ])
                          ]),
                        ),
                        const SizedBox(height: 30),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
