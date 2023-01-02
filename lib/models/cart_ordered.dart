class CartOrder {
  CartOrder(
      {required this.id,
      required this.userId,
      required this.productId,
      required this.productName,
      required this.productQuantityLeft,
      required this.productCount,
      required this.pricePerOne,
      required this.description,
      required this.idOrder});

  int id;
  int userId;
  int productId;
  String productName;
  int productQuantityLeft;
  int productCount;
  double pricePerOne;
  String description;
  int idOrder;
}
