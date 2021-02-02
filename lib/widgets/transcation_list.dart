import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../models/transactions.dart';
import 'package:intl/intl.dart';

class transactionList extends StatelessWidget {
  final List<Transactions> transactions;
  final Function deleteTx;
  transactionList(this.transactions,this.deleteTx);
  @override
  Widget build(BuildContext context) {
    return Container(
        height: 450,
        child: transactions.isEmpty ?
        Center(
          child: Column(
           
          children: [
            Text('Waiting For Transactions', style: TextStyle(fontWeight: FontWeight.bold, fontFamily: 'OpenSans'),),
            SizedBox(
              height: 20,
            ),
            Container(
                height: 250,
                child: Image.asset('assets/image/waiting.png', fit: BoxFit.cover,))
          ],
          ),
        ) : ListView.builder(
          itemBuilder: (ctx,index){
            return Card(
              color: Colors.black,
              child: Padding(
                padding: EdgeInsets.all(8),
                child: ListTile(
                  leading: CircleAvatar(radius: 30,child: FittedBox(child: Text('\$${transactions[index].amount}',style: Theme.of(context).textTheme.headline6,)),),
                  title: Text(transactions[index].title,style: Theme.of(context).textTheme.headline6,),
                  subtitle: Text(DateFormat.yMMMd().format(transactions[index].dateTime),style: Theme.of(context).textTheme.headline6,),
                  trailing: IconButton(icon: Icon(Icons.delete),color: Theme.of(context).primaryColor,onPressed: () => deleteTx(transactions[index].id)),
                ),
              ),
            );
          },
          itemCount: transactions.length,

       ),
    );



  }
}
