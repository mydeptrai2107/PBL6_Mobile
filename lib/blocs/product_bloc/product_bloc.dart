// ignore: depend_on_referenced_packages
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:pbl6/models/product.dart';
import 'package:pbl6/services/repository_product.dart';

part 'product_event.dart';
part 'product_state.dart';

class ProductBloc extends Bloc<ProductEvent, ProductState> {
  RepositoryProduct repositoryProduct;
  ProductBloc(this.repositoryProduct) : super(ProductInitial()) {
    on<GetProductListEvent>(_onGetProductList);
    on<SearchProductEvent>(_onSearchProductList);
  }

  _onGetProductList(
      GetProductListEvent event, Emitter<ProductState> emit) async {
    emit(ProductLoading());
    List<Product> productList = await repositoryProduct.GetAllProduct();
    emit(ProductLoaded(productList));
  }

  _onSearchProductList(
      SearchProductEvent event, Emitter<ProductState> emit) async {
    emit(ProductLoading());
    List<Product> productList =
        await repositoryProduct.GetProductByName(event.name);
    emit(ProductLoaded(productList));
  }
}
