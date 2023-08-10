import 'package:expense_tracker/models/expense.dart';
import 'package:expense_tracker/widgets/expenses_list/expenses_item.dart';
import 'package:flutter/material.dart';
class ExpensesList extends StatelessWidget{
   const ExpensesList({super.key,required this.expenses ,required this.onremove});
     final List<Expense> expenses ;
 final void Function(Expense expense) onremove;

  @override
  Widget build(BuildContext context) {
   return ListView.builder(
    itemCount:expenses.length ,
    itemBuilder:(ctx,index)=>  Dismissible(
      background: Container(color: Colors.red,
      margin: const EdgeInsets.all(30),
      ),
      onDismissed: (direction){
           onremove(expenses[index]);
      },
      key: ValueKey(expenses[index]),
       child: ExpenseItem(expenses[index]),
       ),
    
     );
  }
}