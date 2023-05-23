import 'package:admin_shop/domain/models/product.dart';
import 'package:admin_shop/presentation/Bloc/bloc/product_bloc.dart';
import 'package:admin_shop/presentation/Bloc/events/product_events.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DeleteAlertDialog extends StatefulWidget {
  final String title;
  final String? id;
  final String url;
  const DeleteAlertDialog({super.key, required this.title, required this.id, required this.url});

  @override
  State<DeleteAlertDialog> createState() => _DeleteAlertDialogState(title: title, id: id, url: url);
}

class _DeleteAlertDialogState extends State<DeleteAlertDialog> {
  String title;
  String? id;
  String url;

  _DeleteAlertDialogState({required this.title, required this.id, required this.url});
  @override
  Widget build(BuildContext context) {
    Reference storage = FirebaseStorage.instance.refFromURL(url);
    return AlertDialog(
      actionsAlignment: MainAxisAlignment.center,
      insetPadding: const EdgeInsets.all(0),
      icon: const Icon(Icons.delete),
      title: Text(
        'Delete "$title"',
        style: const TextStyle(fontSize: 20),
      ),
      content: const SizedBox(height: 100, width: 200, child: Center(child: Text('Do you want to delete all units of this product?'))),
      actions: [
        ElevatedButton(onPressed: () => Navigator.of(context).pop(), child: const Text('Cancel')),
        const SizedBox(width: 20),
        ElevatedButton(
            style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
            onPressed: () {
              Navigator.of(context).pop();
              context.read<DeleteProductBloc>().add(DeleteProductEvent(id ?? ''));
              context.read<ProductListBloc>().add(GetAllProductsEvent());
              Navigator.of(context).pop();
              storage.delete();
            },
            child: const Text('Delete')),
      ],
    );
  }
}

class Description extends StatefulWidget {
  const Description({
    super.key,
    required this.product,
  });

  final Product product;

  @override
  State<Description> createState() => _DescriptionState();
}

class _DescriptionState extends State<Description> {
  bool isExpanded = false;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        isExpanded
            ? Text(widget.product.description, style: Theme.of(context).textTheme.displayMedium)
            : Text(
                '${widget.product.description.substring(0, (widget.product.description.length / 4).ceil())}...',
                style: Theme.of(context).textTheme.displayMedium,
              ),
        TextButton(
          onPressed: () {
            setState(() {
              isExpanded = !isExpanded;
            });
          },
          child: Text(isExpanded ? 'Read Less' : 'Read More'),
        )
      ],
    );
  }
}
