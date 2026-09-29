import 'package:flutter/material.dart';
import 'package:site_bmr_transport/services/firebase/firebase.dart';
import 'package:site_bmr_transport/services/hive/hiveBoxe.dart';
import 'package:site_bmr_transport/services/hive/hive_database.dart';

class PaymentCancelPage extends StatelessWidget {
  const PaymentCancelPage({super.key});

  @override
  Widget build(BuildContext context) {
    MyCart _cart = ActivitiesBox.cartBox.get("current");
    FireServices.addCommande(
      MyCart(
        id: _cart.id,
        commandeDate: _cart.commandeDate,
        userId: _cart.userId,
        order: _cart.order,
        description: _cart.description,
        totalPrice: _cart.totalPrice,
        discount: _cart.discount,
        commission: _cart.commission,
        payWay:
            _cart.payWay +
            [
              PayWay(
                amount: _cart.totalPrice,
                date: DateTime.now(),
                type: "stripe/cancel",
                id: _cart.payWay.isNotEmpty ? _cart.payWay.last.id : "",
              ),
            ],
      ),
    );
    return Scaffold(
      appBar: AppBar(
        title: const Text('Payment Cancelled'),
        backgroundColor: Colors.orange,
        foregroundColor: Colors.white,
      ),
      body: Center(
        child: Container(
          constraints: const BoxConstraints(maxWidth: 600),
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.cancel, color: Colors.orange, size: 100),
              const SizedBox(height: 24),
              Text(
                'Payment Cancelled',
                style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                  color: Colors.orange,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 16),
              Text(
                'Your payment was cancelled. No charges have been made to your account.',
                style: Theme.of(context).textTheme.bodyLarge,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 32),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  OutlinedButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: const Text('Try Again'),
                  ),
                  const SizedBox(width: 16),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.of(context)
                          .pushNamedAndRemoveUntil('/', (route) => false);
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.orange,
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(
                        horizontal: 32,
                        vertical: 16,
                      ),
                    ),
                    child: const Text('Back to Home'),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
