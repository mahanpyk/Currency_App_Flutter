class CurrencyModel {
  int _id;
  String _name;
  int _price;
  String _changeStatus;
  double _changePercent;
  int _changePrice;

  CurrencyModel(this._id, this._name, this._price, this._changeStatus,
      this._changePercent, this._changePrice);

  String get changeStatus => _changeStatus;

  String get name => _name;

  int get id => _id;

  int get changePrice => _changePrice;

  double get changePercent => _changePercent;

  int get price => _price;
}
