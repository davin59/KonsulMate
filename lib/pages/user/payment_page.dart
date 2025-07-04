import 'package:flutter/material.dart';

class PaymentPage extends StatefulWidget {
  final String orderId;
  final int totalAmount;

  const PaymentPage({
    super.key,
    required this.orderId,
    required this.totalAmount,
  });

  @override
  State<PaymentPage> createState() => _PaymentPageState();
}

class _PaymentPageState extends State<PaymentPage> {
  @override
  void initState() {
    super.initState();
    debugPrint('Ini adalah halaman pembayaran untuk order: ${widget.orderId}');
    debugPrint('Jumlah total: Rp${widget.totalAmount}');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Pembayaran'),
        backgroundColor: const Color(0xFF80C9FF),
        foregroundColor: Colors.white,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(
              Icons.payment,
              size: 80,
              color: Color(0xFF80C9FF),
            ),
            const SizedBox(height: 24),
            const Text(
              'Ini adalah halaman pembayaran',
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 12),
            Text(
              'Order ID: ${widget.orderId}',
              style: const TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 8),
            Text(
              'Total: Rp${widget.totalAmount}',
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Color(0xFF80C9FF),
              ),
            ),
          ],
        ),
      ),
    );
  }
}