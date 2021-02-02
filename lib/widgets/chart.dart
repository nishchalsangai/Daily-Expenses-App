import 'package:flutter/material.dart';
import '../models/transactions.dart';
import 'package:intl/intl.dart';
import './chartbar.dart';

class Chart extends StatelessWidget {
  final List<Transactions> recentTransactions;
  Chart(this.recentTransactions);

  List<Map<String,Object>> get groupedtransactionvalues{
   return List.generate(7,(index) {
      final weekDay= DateTime.now().subtract(Duration(days: index),);
      double totalsum=0;
      for(int i=0;i<recentTransactions.length;i++)
        {
          if(recentTransactions[i].dateTime.day==weekDay.day
              && recentTransactions[i].dateTime.month==weekDay.month
              && recentTransactions[i].dateTime.year==weekDay.year)
            {
             totalsum=totalsum+recentTransactions[i].amount;
            }
        }
     /* print(DateFormat.E().format(weekDay));
      print(totalsum);*/
      return {'day':DateFormat.E().format(weekDay), 'amount': totalsum};   //through this we will get abbrevation of weekday
   });
  }
  double get totalSpending{
    return groupedtransactionvalues.fold(0.0, (sum, item) {
      return sum=sum+item['amount'];
    });
  }
  @override
  Widget build(BuildContext context) {
   /* print(groupedtransactionvalues);*/
    return Card(
      elevation: 7,
      margin: EdgeInsets.all(10),
      child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: groupedtransactionvalues.map((data){
            return Flexible(
              fit: FlexFit.tight,
              child: ChartBar(
                data['day'],
                data['amount'],
               totalSpending == 0.0 ? 0.0 : (data['amount'] as double) / totalSpending,
              ),
            );
          }).toList(),
        ),
      ),
    );
  }
}
