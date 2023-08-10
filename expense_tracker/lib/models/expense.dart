import 'package:uuid/uuid.dart';
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';

const uuid = Uuid();
enum Category {food,travel,leisure,work}

final categoryIcons = {
Category.food : Icons.dinner_dining,
Category.leisure : Icons.movie ,
Category.travel : Icons.flight_takeoff_outlined ,
Category.work : Icons.work
};

final dateFormatter = DateFormat.yMd() ;
class Expense {
  Expense({
     required this.amount,
    required this.date,
    required this.title,
    required this.category
 }):id = uuid.v4();
  final String  id ;
  final String title ;
  final double amount ;
  final DateTime date ;
  final Category category ;


get formattedDate {
  return dateFormatter.format(date) ;
}

}

class ExpenseBucket {
  const  ExpenseBucket({required this.expenseList,required this.category });
  
  ExpenseBucket.ofCategoryI(List<Expense> allExpenses,this.category) 
  : expenseList = allExpenses.where((expense) => expense.category== category).toList();

  final Category category ;
  final List<Expense> expenseList ;

  double get totalSum{
    double  sum =0;
    for(final expenses in expenseList){
     sum += expenses.amount ;
    }
return sum ;
  }
}