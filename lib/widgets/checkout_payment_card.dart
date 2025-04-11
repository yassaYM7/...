import 'package:flutter/material.dart';

class CheckoutPaymentCard extends StatefulWidget {
  const CheckoutPaymentCard({super.key});

  @override
  State<CheckoutPaymentCard> createState() => _CheckoutPaymentCardState();
}

class _CheckoutPaymentCardState extends State<CheckoutPaymentCard> {
  int _selectedPaymentMethod = 0;
  final _formKey = GlobalKey<FormState>();
  
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'طريقة الدفع',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 16),
        
        // بطاقة الائتمان
        _buildPaymentMethodCard(
          index: 0,
          title: 'بطاقة الائتمان',
          icon: Icons.credit_card,
          child: _selectedPaymentMethod == 0
              ? Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      TextFormField(
                        decoration: const InputDecoration(
                          labelText: 'رقم البطاقة',
                          border: OutlineInputBorder(),
                          hintText: 'XXXX XXXX XXXX XXXX',
                        ),
                        keyboardType: TextInputType.number,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'الرجاء إدخال رقم البطاقة';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 12),
                      Row(
                        children: [
                          Expanded(
                            child: TextFormField(
                              decoration: const InputDecoration(
                                labelText: 'تاريخ الانتهاء',
                                border: OutlineInputBorder(),
                                hintText: 'MM/YY',
                              ),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'الرجاء إدخال تاريخ الانتهاء';
                                }
                                return null;
                              },
                            ),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: TextFormField(
                              decoration: const InputDecoration(
                                labelText: 'CVV',
                                border: OutlineInputBorder(),
                                hintText: 'XXX',
                              ),
                              keyboardType: TextInputType.number,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'الرجاء إدخال رمز CVV';
                                }
                                return null;
                              },
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 12),
                      TextFormField(
                        decoration: const InputDecoration(
                          labelText: 'الاسم على البطاقة',
                          border: OutlineInputBorder(),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'الرجاء إدخال الاسم على البطاقة';
                          }
                          return null;
                        },
                      ),
                    ],
                  ),
                )
              : null,
        ),
        
        // Apple Pay
        _buildPaymentMethodCard(
          index: 1,
          title: 'Apple Pay',
          icon: Icons.apple,
          child: _selectedPaymentMethod == 1
              ? const Padding(
                  padding: EdgeInsets.symmetric(vertical: 16),
                  child: Text(
                    'سيتم توجيهك إلى Apple Pay لإكمال الدفع.',
                    style: TextStyle(fontSize: 14),
                  ),
                )
              : null,
        ),
        
        // الدفع عند الاستلام
        _buildPaymentMethodCard(
          index: 2,
          title: 'الدفع عند الاستلام',
          icon: Icons.local_shipping_outlined,
          child: _selectedPaymentMethod == 2
              ? const Padding(
                  padding: EdgeInsets.symmetric(vertical: 16),
                  child: Text(
                    'ستدفع عند استلام طلبك. يرجى التأكد من توفر المبلغ المطلوب عند التسليم.',
                    style: TextStyle(fontSize: 14),
                  ),
                )
              : null,
        ),
      ],
    );
  }

  Widget _buildPaymentMethodCard({
    required int index,
    required String title,
    required IconData icon,
    Widget? child,
  }) {
    final isSelected = _selectedPaymentMethod == index;
    
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: isSelected ? Colors.blue : Colors.grey.shade300,
          width: 2,
        ),
      ),
      child: Column(
        children: [
          InkWell(
            onTap: () {
              setState(() {
                _selectedPaymentMethod = index;
              });
            },
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Row(
                children: [
                  Radio(
                    value: index,
                    groupValue: _selectedPaymentMethod,
                    onChanged: (value) {
                      setState(() {
                        _selectedPaymentMethod = value as int;
                      });
                    },
                    activeColor: Colors.blue,
                  ),
                  const SizedBox(width: 8),
                  Icon(icon),
                  const SizedBox(width: 12),
                  Text(
                    title,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                ],
              ),
            ),
          ),
          if (child != null)
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
              child: child,
            ),
        ],
      ),
    );
  }
}

