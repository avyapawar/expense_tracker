import 'package:expense_tracker/chart.dart';
import 'package:expense_tracker/widgets/expenses_list/add_expenses.dart';
import 'package:expense_tracker/widgets/expenses_list/expenses_list.dart';
import 'package:flutter/material.dart';
import 'package:expense_tracker/models/expense.dart';
class Expenses extends StatefulWidget{
  const Expenses({super.key});
  @override
  State<Expenses> createState() {
   return  _ExpensesState() ;
  }
}
class _ExpensesState extends State<Expenses>{
final List<Expense> registerdExpenses = [
    Expense(amount:19.99 ,
     date: DateTime.now(),
     title: 'flutter course',
     category: Category.work),
       Expense(amount:50.15 ,
     date: DateTime.now(),
     title: 'travelling',
     category: Category.travel)
];

void _onAddExpenses(){
showModalBottomSheet(
  useSafeArea: true ,
  isScrollControlled: true ,
  context: context, 
  builder: (ctx) =>   AddExpenses(addToList: addExpenses) );
} 

void addExpenses (Expense expense){
  setState(() {
    registerdExpenses.add(expense);

  });
}

void removeExpenses(Expense expense){
  var expenseIndex = registerdExpenses.indexOf(expense);
  setState(() {
    registerdExpenses.remove(expense);
    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(
       SnackBar(
        content: const Text('expense deleted'),
        duration: const Duration(seconds: 4),
        action: SnackBarAction(label: 'undo', 
        onPressed: (){
          setState(() {
                     registerdExpenses.insert(expenseIndex, expense);

          });
        }),
        ),
        );
        

  });
}

@override
  Widget build(BuildContext context) {
  final width = MediaQuery.of(context).size.width ;

Widget mainCompoment = const Center(child: Text('your list is empty'),
);
if(registerdExpenses.isNotEmpty){
mainCompoment =ExpensesList(expenses: registerdExpenses,onremove:removeExpenses ,) ;
}

   return  Scaffold(
     appBar: AppBar(
      title:  const Text('flutter expense tracker'),
      actions:  [
        IconButton(onPressed: _onAddExpenses, icon:  const Icon(Icons.add)),
      ],
      
     ),
     
   
      body:width < 700 ? Column(
        children: [
           Chart(expenses: registerdExpenses),
          Expanded(child: mainCompoment ),
],
      ): Row(
        children: [ Expanded(child: Chart(expenses: registerdExpenses)),
          Expanded(child: mainCompoment ),],
      )
      
   );
     }
}