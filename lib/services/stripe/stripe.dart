import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:site_bmr_transport/common/data.dart';
import 'package:site_bmr_transport/services/hive/hive_database.dart';

class Checkout {
  static Future<Map<String, dynamic>> createCheckoutSession({
    required List<dynamic> cart,
    required String email,
  }) async {
    try {
      final url = Uri.parse("https://api.stripe.com/v1/checkout/sessions");
      final response = await http.post(
        url,
        headers: {
          'Authorization': 'Bearer $secretKey',
          'Content-Type': 'application/x-www-form-urlencoded',
        },
        body: {
          'customer_email': email.toString(),
          for (int i = 0; i < cart.length; i++) ...{
            'line_items[$i][quantity]': '1',
            'line_items[$i][price_data][currency]': 'EUR',
            'line_items[$i][price_data][unit_amount]': (cart[i].price * 100)
                .toStringAsFixed(0),
            'line_items[$i][price_data][product_data][name]': cart[i]
                .costumerName
                .toString(),
            'line_items[$i][price_data][product_data][images][0]':
                cart[i].carImages.first,
          },
          'mode': 'payment',
          'success_url': '${Uri.base}#/success',
          'cancel_url': '${Uri.base}#/cancel',
        },
      );
      if (response.statusCode == 200) {
        print(response.request);
        return jsonDecode(response.body);
      } else {
        print(response.body);
        throw Exception("Failed to create Checkout Session");
      }
    } catch (e) {
      throw Exception("Error creating Checkout Session: $e");
    }
  }
}
