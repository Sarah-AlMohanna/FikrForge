import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:forgeapp/configuration/theme.dart';
import 'package:provider/provider.dart';

import '../models/IdeaModel.dart';
import '../provider/dataProvider.dart';

class PaymentSelector extends StatefulWidget {
  const PaymentSelector({super.key , required this.item});
  final Idea item ;
  @override
  _PaymentSelectorState createState() => _PaymentSelectorState();
}

class _PaymentSelectorState extends State<PaymentSelector> {
  int? selectedAmount; // Holds the selected amount
  final TextEditingController _otherAmountController = TextEditingController();

  void _selectAmount(int amount) {
    setState(() {
      selectedAmount = amount;
      if (amount != 0) _otherAmountController.clear(); // Clear text field if not "Other"
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Expanded(child: _amountBox(1000)),
            SizedBox(width: size_W(2),),
            Expanded(child: _amountBox(2500)),
            SizedBox(width: size_W(2),),
            Expanded(child: _amountBox(5000)),
            SizedBox(width: size_W(2),),
            Expanded(child: _amountBox(0)),
          ],
        ),
        if (selectedAmount == 0) // Show text field if "Other" is selected
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 16.0),
            child: TextField(
              controller: _otherAmountController,
              decoration: InputDecoration(labelText: 'Enter amount'),
              keyboardType: TextInputType.number,
            ),
          ),
        Padding(
          padding: const EdgeInsets.all(20.0),
          child: ElevatedButton(
            onPressed: () async {
              final amountToPay = selectedAmount == 0
                  ? int.tryParse(_otherAmountController.text)
                  : selectedAmount;
              EasyLoading.show();
              print("dddd_data ${widget.item.userId}");
              await Provider.of<DataProvider>(context, listen: false).sendRequestToInvestIdea(widget.item , context , amountToPay??0);
              EasyLoading.showSuccess("Thanks for send request ,idea owner will replay to you soon") ;
              Navigator.pushNamed(context, '/homePageInvestor');
            },
            child: Text('Send request to invest' , style: ourTextStyle(fontSize: 16 , fontWeight: FontWeight.bold),),
          ),
        ),
      ],
    );
  }

  Widget _amountBox(int amount) {
    bool isSelected = selectedAmount == amount;

    return GestureDetector(
      onTap: () => _selectAmount(amount),
      child: Container(
        // width: size_W(150),
        height:  size_W(25),
        decoration: BoxDecoration(
          color: isSelected ? Theme_Information.Primary_Color : Colors.grey[300],
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: Colors.black),
        ),
        child: Center(
          child: Text(
            amount == 0 ? 'Other' : '${amount}SAR',
            style: ourTextStyle(
              color: isSelected ? Colors.white : Colors.black,
              fontSize: 16,
            ),
          ),
        ),
      ),
    );
  }
}
