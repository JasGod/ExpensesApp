import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class NewTransaction extends StatefulWidget {
  final Function _addNewTransact;

  NewTransaction(this._addNewTransact);

  @override
  State<NewTransaction> createState() => _NewTransactionState();
}

class _NewTransactionState extends State<NewTransaction> {
  final _titleController = TextEditingController();
  final _amountController = TextEditingController();

  DateTime _selectedDate;

  void _presentDatePicker() {
    showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2022),
      lastDate: DateTime(2095),
    ).then((pickedDate) {
      if (pickedDate == null) {
        return;
      }
      setState(() {
        _selectedDate = pickedDate;
      });
    });
  }

  void _submitedData() {
    if (_titleController.text.isEmpty ||
        double.parse(_amountController.text) < 0 ||
        _selectedDate == null) {
      return;
    }
    widget._addNewTransact(_titleController.text,
        double.parse(_amountController.text), _selectedDate);

    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return SingleChildScrollView(
      child: Card(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(top: Radius.circular(25.0))),
        elevation: 7,
        child: Padding(
          padding: EdgeInsets.only(
            top: 10,
            left: 10,
            right: 10.0,
            bottom: MediaQuery.of(context).viewInsets.bottom + 10,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              TextField(
                decoration: InputDecoration(labelText: 'Title'),
                controller: _titleController,
                onSubmitted: (_) => _submitedData(),
                keyboardType: TextInputType.text,
              ),
              TextField(
                decoration: InputDecoration(labelText: 'Amount'),
                controller: _amountController,
                onSubmitted: (_) => _submitedData(),
                keyboardType: TextInputType.number,
              ),
              Container(
                height: 70,
                child: Row(
                  children: [
                    Expanded(
                      child: Text(_selectedDate == null
                          ? 'No date choosen!'
                          : 'Date picked: ${DateFormat.yMMMEd('fr').format(_selectedDate)}'),
                    ),
                    TextButton(
                        onPressed: _presentDatePicker,
                        child: Text(
                          'choose a date',
                          style: TextStyle(
                              color: theme.colorScheme.primary,
                              fontWeight: FontWeight.bold),
                        )),
                  ],
                ),
              ),
              ElevatedButton(
                onPressed: _submitedData,
                child: Text('Add Transaction'),
                style: ElevatedButton.styleFrom(
                    primary: theme.colorScheme.primary,
                    onSurface: theme.colorScheme.onSurface),
              )
            ],
          ),
        ),
      ),
    ); //Form for the user!
  }
}
