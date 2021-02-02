import 'package:flutter/material.dart';
import './models/transactions.dart';
import './widgets/new_transactions.dart';
import './widgets/transcation_list.dart';
import './widgets/chart.dart';

void main() => runApp(expenses());

class expenses extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Daily Expenses App',
      theme: ThemeData(
        primarySwatch: Colors.deepPurple,
        accentColor: Colors.black,
        fontFamily: 'Quicksand',
        textTheme: ThemeData.light().textTheme.copyWith(
          headline6: TextStyle(
              fontFamily: 'OpenSans',
              fontSize: 15,
              fontWeight: FontWeight.bold,
              color: Colors.white,
          ),
        ),
        appBarTheme: AppBarTheme(
          textTheme: ThemeData.light().textTheme.copyWith(
            headline6: TextStyle(
              fontFamily: 'OpenSans',
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          )
        ),
      ),

      home: MyHomePage(),
    );
  }
}


class MyHomePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _MyHomePages();
}

class _MyHomePages extends State<MyHomePage> {
  final List<Transactions> _usertransactions = [
  /*  Transactions(
        id: 'T1',
        title: 'Books',
        amount: 300,
        dateTime: DateTime.now()
    ),
    Transactions(
        id: 'T2',
        title: 'Pens',
        amount: 200,
        dateTime: DateTime.now()
    ),*/
  ];
  void _addtransactions(String txtitle,double txamount, DateTime selectedDate){
    final newtx= Transactions(
      id: DateTime.now().toString(),
      title: txtitle,
      amount: txamount,
      dateTime: selectedDate,
    );
    setState(() {
      _usertransactions.add(newtx);
    });
  }
  void _addNewTrans(BuildContext ctx)
  {
    showModalBottomSheet(
        context: ctx,
        builder: (_) {
          return GestureDetector(
            onTap: () {},
            child:NewTransactions(_addtransactions),
            behavior: HitTestBehavior.opaque,
          );
        },
    );
  }
  void _delTranscation(String id){
    setState(() {
      return _usertransactions.removeWhere((tx) => tx.id==id);
    });
  }
  List<Transactions> get _recentTransactions{
    return _usertransactions.where((tx){
      return tx.dateTime.isAfter(DateTime.now().subtract(Duration(days: 7)),);
    }).toList();
  }
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
        appBar: AppBar(
          title: Text('Daily Expenses App'),
          actions: [
            IconButton(icon: Icon(Icons.add),
                onPressed: () => _addNewTrans(context),
            )
          ],
        ),
        body: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
             Chart(_recentTransactions),
              transactionList(_usertransactions, _delTranscation),
            ],
          ),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        floatingActionButton: FloatingActionButton(
          child: Icon(
            Icons.add,
          ),
          onPressed: () => _addNewTrans(context),
        ),
      );
  }
}
