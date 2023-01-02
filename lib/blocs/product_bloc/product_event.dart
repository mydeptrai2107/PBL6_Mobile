// ignore_for_file: public_member_api_docs, sort_constructors_first, must_be_immutable
part of 'product_bloc.dart';

abstract class ProductEvent extends Equatable {
  const ProductEvent();

  @override
  List<Object> get props => [];
}

class GetProductListEvent extends ProductEvent {}

class SearchProductEvent extends ProductEvent {
  String name;
  SearchProductEvent({
    required this.name,
  });
}
