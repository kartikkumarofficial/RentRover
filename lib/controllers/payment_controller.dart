import 'package:get/get.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';


class PaymentController extends GetxController {
  late Razorpay _razorpay;

  @override
  void onInit() {
    super.onInit();
    _razorpay = Razorpay();
    _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
    _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
    _razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, _handleExternalWallet);
  }

  void openCheckout(int amount) {
    var options = {
      'key': 'YOUR_PUBLIC_KEY_HERE',
      'amount': amount * 100, // amount in paise
      'name': 'RentRover',
      'description': 'Car Rental Payment',
      'prefill': {
        'contact': '9876543210',
        'email': 'test@example.com'
      },
      'external': {
        'wallets': ['paytm']
      }
    };

    try {
      _razorpay.open(options);
    } catch (e) {
      Get.snackbar('Error', 'Unable to open payment: $e');
    }
  }

  void _handlePaymentSuccess(PaymentSuccessResponse response) {
    Get.snackbar('Payment Successful', 'Payment ID: ${response.paymentId}');
  }

  void _handlePaymentError(PaymentFailureResponse response) {
    Get.snackbar('Payment Failed', '${response.message}');
  }

  void _handleExternalWallet(ExternalWalletResponse response) {
    Get.snackbar('External Wallet Selected', '${response.walletName}');
  }

  @override
  void onClose() {
    _razorpay.clear();
    super.onClose();
  }
}
