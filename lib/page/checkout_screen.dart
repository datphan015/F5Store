import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_doanlt/page/trangchu.dart';
import 'package:pay/pay.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class CheckoutScreen extends StatefulWidget {
  final int totalAmount;
  final int discount;
  final int finalAmount;

  CheckoutScreen({
    required this.totalAmount,
    required this.discount,
    required this.finalAmount,
  });

  @override
  _CheckoutScreenState createState() => _CheckoutScreenState();
}

class _CheckoutScreenState extends State<CheckoutScreen> {
  Map<String, dynamic> userData = {};
  String? defaultGooglePayConfigString;
  List<PaymentItem> _paymentItems = [];

  @override
  void initState() {
    super.initState();
    _fetchUserData();
    _loadGooglePayConfig();
    _paymentItems = [
      PaymentItem(
        label: 'Total',
        amount: widget.finalAmount.toString(),
        status: PaymentItemStatus.final_price,
      ),
    ];
  }

  Future<void> _fetchUserData() async {
    // Fetch user data from your API
    final response = await http.get(Uri.parse('http://your-api-url/api/getUser/1'));

    if (response.statusCode == 200) {
      setState(() {
        userData = json.decode(response.body);
      });
    } else {
      print('Failed to load user data');
    }
  }

  void _loadGooglePayConfig() async {
    defaultGooglePayConfigString = await rootBundle.loadString('assets/gpay.json');
    setState(() {});
  }

  void _showPaymentSuccessDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Thanh toán thành công'),
        content: Text('Cảm ơn bạn đã mua hàng!'),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => HomePage(token: '', userId: '',)));
            },
            child: Text('OK'),
          ),
        ],
      ),
    );
  }

  void onGooglePayResult(paymentResult) {
    _showPaymentSuccessDialog(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF6699CC),
        leading: Padding(
          padding: const EdgeInsets.fromLTRB(16, 16, 0, 0),
          child: InkWell(
            onTap: () {
              Navigator.pop(context);
            },
            splashColor: Color(0xFF6699CC),
            hoverColor: Color(0xFF6699CC),
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                shape: BoxShape.circle,
              ),
              padding: const EdgeInsets.fromLTRB(12, 8, 4, 8),
              child: Icon(Icons.arrow_back_ios, size: 20),
            ),
          ),
        ),
        title: Padding(
          padding: const EdgeInsets.only(top: 24),
          child: Center(
            child: Text(
              'Thanh toán',
              style: TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ),
        ),
        actions: <Widget>[
          Container(
            width: 52,
            height: 40,
          ),
        ],
      ),
      body: Container(
        child: Column(
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: ListView(
                  children: [
                    _buildContactInfo(),
                    _buildAddressInfo(),
                    _buildPaymentMethod(),
                  ],
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.all(16.0),
              color: Colors.white,
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Tổng tiền hàng', style: TextStyle(fontSize: 18)),
                      Text('${widget.totalAmount.toStringAsFixed(0)}đ', style: TextStyle(fontSize: 18)),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Chiết khấu', style: TextStyle(fontSize: 18)),
                      Text('-${widget.discount.toStringAsFixed(0)}đ', style: TextStyle(fontSize: 18)),
                    ],
                  ),
                  Divider(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Tổng thanh toán', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                      Text('${widget.finalAmount.toStringAsFixed(0)}đ', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                    ],
                  ),
                  SizedBox(height: 10),
                  defaultGooglePayConfigString == null
                      ? CircularProgressIndicator()
                      : GooglePayButton(
                          paymentConfiguration: PaymentConfiguration.fromJsonString(defaultGooglePayConfigString!),
                          paymentItems: _paymentItems,
                          type: GooglePayButtonType.buy,
                          margin: const EdgeInsets.only(top: 15.0),
                          onPaymentResult: onGooglePayResult,
                          loadingIndicator: const Center(
                            child: CircularProgressIndicator(),
                          ),
                        ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildContactInfo() {
    return userData.isEmpty
        ? CircularProgressIndicator()
        : Card(
            elevation: 2,
            child: ListTile(
              title: Text('Thông tin liên hệ'),
              subtitle: Text(userData['contact'] ?? 'Không có thông tin'),
              trailing: Icon(Icons.contact_phone),
            ),
          );
  }

  Widget _buildAddressInfo() {
    return userData.isEmpty
        ? CircularProgressIndicator()
        : Card(
            elevation: 2,
            child: ListTile(
              title: Text('Địa chỉ nhận hàng'),
              subtitle: Text(userData['address'] ?? 'Không có thông tin'),
              trailing: Icon(Icons.location_on),
            ),
          );
  }

  Widget _buildPaymentMethod() {
    return Card(
      elevation: 2,
      child: ListTile(
        title: Text('Phương thức thanh toán'),
        subtitle: Text('Google Pay'),
        trailing: Icon(Icons.payment),
      ),
    );
  }
}
