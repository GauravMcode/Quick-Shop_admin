import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';

import 'package:admin_shop/data/local/local_data.dart';
import 'package:admin_shop/domain/models/product.dart';
import 'package:admin_shop/presentation/Bloc/bloc/product_bloc.dart';
import 'package:admin_shop/presentation/Bloc/events/product_events.dart';
import 'package:admin_shop/presentation/widgets/input_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

File? _file;
String _imageUrl = '';

class AddProductPage extends StatefulWidget {
  final Product? recievedProduct;
  const AddProductPage({super.key, this.recievedProduct});

  @override
  State<AddProductPage> createState() => _AddProductPageState(recievedProduct: recievedProduct);
}

class _AddProductPageState extends State<AddProductPage> {
  Product? recievedProduct;
  _AddProductPageState({this.recievedProduct});
  final _storageref = FirebaseStorage.instance.ref('products').child('${DateTime.now()}');
  List<Color> gradColors = [const Color(0xff2f3542), const Color(0xffced6e0)];

  final _formKey = GlobalKey<FormState>();
  late TextEditingController _titleController;
  late TextEditingController _descriptionController;
  late final TextEditingController _priceController;
  late final TextEditingController _qtyController;

  late String _id;
  late String _category;

  getId() async {
    _id = await UserIdProvider.getId();
  }

  @override
  void initState() {
    super.initState();
    getId();
    _titleController = TextEditingController(text: recievedProduct?.title);
    _descriptionController = TextEditingController(text: recievedProduct?.description);
    _priceController = TextEditingController(text: recievedProduct?.price.toString());
    _qtyController = TextEditingController(text: recievedProduct?.quantity.toString());
    _category = recievedProduct?.category ?? '';
  }

  @override
  void dispose() {
    _descriptionController.dispose();
    _titleController.dispose();
    _priceController.dispose();
    _qtyController.dispose();
    _file = null;
    _imageUrl = '';
    _category = '';
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return BlocBuilder<ProductBloc, Map>(
      builder: (context, state) {
        return WillPopScope(
          onWillPop: () async {
            _file = null;
            if (_imageUrl != '') {
              await _storageref.delete();
              _imageUrl = '';
            }
            context.read<ProductBloc>().add(GetAllProductsEvent());
            return true;
          },
          child: SafeArea(
            child: Scaffold(
              body: DecoratedBox(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: gradColors.reversed.toList(),
                    begin: Alignment.centerLeft,
                    end: Alignment.centerRight,
                    stops: const [0.1, 0.99],
                  ),
                ),
                child: Stack(
                  children: [
                    SingleChildScrollView(
                      child: Form(
                          key: _formKey,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              SizedBox(height: 200, child: PickImage(_storageref, recievedUrl: recievedProduct?.imageUrl)),
                              const SizedBox(height: 25),
                              DropdownButtonFormField(
                                decoration: InputDecoration(
                                    hintText: 'Select Category',
                                    hintStyle: TextStyle(color: Theme.of(context).primaryColor),
                                    enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(40),
                                    )),
                                items: List.generate(categories.length, (index) => DropdownMenuItem(value: categories[index], child: Text(categories[index]))),
                                onChanged: (value) {
                                  setState(() {
                                    _category = value!;
                                  });
                                },
                              ),
                              const SizedBox(height: 25),
                              SizedBox(width: size.width, height: 55, child: FormFieldInput('Title', false, _titleController)),
                              const SizedBox(height: 50),
                              PhysicalModel(
                                elevation: 40,
                                shape: BoxShape.circle,
                                color: Colors.grey,
                                child: TextField(
                                  controller: _descriptionController,
                                  autocorrect: true,
                                  enableSuggestions: true,
                                  maxLines: 5,
                                  onEditingComplete: () {
                                    FocusManager.instance.primaryFocus?.unfocus();
                                  },
                                  onTapOutside: (event) {
                                    FocusManager.instance.primaryFocus?.unfocus();
                                  },
                                  onSubmitted: (newValue) {
                                    FocusManager.instance.primaryFocus?.unfocus();
                                  },
                                  decoration: InputDecoration(
                                    hintText: 'Description',
                                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(40)),
                                    fillColor: Colors.white,
                                    hintStyle: TextStyle(color: Theme.of(context).primaryColor),
                                    contentPadding: const EdgeInsets.all(20),
                                    filled: true,
                                  ),
                                ),
                              ),
                              const SizedBox(height: 50),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  SizedBox(width: size.width * 0.5, child: FormFieldInput('Price', false, _priceController)),
                                  SizedBox(width: size.width * 0.5, child: FormFieldInput('Quantity', false, _qtyController)),
                                ],
                              ),
                              const SizedBox(height: 20),
                              ElevatedButton(
                                onPressed: () {
                                  if (_formKey.currentState!.validate()) {
                                    final product = Product(
                                      _titleController.text,
                                      _descriptionController.text,
                                      "${_imageUrl == '' && recievedProduct != null ? recievedProduct?.imageUrl : _imageUrl}",
                                      int.parse(_priceController.text),
                                      int.parse(_qtyController.text),
                                      _id,
                                      _category,
                                      id: recievedProduct?.id,
                                    );
                                    context.read<ProductBloc>().add(AddProductEvent(product));
                                    if (recievedProduct != null) {
                                      context.read<ProductBloc>().add(GetProductEvent(recievedProduct?.id as String));
                                    }
                                    Navigator.of(context).pop();
                                  }
                                },
                                child: Text(recievedProduct == null ? "Add Product" : "Update Product"),
                              ),
                            ],
                          )),
                    ),
                    Positioned(child: IconButton(onPressed: () => Navigator.of(context).pop(), icon: const Icon(Icons.arrow_back, size: 30)))
                  ],
                ),
              ),
            ),
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
  const PickImage(this._storageref, {super.key, this.recievedUrl});

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
        task = await _storageref.putFile(_file!).then((p0) async {
          _imageUrl = await _storageref.getDownloadURL();
          setState(() {});
          return p0;
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
              ? const CircularProgressIndicator()
              : GestureDetector(
                  child: Image.network('${recievedUrl != null && _imageUrl == '' ? recievedUrl : _imageUrl}'),
                  onTap: () => showSheet(),
                ),
    );
  }
}

final List<String> categories = ['All', 'Electronics', 'Clothing', 'Books', 'Jwellery', 'Household', 'Office', 'Shoes'];
