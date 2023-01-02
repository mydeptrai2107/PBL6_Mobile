part of 'cart_bloc.dart';

abstract class CartEvent extends Equatable {
  const CartEvent();

  @override
  List<Object> get props => [];
}

class GetCartListEvent extends CartEvent {
  int idUser;
  GetCartListEvent(this.idUser);
}
