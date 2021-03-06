 
import 'package:flutter/material.dart';
import '../models/transaction.dart';
import "package:intl/intl.dart";


class TransactionList extends StatelessWidget {

  final List<Transaction> transactions;
  final Function deleteTx;

  TransactionList(this.transactions,this.deleteTx);
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 400,
      child:transactions.isEmpty ? 
      
      LayoutBuilder(builder: ((context, constraints) {
        
        return Column(
     children:<Widget> [
       Text("No transactions added yet!",style: Theme.of(context).textTheme.headline6,),
       SizedBox(height:20,),
       Container(height:constraints.maxHeight * 0.6, child:  Image.asset("assets/images/waiting.png"
       ,fit: BoxFit.cover,),)
     ],
      );
      })) :
      
       ListView.builder(itemBuilder:(ctx,index){
            return  Card(
              elevation: 5,
          margin: EdgeInsets.symmetric(vertical: 8,horizontal: 5),
              child: ListTile(
              leading: CircleAvatar(radius: 30,child:Padding(padding: EdgeInsets.all(6), child:FittedBox(child:Text('\$${transactions[index].amount}'),))),
            title: Text(transactions[index].title,   style: Theme.of(context).textTheme.headline6,),
            subtitle: Text(DateFormat.yMMMd().format(transactions[index].date)),
            trailing:MediaQuery.of(context).size.width>360
             ? FlatButton.icon(
               color: Theme.of(context).errorColor,
               icon: Icon(Icons.delete),
               textColor: Colors.white,
               label: Text("Delete"),onPressed: (){
                deleteTx(transactions[index].id);
            }): IconButton(
              icon:Icon(Icons.delete),
              color:Theme.of(context).errorColor,
              onPressed: (){
                deleteTx(transactions[index].id);
              },
              ),
            

            ),
            );
       },
        itemCount: transactions.length
     
      ));
    
  }
}

// ListView.builder in normal ListView den fark?? builder listenin ekran??n g??r??nen k??sm??na kadar ??al????t??r??r



//  Card(
        
//             child: Row(children:<Widget> [
//               Container(
//                 child: Text("\$${transactions[index].amount.toStringAsFixed(2)}",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20,color:Theme.of(context).primaryColor)),
//                 margin:EdgeInsets.symmetric(vertical: 10,horizontal: 15),
//                 decoration: BoxDecoration(border: Border.all(color:Theme.of(context).primaryColor,width: 2)),
//                 padding: EdgeInsets.all(10),
                
//               ),
//               Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children:<Widget> [
//                   Text(transactions[index].title,style:Theme.of(context).textTheme.headline6),
//                   Text(DateFormat("yyyy-MM-dd").format(transactions[index].date),style:  TextStyle(color: Colors.grey),),
//                 ],
//               )
//             ],)
//           );