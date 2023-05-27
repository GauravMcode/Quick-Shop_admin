import 'dart:io';

import 'package:admin_shop/domain/models/product.dart';
import 'package:admin_shop/presentation/Bloc/bloc/metric_bloc.dart';
import 'package:admin_shop/presentation/Bloc/bloc/product_bloc.dart';
import 'package:firebase_storage/firebase_storage.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';
import 'package:admin_shop/domain/models/user.dart';
import 'package:admin_shop/presentation/Bloc/bloc/auth_bloc.dart';
import 'package:admin_shop/presentation/Bloc/events/auth_events.dart';

File? _file;
String _imageUrl = '';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  List<Color> gradColors = [const Color(0xffced6e0), const Color(0xff2f3542).withOpacity(0.2)];
  final _storageref = FirebaseStorage.instance.ref('profiles');
  NumberFormat numberFormat = NumberFormat.decimalPattern('hi');

  @override
  Widget build(BuildContext context) {
    final List<Product> products = context.read<ProductListBloc>().state['data'];
    final revenue = context.read<MetricBloc>().state['totalRevenue'];
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
    return BlocBuilder<UserBloc, User>(
      builder: (context, userState) {
        return Scaffold(
          body: CustomScrollView(
            slivers: [
              SliverAppBar(
                actions: const [
                  Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Icon(Icons.camera_enhance_outlined),
                  )
                ],
                shape: const RoundedRectangleBorder(borderRadius: BorderRadius.only(bottomLeft: Radius.circular(50), bottomRight: Radius.circular(50))),
                backgroundColor: Theme.of(context).primaryColorDark,
                expandedHeight: 300,
                floating: true,
                flexibleSpace: PickImage(
                  _storageref,
                  recievedUrl: userState.imageUrl,
                  user: userState,
                ),
              ),
              SliverToBoxAdapter(
                child: SingleChildScrollView(
                  child: DecoratedBox(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(colors: gradColors, stops: const [0.2, 0.99]),
                    ),
                    child: DefaultTextStyle(
                      style: TextStyle(color: Theme.of(context).primaryColorDark, fontSize: 20, fontWeight: FontWeight.bold),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: FittedBox(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const SizedBox(height: 15),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  const Text('Name :'),
                                  const SizedBox(width: 50),
                                  Text(
                                    userState.name,
                                  ),
                                ],
                              ),
                              const SizedBox(height: 20),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  const Text('Email :'),
                                  const SizedBox(width: 50),
                                  Text(
                                    userState.email,
                                    style: TextStyle(
                                      color: Theme.of(context).primaryColorDark,
                                      fontSize: 20,
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 20),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  const Text('Products :'),
                                  const SizedBox(width: 50),
                                  Text(
                                    products.length.toString(),
                                    style: const TextStyle(
                                      color: Color.fromARGB(255, 255, 233, 169),
                                      fontSize: 20,
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 20),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  const Text('Units :'),
                                  const SizedBox(width: 70),
                                  Text(
                                    units.toString(),
                                    style: const TextStyle(
                                      color: Color.fromARGB(255, 0, 61, 167),
                                      fontSize: 20,
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 25),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  const Text('Inventory :'),
                                  const SizedBox(width: 35),
                                  Text(
                                    '₹ ${numberFormat.format(price)}',
                                    style: const TextStyle(
                                      color: Colors.red,
                                      fontSize: 20,
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 25),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  const Text('Revenue :'),
                                  const SizedBox(width: 35),
                                  Text(
                                    '₹ ${numberFormat.format(revenue)}',
                                    style: const TextStyle(
                                      color: Colors.green,
                                      fontSize: 20,
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 25),
                              SizedBox(
                                  width: MediaQuery.of(context).size.width,
                                  child: ElevatedButton.icon(
                                    icon: const Icon(Icons.logout),
                                    style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
                                    onPressed: () {
                                      context.read<AuthStatusBloc>().add(SignOutEvent());
                                      context.read<AuthStatusBloc>().add(AuthStateEvent());
                                      Navigator.of(context).pushReplacementNamed('/start');
                                    },
                                    label: const Text('Sign Out', style: TextStyle(fontWeight: FontWeight.bold)),
                                  )),
                              const SizedBox(height: 100),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

//to pick the image of product
class PickImage extends StatefulWidget {
  final Reference _storageref;
  final String? recievedUrl;
  final User user;
  const PickImage(this._storageref, {super.key, this.recievedUrl, required this.user});

  @override
  State<PickImage> createState() => _PickImageState(_storageref, recievedUrl: recievedUrl);
}

class _PickImageState extends State<PickImage> {
  late TaskSnapshot task;
  final Reference _storageref;
  String? recievedUrl;
  _PickImageState(this._storageref, {this.recievedUrl});
  getImage(ImageSource source) async {
    Navigator.of(context).pop();
    _imageUrl = '';
    try {
      final ImagePicker picker = ImagePicker();
      final XFile? image = await picker.pickImage(source: source);
      setState(() {});
      _file = File(image?.path ?? '');
      try {
        task = await _storageref.child(widget.user.id.substring(0, 14)).putFile(_file!).then((p0) async {
          _imageUrl = await _storageref.child(widget.user.id.substring(0, 14)).getDownloadURL();
          setState(() {});
          return p0;
        }).then((value) {
          widget.user.imageUrl = _imageUrl;
          context.read<UserBloc>().add(UpdateUserEvent(widget.user));
          return value;
        });
      } on FirebaseException {
        rethrow;
      }
    } catch (e) {
      rethrow;
    }
  }

  showSheet() {
    showBottomSheet(
        context: context,
        constraints: const BoxConstraints(maxHeight: 150),
        builder: (context) {
          return Center(
            child: SizedBox(
              height: 300,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton.icon(
                    onPressed: () => getImage(ImageSource.gallery),
                    icon: const Icon(Icons.image_outlined),
                    label: const Text('Gallery'),
                  ),
                  ElevatedButton.icon(
                    onPressed: () => getImage(ImageSource.camera),
                    icon: const Icon(Icons.camera),
                    label: const Text('Camera'),
                  )
                ],
              ),
            ),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: _file == null && recievedUrl == null
          ? ElevatedButton.icon(onPressed: () => showSheet(), icon: const Icon(Icons.image), label: const Text('Pick an Image'))
          : _imageUrl == '' && recievedUrl == null
              ? Lottie.asset('assets/143310-loader.json', width: 150, height: 100)
              : GestureDetector(
                  child: Image.network('${recievedUrl != null && _imageUrl == '' ? recievedUrl : _imageUrl}'),
                  onTap: () => showSheet(),
                ),
    );
  }
}
