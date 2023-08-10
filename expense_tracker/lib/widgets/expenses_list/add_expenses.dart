import 'package:expense_tracker/models/expense.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class AddExpenses extends StatefulWidget {
  const AddExpenses({super.key, required this.addToList});
  final void Function(Expense expense) addToList;

  @override
  State<AddExpenses> createState() {
    return _AddExpenseState();
  }
}

class _AddExpenseState extends State<AddExpenses> {
  final _titleController = TextEditingController();
  final _amountController = TextEditingController();
  final dateFormatter = DateFormat.yMd();
  DateTime? pickedDate;
  Category _selectedInput = Category.leisure;

  @override
  void dispose() {
    _titleController.dispose();
    _amountController.dispose();
    super.dispose();
  }

  void selectDate() async {
    final now = DateTime.now();
    final firstDate = DateTime(now.year - 1, now.month, now.day);
    final selectedDate = await showDatePicker(
        context: context,
        initialDate: now,
        firstDate: firstDate,
        lastDate: now);
    setState(() {
      pickedDate = selectedDate;
    });
  }

  void _saveExpense() {
    final enteredNumber = double.tryParse(_amountController.text);
    final isValidEnteredNumber = enteredNumber == null || enteredNumber <= 0;
    if (_titleController.text.trim().isEmpty ||
        pickedDate == null ||
        isValidEnteredNumber) {
      showDialog(
          context: context,
          builder: (ctx) => AlertDialog(
                title: Text('invalid input'.toUpperCase()),
                actions: [
                  const Text(
                      'plz make sure you enered a valid amound,title and date'),
                  TextButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: const Text('okay')),
                ],
              ));
    }
    widget.addToList(Expense(
        amount: enteredNumber!,
        date: pickedDate!,
        title: _titleController.text,
        category: _selectedInput));
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    final keyBoardHeight = MediaQuery.of(context).viewInsets.bottom;
    return LayoutBuilder(builder: (ctx, constraints) {
      final width = constraints.maxWidth;
      return SizedBox(
        height: double.infinity,
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.fromLTRB(16, 50, 16, keyBoardHeight + 16),
            child: Column(
              children: [
                if (width > 600)
                  Row(children: [
                    Expanded(
                      child: TextField(
                        style: const TextStyle(color: Colors.black),
                        controller: _titleController,
                        maxLength: 50,
                        decoration: const InputDecoration(
                          label: Text(
                            'Title',
                            style: TextStyle(
                              fontSize: 18,
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 50,
                    ),
                    Expanded(
                      child: TextField(
                          style: const TextStyle(color: Colors.black),
                          controller: _amountController,
                          keyboardType: TextInputType.number,
                          maxLength: 10,
                          decoration: const InputDecoration(
                            prefixText: '\$ ',
                            label: Text('amount'),
                          )),
                    )
                  ])
                else
                  TextField(
                    style: const TextStyle(color: Colors.black),
                    controller: _titleController,
                    maxLength: 50,
                    decoration: const InputDecoration(
                      label: Text(
                        'Title',
                        style: TextStyle(
                          fontSize: 18,
                        ),
                      ),
                    ),
                  ),
                if (width >= 600)
                  Row(
                    children: [
                      Expanded(
                        child: DropdownButton(
                            value: _selectedInput,
                            items: Category.values
                                .map(
                                  (category) => DropdownMenuItem(
                                    value: category,
                                    child: Text(
                                      category.name.toUpperCase(),
                                      style:
                                          const TextStyle(color: Colors.black),
                                    ),
                                  ),
                                )
                                .toList(),
                            onChanged: (value) {
                              if (value == null) {
                                return;
                              }
                              setState(() {
                                _selectedInput = value;
                              });
                            }),
                      ),
                     const Spacer(),
                     Expanded(
                       child: Row(
                         mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                            Expanded(
                              child: Text(
                                pickedDate == null
                                    ? 'no date selected'
                                    : dateFormatter.format(pickedDate!),
                                style: const TextStyle(color: Colors.black),
                              ),
                            ),
                            Expanded(
                              child: IconButton(
                                  onPressed: selectDate,
                                  icon: const Icon(Icons.calendar_month)),
                            )
                                         ],
                       ),
                     ),
                     
                    ]   
                  )
                else
                  Row(children: [
                    Expanded(
                      child: TextField(
                        style: const TextStyle(color: Colors.black),
                        controller: _amountController,
                        keyboardType: TextInputType.number,
                        maxLength: 10,
                        decoration: const InputDecoration(
                          prefixText: '\$ ',
                          label: Text('amount'),
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 30,
                    ),
                    Expanded(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            pickedDate == null
                                ? 'no date selected'
                                : dateFormatter.format(pickedDate!),
                            style: const TextStyle(color: Colors.black),
                          ),
                          Expanded(
                            child: IconButton(
                                onPressed: selectDate,
                                icon: const Icon(Icons.calendar_month)),
                          )
                        ],
                      ),
                    ),
                  ]),
                const SizedBox(
                  height: 16,
                ),
                if (width >= 600)
                  Row(
                    children: [
                      const Spacer(),
                      ElevatedButton(
                          onPressed: _saveExpense, child: const Text('save')),
                      TextButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: const Text('cancle'))
                    ],
                  )
                else
                  Row(
                    children: [
                      DropdownButton(
                          value: _selectedInput,
                          items: Category.values
                              .map(
                                (category) => DropdownMenuItem(
                                  value: category,
                                  child: Text(
                                    category.name.toUpperCase(),
                                    style: const TextStyle(color: Colors.black),
                                  ),
                                ),
                              )
                              .toList(),
                          onChanged: (value) {
                            if (value == null) {
                              return;
                            }
                            setState(() {
                              _selectedInput = value;
                            });
                          }),
                      const Spacer(),
                      ElevatedButton(
                          onPressed: _saveExpense, child: const Text('save')),
                      TextButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: const Text('cancle'))
                    ],
                  )
              ],
            ),
          ),
        ),
      );
    });
  }
}
