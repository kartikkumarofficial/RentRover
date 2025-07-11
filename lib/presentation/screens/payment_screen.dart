import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../controllers/payment_controller.dart';


class PaymentScreen extends StatelessWidget {
  PaymentScreen({super.key});
  final PaymentController paymentController = Get.put(PaymentController());
  final TextEditingController amountController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Make Payment")),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Enter Amount",
              style: TextStyle(fontSize: 18),
            ),
            const SizedBox(height: 10),
            TextField(
              controller: amountController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                hintText: "Amount in INR",
              ),
            ),
            const SizedBox(height: 20),
            Center(
              child: ElevatedButton(
                onPressed: () {
                  if (amountController.text.isEmpty) {
                    Get.snackbar("Error", "Please enter an amount.");
                  } else {
                    int amount = int.parse(amountController.text);
                    paymentController.openCheckout(amount);
                  }
                },
                child: const Text("Pay Now"),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
