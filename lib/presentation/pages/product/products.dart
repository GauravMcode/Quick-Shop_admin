import 'package:admin_shop/domain/models/product.dart';
import 'package:admin_shop/presentation/Bloc/bloc/product_bloc.dart';
import 'package:admin_shop/presentation/widgets/products/products_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

class ProductsPage extends StatefulWidget {
  const ProductsPage({super.key});

  @override
  State<ProductsPage> createState() => _ProductsPageState();
}

class _ProductsPageState extends State<ProductsPage> {
  NumberFormat numberFormat = NumberFormat.decimalPattern('hi');
  final TooltipBehavior _tooltipBehavior = TooltipBehavior();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProductListBloc, Map>(
      builder: (context, state) {
        List<Product> products = state['data'] ?? [];
        int units = 0;
        int price = 0;
        Map data = {};
        for (var i = 0; i < products.length; i++) {
          units += products[i].quantity;
          price += products[i].quantity * products[i].price;
          if (data.keys.contains(products[i].category)) {
            data[products[i].category] = products[i].quantity * products[i].price;
          } else {
            data[products[i].category] = products[i].quantity * products[i].price;
          }
        }
        final List<InventoryData> dataList = state.isNotEmpty ? List.generate(data.length, (index) => InventoryData(data.keys.elementAt(index), data.values.elementAt(index))) : [];
        print(data);
        return products.isEmpty
            ? Center(
                child: Lottie.asset('assets/143310-loader.json'),
              )
            : SafeArea(
                child: Scaffold(
                  body: CustomScrollView(
                    slivers: [
                      ProductsAppBar(products: products, units: units, numberFormat: numberFormat, price: price, tooltipBehavior: _tooltipBehavior, dataList: dataList),
                      state.isEmpty
                          ? const SliverToBoxAdapter(child: Center(child: CircularProgressIndicator()))
                          : SliverList(
                              delegate: SliverChildListDelegate.fixed([
                                StaggeredGrid.count(
                                  crossAxisCount: 2,
                                  mainAxisSpacing: 12,
                                  children: List.generate(
                                      products.length,
                                      (index) => InkWell(
                                            onTap: () => Navigator.of(context).pushNamed('/product', arguments: products[index]),
                                            child: Card(
                                              elevation: 40,
                                              color: Colors.black.withOpacity(0.8),
                                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                                              child: Column(
                                                children: [
                                                  ProductImage(products: products, index: index),
                                                  ProductOverview(products: products, index: index),
                                                ],
                                              ),
                                            ),
                                          )),
                                ),
                              ]),
                            ),
                    ],
                  ),
                ),
              );
      },
    );
  }
}
