import 'package:admin_shop/domain/models/product.dart';
import 'package:admin_shop/presentation/Bloc/bloc/metric_bloc.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class ProductsAppBar extends StatelessWidget {
  const ProductsAppBar({
    super.key,
    required this.products,
    required this.units,
    required this.numberFormat,
    required this.price,
    required this.tooltipBehavior,
    required this.dataList,
  });

  final List<Product> products;
  final int units;
  final NumberFormat numberFormat;
  final int price;
  final TooltipBehavior tooltipBehavior;
  final List<InventoryData> dataList;

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      backgroundColor: Theme.of(context).primaryColor.withOpacity(0.8),
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.only(bottomLeft: Radius.circular(50), bottomRight: Radius.circular(50))),
      elevation: 40,
      expandedHeight: 400,
      centerTitle: true,
      floating: false,
      flexibleSpace: SingleChildScrollView(
        child: Column(
          children: [
            Card(
              color: Colors.white.withOpacity(0.5),
              elevation: 40,
              margin: const EdgeInsets.only(top: 10.0),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: DefaultTextStyle(
                  style: const TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text.rich(TextSpan(text: 'Products : ', children: [TextSpan(text: '${products.length}', style: const TextStyle(color: Colors.yellow))])),
                      Text.rich(TextSpan(text: 'Units : ', children: [TextSpan(text: '$units', style: const TextStyle(color: Colors.blue))])),
                      Text.rich(TextSpan(text: 'Inventory Cost : ', children: [TextSpan(text: '₹ ${numberFormat.format(price)}', style: const TextStyle(color: Colors.red))])),
                      Text.rich(
                        TextSpan(
                            text: 'Total Revenue : ',
                            children: [TextSpan(text: '₹ ${numberFormat.format(context.read<MetricBloc>().state['totalRevenue'])}', style: const TextStyle(color: Colors.green))]),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            SfCircularChart(
              title: ChartTitle(text: 'Category wise Inventory Cost Distribution :', textStyle: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
              legend: Legend(isVisible: true, overflowMode: LegendItemOverflowMode.wrap, textStyle: const TextStyle(color: Colors.white)),
              tooltipBehavior: tooltipBehavior,
              series: <PieSeries>[
                PieSeries<InventoryData, String>(
                  explode: true,
                  name: 'Inventory Distribution',
                  dataSource: dataList,
                  xValueMapper: (InventoryData data, _) => data.category,
                  yValueMapper: (InventoryData data, _) => data.data,
                  dataLabelSettings: const DataLabelSettings(isVisible: true),
                  enableTooltip: true,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class InventoryData {
  String category;
  int data;
  InventoryData(this.category, this.data);
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
                child: CachedNetworkImage(
                    key: UniqueKey(),
                    imageUrl: products[index].imageUrl,
                    fit: BoxFit.contain,
                    progressIndicatorBuilder: (context, url, progress) => Center(
                          child: Lottie.asset('assets/143310-loader.json', width: 150, height: 100),
                        )),
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
    return SizedBox(
      height: 100,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            products[index].title,
            style: const TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
            overflow: TextOverflow.ellipsis,
          ),
          const Spacer(flex: 1),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text(
                'Price: ₹ ${products[index].price}',
                style: const TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
              ),
              Text(
                'Qty. : ${products[index].quantity}',
                style: const TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
              )
            ],
          ),
          const Spacer(flex: 1),
          Text(
            'Units sold: ${products[index].sales}',
            style: const TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
          ),
          const Spacer(flex: 1),
        ],
      ),
    );
  }
}
