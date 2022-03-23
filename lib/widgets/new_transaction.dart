import "dart:io";
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import "package:flutter/cupertino.dart";
import 'package:real_mobile/widgets/adaptiveButton.dart';
import './adaptiveButton.dart';
class NewTransaction extends StatefulWidget {
  final Function addTx;

  NewTransaction(this.addTx);

  @override
  _NewTransactionState createState() => _NewTransactionState();
}

class _NewTransactionState extends State<NewTransaction> {
  final titleController = TextEditingController();

  final amountController = TextEditingController();
  DateTime _selectedDate;
  void _presentDatePicker(){
    showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2019),
      lastDate: DateTime.now()
    ).then((value){
      if(value==null){
        return;
      }
     setState(() {
       
        _selectedDate=value;
     });
    });
  }

  void _submitData() {
    if(amountController.text.isEmpty){
      return;
    }
    final enteredTitle = titleController.text;
    final enteredAmount = double.parse(amountController.text);

    if (enteredTitle.isEmpty || enteredAmount <= 0  || _selectedDate==null  ) {
      return;
    }

    widget.addTx(
      enteredTitle,
      enteredAmount,
      _selectedDate
    );
   //widget ve context extends State sayesinde geliyor
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(child: Card(
      elevation: 5,
      child: Container(
        padding: EdgeInsets.only(top:10,left:10,right:10,bottom:MediaQuery.of(context).viewInsets.bottom+10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: <Widget>[
 
            TextField(
              decoration: InputDecoration(labelText: 'Title'),
              controller: titleController,
              onSubmitted: (_) => _submitData(),
              // onChanged: (val) {
              //   titleInput = val;
              // },
            ),
            TextField(
              decoration: InputDecoration(labelText: 'Amount'),
              controller: amountController,
              keyboardType: TextInputType.number,
              onSubmitted: (_) => _submitData(),
              // onChanged: (val) => amountInput = val,
            ),
           Container(
             height: 70,
             child:  Row(
              children: <Widget>[
              Expanded(child:   Text(_selectedDate==null 
                ? "No chosen date!"
                :'Picked Date: ${DateFormat.yMd().format(_selectedDate)}')),
              AdaptiveFlatButton("Choose Date", _presentDatePicker)
              ],
            ),
           ),
            RaisedButton(
              child: Text('Add Transaction'),
            color: Theme.of(context).primaryColor,
              onPressed: _submitData,
              textColor: Theme.of(context).textTheme.button.color
            ),
          ],
        ),
      ),
    ));
  }
}
