import 'package:admin_shop/domain/models/product.dart';

abstract class ProductEvents {}

class AddProductEvent extends ProductEvents {
  Product product;
  AddProductEvent(this.product);
}

class GetProductEvent extends ProductEvents {
  String id;
  GetProductEvent(this.id);
}

class DeleteProductEvent extends ProductEvents {
  String id;
  DeleteProductEvent(this.id);
}

class GetAllProductsEvent extends ProductEvents {}

class ResetProductsEvent extends ProductEvents {}
