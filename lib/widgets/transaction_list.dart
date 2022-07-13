import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../models/transactions_model.dart';

class TransactionList extends StatelessWidget {
  final List<TransactionsModel> _transactions;
  final Function deleteTx;

  TransactionList(this._transactions, this.deleteTx);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return _transactions.isEmpty
        ? LayoutBuilder(builder: (context, Constraints) {
            return Column(
              children: [
                Text(
                  'No transactions add yet.',
                  style: theme.textTheme.headline6,
                ),
                Container(
                  height: Constraints.maxHeight * 0.7,
                  padding: EdgeInsets.only(top: 20),
                  child: Image.asset(
                    'assets/image/waiting.png',
                    fit: BoxFit.cover,
                  ),
                )
              ],
            );
          })
        : ListView.builder(
            itemCount: _transactions.length,
            itemBuilder: (context, index) {
              return Card(
                elevation: 5,
                margin: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                child: Padding(
                  padding: const EdgeInsets.all(10),
                  child: ListTile(
                    leading: FittedBox(
                      child: CircleAvatar(
                        radius: 45,
                        child: Text(
                          "XAF ${_transactions[index].price}",
                        ),
                      ),
                    ),
                    title: Text(_transactions[index].title,
                        style: theme.textTheme.headline6),
                    subtitle: Text(
                      DateFormat.yMMMMd('fr').format(_transactions[index].date),
                      style: TextStyle(color: theme.colorScheme.tertiary),
                    ),
                    trailing: MediaQuery.of(context).size.width > 460
                        ? TextButton.icon(
                            onPressed: () => deleteTx(_transactions[index].id),
                            icon: Icon(Icons.delete),
                            label: Text('delete'),
                            style: TextButton.styleFrom(
                              primary: theme.colorScheme.error,
                            ),
                          )
                        : IconButton(
                            icon: Icon(Icons.delete),
                            color: theme.colorScheme.error,
                            onPressed: () => deleteTx(_transactions[index].id),
                          ),
                  ),
                ),
                /* Row(
                    children: [
                      Container(
                          margin: EdgeInsets.symmetric(
                              vertical: 15, horizontal: 20),
                          decoration: BoxDecoration(
                              border: Border.all(
                                  color: theme.colorScheme.primary,
                                  width: 2)),
                          padding: EdgeInsets.all(10),
                          child: Text(
                            "XAF ${_transactions[index].price.toStringAsFixed(2)}",
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 20,
                                color: theme.colorScheme.primary),
                          )), //Box of amount
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(_transactions[index].title,
                              style: theme.textTheme.headline6),
                          Text(
                            DateFormat.yMMMMd('fr')
                                .format(_transactions[index].date),
                            style: TextStyle(
                                color: theme.colorScheme.secondary),
                          )
                        ],
                      )
                    ],
                  ), */
              );
            },
          ); //List of Tx;
  }
}
