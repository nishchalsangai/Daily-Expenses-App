import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class NewTransactions extends StatefulWidget {
  final Function addtx;
  NewTransactions(this.addtx);

  @override
  _NewTransactionsState createState() => _NewTransactionsState();
}

class _NewTransactionsState extends State<NewTransactions> {
  final titleController= TextEditingController();

  final amountController= TextEditingController();

  DateTime _selectedDate;

  void submitData(){
    final txtitle = titleController.text;
    final txamount = double.parse(amountController.text);
     if(txtitle.isEmpty || txamount<=0 || _selectedDate == null)
       {
         return;
       }

    widget.addtx(
      titleController.text,
      double.parse(amountController.text),
      _selectedDate,
    );

     //Navigator.of(context).pop();
  }

  void _presentDatePicker(){
    showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime.now(),
    ).then((selectedDate) {
      if(selectedDate==null)
        return;
      else
        setState(() {
          _selectedDate=selectedDate;
        });

    });
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Container(
        padding: EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            TextField(
              decoration: InputDecoration(labelText: 'Title'),
              controller: titleController,
              onSubmitted: (_) => submitData() ,
            ),   //For user input
            TextField(
              decoration: InputDecoration(labelText: 'Amount'),
              controller: amountController,
              keyboardType: TextInputType.number,
              onSubmitted: (_) => submitData(),
            ),
            Container(
              height: 80,
              child: Row(
                children: [
                  Expanded(child: Text(_selectedDate==null? 'No date choosen': DateFormat.yMd().format(_selectedDate))),
                  FlatButton(child: Text('Choose date',style: TextStyle(color: Theme.of(context).primaryColor),), onPressed: _presentDatePicker,),
                ],
              ),
            ),
            ElevatedButton(child: Text('Add Transactions',style: TextStyle(color: Colors.white),), onPressed: submitData,),
          ],
        ),
      ),
    );
  }
}
