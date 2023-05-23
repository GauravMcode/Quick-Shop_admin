import 'package:admin_shop/domain/repositories/product_repository.dart';
import 'package:admin_shop/presentation/Bloc/events/product_events.dart';
import 'package:bloc/bloc.dart';

class ProductBloc extends Bloc<ProductEvents, Map> {
  // final Product product = Product('', '', '', 0, 0, '');
  ProductBloc(product) : super(product) {
    on<AddProductEvent>((event, emit) async {
      final data = await ProductRepository.addProduct(event.product);
      emit(data);
    });

    on<GetProductEvent>((event, emit) async {
      final data = await ProductRepository.getProduct(event.id);
      emit(data);
    });
  }
}

class ProductListBloc extends Bloc<ProductEvents, Map> {
  ProductListBloc() : super({}) {
    on<GetAllProductsEvent>((event, emit) async {
      final data = await ProductRepository.getAllProducts();
      emit(data);
    });
  }
}

class DeleteProductBloc extends Bloc<ProductEvents, String> {
  DeleteProductBloc() : super('') {
    on<DeleteProductEvent>((event, emit) async {
      final data = await ProductRepository.deleteProduct(event.id);
      emit(data);
    });
  }
}
