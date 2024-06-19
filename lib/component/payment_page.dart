import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:apb/models/cart_item.dart'; // Import your CartItem model
import 'package:provider/provider.dart';
import 'package:apb/models/restaurant.dart'; // Import your Restaurant model
import 'receipt.dart'; // Import the ReceiptPage

class PaymentPage extends StatefulWidget {
  @override
  _PaymentPageState createState() => _PaymentPageState();
}

class _PaymentPageState extends State<PaymentPage> {
  final _cardNumberController = TextEditingController();
  final _expiryDateController = TextEditingController();
  final _cvvController = TextEditingController();
  final _cardHolderController = TextEditingController();

  String _displayCardNumber = '**** **** **** ****';
  String _displayExpiryDate = 'MM/YY';

  @override
  void initState() {
    super.initState();
    _cardNumberController.addListener(_updateCardNumber);
    _expiryDateController.addListener(_updateExpiryDate);
  }

  @override
  void dispose() {
    _cardNumberController.dispose();
    _expiryDateController.dispose();
    _cvvController.dispose();
    _cardHolderController.dispose();
    super.dispose();
  }

  void _updateCardNumber() {
    setState(() {
      final text = _cardNumberController.text;
      if (text.isEmpty) {
        _displayCardNumber = '**** **** **** ****';
      } else {
        final buffer = StringBuffer();
        buffer.write(text.substring(0, 4));
        buffer.write(' ');
        buffer.write('**** **** ');
        buffer.write(text.substring(text.length - 4));
        _displayCardNumber = buffer.toString();
      }
    });
  }

  void _updateExpiryDate() {
    setState(() {
      _displayExpiryDate = _expiryDateController.text.isEmpty
          ? 'MM/YY'
          : _expiryDateController.text;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Checkout'),
        backgroundColor: Colors.grey[200],
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Card(
              elevation: 4,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8.0),
              ),
              child: Container(
                padding: EdgeInsets.all(16.0),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8.0),
                  color: Colors.blue,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      _displayCardNumber,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18.0,
                      ),
                    ),
                    SizedBox(height: 10.0),
                    Text(
                      'VALID THRU $_displayExpiryDate',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 14.0,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 20.0),
            TextField(
              controller: _cardNumberController,
              decoration: InputDecoration(
                labelText: 'Card Number',
                border: OutlineInputBorder(),
              ),
              keyboardType: TextInputType.number,
              inputFormatters: [
                FilteringTextInputFormatter.digitsOnly,
                LengthLimitingTextInputFormatter(16),
                CardNumberInputFormatter()
              ],
            ),
            SizedBox(height: 20.0),
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _expiryDateController,
                    decoration: InputDecoration(
                      labelText: 'Expiry Date',
                      border: OutlineInputBorder(),
                    ),
                    keyboardType: TextInputType.datetime,
                    inputFormatters: [
                      FilteringTextInputFormatter.digitsOnly,
                      LengthLimitingTextInputFormatter(4),
                      ExpiryDateInputFormatter()
                    ],
                  ),
                ),
                SizedBox(width: 10.0),
                Expanded(
                  child: TextField(
                    controller: _cvvController,
                    decoration: InputDecoration(
                      labelText: 'CVV',
                      border: OutlineInputBorder(),
                    ),
                    keyboardType: TextInputType.number,
                    inputFormatters: [
                      FilteringTextInputFormatter.digitsOnly,
                      LengthLimitingTextInputFormatter(3),
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(height: 20.0),
            TextField(
              controller: _cardHolderController,
              decoration: InputDecoration(
                labelText: 'Card Holder',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 20.0),
            Center(
              child: ElevatedButton(
                onPressed: () {
                  // Add your payment processing logic here
                  // After payment processing, navigate to the ReceiptPage
                  final restaurant = Provider.of<Restaurant>(context, listen: false);
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ReceiptPage(
                        dateTime: DateTime.now(),
                        items: restaurant.cart,
                      ),
                    ),
                  );
                },
                child: Text('Pay now'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class CardNumberInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(TextEditingValue oldValue, TextEditingValue newValue) {
    final text = newValue.text;
    if (text.length <= 4) {
      return newValue;
    }
    final buffer = StringBuffer();
    for (int i = 0; i < text.length; i++) {
      buffer.write(text[i]);
      final nonZeroIndex = i + 1;
      if (nonZeroIndex % 4 == 0 && nonZeroIndex != text.length) {
        buffer.write(' ');
      }
    }
    final string = buffer.toString();
    return newValue.copyWith(
      text: string,
      selection: TextSelection.collapsed(offset: string.length),
    );
  }
}

class ExpiryDateInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(TextEditingValue oldValue, TextEditingValue newValue) {
    var text = newValue.text;
    if (text.length == 2 && !text.contains('/')) {
      text = text + '/';
    } else if (text.length == 2 && oldValue.text.contains('/')) {
      text = text.substring(0, 1);
    } else if (text.length > 2 && text[2] != '/') {
      text = text.substring(0, 2) + '/' + text.substring(2);
    }
    return newValue.copyWith(
      text: text,
      selection: TextSelection.collapsed(offset: text.length),
    );
  }
}
