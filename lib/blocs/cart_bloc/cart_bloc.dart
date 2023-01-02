import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:pbl6/models/cart.dart';
import 'package:pbl6/services/repository_cart.dart';

part 'cart_event.dart';
part 'cart_state.dart';

class CartBloc extends Bloc<CartEvent, CartState> {
  RepositoryCart repositoryCart;
  CartBloc(this.repositoryCart) : super(CartInitialState()) {
    on<GetCartListEvent>(_onGetCartList);
  }

  _onGetCartList(GetCartListEvent event, Emitter<CartState> emit) async {
    emit(CartLoadingState());
    List<Cart> cartList = await repositoryCart.getCartItemByUserId(event.idUser.toString());
    emit(CartLoadedState(cartList));
  }
}
