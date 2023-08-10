import 'package:flutter/material.dart';
import 'package:expense_tracker/models/expense.dart';
import 'package:expense_tracker/chart_bar.dart';
class Chart extends StatelessWidget {
  const Chart({super.key, required this.expenses});
  final List<Expense> expenses;

  List<ExpenseBucket> get buckets {

    return [
      ExpenseBucket.ofCategoryI(expenses, Category.food),
      ExpenseBucket.ofCategoryI( expenses,  Category.leisure),
      ExpenseBucket.ofCategoryI( expenses,  Category.travel),
      ExpenseBucket.ofCategoryI( expenses,  Category.work)
    ];
  }

double get maxTotalExpense{
  double maxTotalExpense = 0;
  for(final bucket in buckets){
        if(bucket.totalSum > maxTotalExpense){
maxTotalExpense = bucket.totalSum ;
        }  
  }
  return maxTotalExpense ;
}


  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(16),
      padding: const EdgeInsets.symmetric(
        vertical: 16,
        horizontal: 8,
      ),
      width: double.infinity,
      height: 180,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        gradient: LinearGradient(
          colors: [
            Theme.of(context).colorScheme.primary,
            Theme.of(context).colorScheme.primary
          ],
          begin: Alignment.bottomCenter,
          end: Alignment.topCenter,
        ),
      ),
       child: Column(
        children: [
          Expanded(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                for (final bucket in buckets) 
                  ChartBar(
                    fill:maxTotalExpense== 0? 0 :
                    bucket.totalSum / maxTotalExpense,
                        
                  )
                 
              ],
            ),
          ),
          const SizedBox(height: 12),
          Row(
            children: buckets
                .map(
                  (bucket) => Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 4),
                      child: Icon(
                        categoryIcons[bucket.category],
                        
                      ),
                    ),
                  ),
                )
                .toList(),
          )
        ],
      ),
    );
  }
}
      
  

