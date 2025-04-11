import 'package:flutter/material.dart';
import '../widgets/checkout_address_card.dart';
import '../widgets/checkout_payment_card.dart';
import '../widgets/checkout_summary_card.dart';
import '../screens/order_confirmation_screen.dart';

class CheckoutScreen extends StatefulWidget {
  const CheckoutScreen({super.key});

  @override
  State<CheckoutScreen> createState() => _CheckoutScreenState();
}

class _CheckoutScreenState extends State<CheckoutScreen> {
  int _currentStep = 0;
  final _steps = ['العنوان', 'الدفع', 'المراجعة'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: const Text(
          'الدفع',
          style: TextStyle(color: Colors.black),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Column(
        children: [
          _buildStepper(),
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  _buildCurrentStepContent(),
                  const SizedBox(height: 100),
                ],
              ),
            ),
          ),
        ],
      ),
      bottomSheet: _buildBottomBar(),
    );
  }

  Widget _buildStepper() {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 16),
      color: Colors.white,
      child: Row(
        children: List.generate(
          _steps.length * 2 - 1,
          (index) {
            if (index.isEven) {
              final stepIndex = index ~/ 2;
              final isActive = stepIndex <= _currentStep;
              final isCurrentStep = stepIndex == _currentStep;
              
              return Expanded(
                child: Column(
                  children: [
                    Container(
                      width: 30,
                      height: 30,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: isActive ? Colors.blue : Colors.grey[300],
                      ),
                      child: Center(
                        child: isActive
                            ? const Icon(
                                Icons.check,
                                color: Colors.white,
                                size: 16,
                              )
                            : Text(
                                '${stepIndex + 1}',
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      _steps[stepIndex],
                      style: TextStyle(
                        color: isCurrentStep ? Colors.blue : Colors.grey[600],
                        fontWeight: isCurrentStep ? FontWeight.bold : FontWeight.normal,
                      ),
                    ),
                  ],
                ),
              );
            } else {
              final isActive = index ~/ 2 < _currentStep;
              return Expanded(
                child: Container(
                  height: 2,
                  color: isActive ? Colors.blue : Colors.grey[300],
                ),
              );
            }
          },
        ),
      ),
    );
  }

  Widget _buildCurrentStepContent() {
    switch (_currentStep) {
      case 0:
        return const CheckoutAddressCard();
      case 1:
        return const CheckoutPaymentCard();
      case 2:
        return const CheckoutSummaryCard();
      default:
        return const SizedBox.shrink();
    }
  }

  Widget _buildBottomBar() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, -5),
          ),
        ],
      ),
      child: Row(
        children: [
          if (_currentStep > 0)
            Expanded(
              child: OutlinedButton(
                onPressed: () {
                  setState(() {
                    _currentStep--;
                  });
                },
                style: OutlinedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  side: const BorderSide(color: Colors.blue),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: const Text('السابق'),
              ),
            ),
          if (_currentStep > 0) const SizedBox(width: 16),
          Expanded(
            child: ElevatedButton(
              onPressed: () {
                if (_currentStep < _steps.length - 1) {
                  setState(() {
                    _currentStep++;
                  });
                } else {
                  // إكمال الطلب
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => const OrderConfirmationScreen()),
                  );
                }
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              child: Text(
                _currentStep < _steps.length - 1 ? 'التالي' : 'إتمام الطلب',
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

