import 'package:flutter/material.dart';
import 'package:site_bmr_transport/services/firebase/firebase.dart';
import 'package:site_bmr_transport/services/hive/hiveBoxe.dart';
import 'package:site_bmr_transport/services/hive/hive_database.dart';

class PaymentSuccessPage extends StatelessWidget {
  const PaymentSuccessPage({super.key});

  @override
  Widget build(BuildContext context) {
    ActivitiesBox.orderBox.clear();
    MyCart cart = ActivitiesBox.cartBox.get("current");
    FireServices.addCommande(
      MyCart(
        id: cart.id,
        commandeDate: cart.commandeDate,
        userId: cart.userId,
        order: cart.order,
        description: cart.description,
        totalPrice: cart.totalPrice,
        discount: cart.discount,
        commission: cart.commission,
        payWay:
            cart.payWay +
            [
              PayWay(
                amount: cart.totalPrice,
                date: DateTime.now(),
                type: "stripe/success",
                id: cart.payWay.isNotEmpty ? cart.payWay.last.id : "",
              ),
            ],
      ),
    );
    return Scaffold(
      appBar: AppBar(
        title: const Text('Payment Validé'),
        backgroundColor: Colors.green,
        foregroundColor: Colors.white,
      ),
      body: Center(
        child: Container(
          constraints: const BoxConstraints(maxWidth: 600),
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.check_circle, color: Colors.green, size: 100),
              const SizedBox(height: 24),
              Text(
                'Paiement Validé!',
                style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                  color: Colors.green,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 16),
              Text(
                'Merci pour votre achat. Votre paiement a été traité avec succès.',
                style: Theme.of(context).textTheme.bodyLarge,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 32),
              ElevatedButton(
                onPressed: () {
                  Navigator.of(context)
                      .pushNamedAndRemoveUntil('/', (route) => false);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green,
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
        ),
      ),
    );
  }
}
