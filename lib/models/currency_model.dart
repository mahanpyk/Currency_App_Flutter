class CurrencyModel {
  final int id;
  final String name;
  final String price;
  final String changeStatus;
  final double changePercent;
  final String changePrice;

  CurrencyModel({
    required this.id,
    required this.name,
    required this.price,
    required this.changeStatus,
    required this.changePercent,
    required this.changePrice,
  });
}
