part of 'cart_bloc.dart';

abstract class CartState extends Equatable {
  const CartState();
  
  @override
  List<Object> get props => [];
}

class CartInitialState extends CartState {}

class CartLoadingState extends CartState{}

class CartLoadedState extends CartState{
  final List<Cart> listCart;

  const CartLoadedState(this.listCart);
}

class CartDeleteErrorState extends CartState{
  final String message;
  const CartDeleteErrorState(this.message);
}
