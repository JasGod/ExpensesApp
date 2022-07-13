import 'package:flutter/foundation.dart';

class TransactionsModel {
  final String id;
  final String title;
  final double price;
  final DateTime date;

  TransactionsModel(
      {@required this.id,
      @required this.date,
      @required this.price,
      @required this.title});
}
