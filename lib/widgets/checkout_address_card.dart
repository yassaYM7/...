import 'package:flutter/material.dart';

class CheckoutAddressCard extends StatefulWidget {
  const CheckoutAddressCard({super.key});

  @override
  State<CheckoutAddressCard> createState() => _CheckoutAddressCardState();
}

class _CheckoutAddressCardState extends State<CheckoutAddressCard> {
  final _formKey = GlobalKey<FormState>();
  int _selectedAddressIndex = 0;
  
  final List<Map<String, String>> _savedAddresses = [
    {
      'name': 'أحمد محمد',
      'street': 'شارع الملك فهد',
      'city': 'الرياض',
      'state': 'الرياض',
      'zip': '12345',
      'country': 'المملكة العربية السعودية',
      'phone': '+966 50 123 4567',
    },
    {
      'name': 'محمد أحمد',
      'street': 'شارع التحلية',
      'city': 'جدة',
      'state': 'مكة المكرمة',
      'zip': '23456',
      'country': 'المملكة العربية السعودية',
      'phone': '+966 55 987 6543',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'عنوان الشحن',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 16),
        
        // العناوين المحفوظة
        ...List.generate(
          _savedAddresses.length,
          (index) => _buildAddressCard(index),
        ),
        
        // إضافة عنوان جديد
        const SizedBox(height: 16),
        OutlinedButton.icon(
          onPressed: () {
            _showAddAddressDialog();
          },
          icon: const Icon(Icons.add),
          label: const Text('إضافة عنوان جديد'),
          style: OutlinedButton.styleFrom(
            padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildAddressCard(int index) {
    final address = _savedAddresses[index];
    final isSelected = _selectedAddressIndex == index;
    
    return GestureDetector(
      onTap: () {
        setState(() {
          _selectedAddressIndex = index;
        });
      },
      child: Container(
        margin: const EdgeInsets.only(bottom: 12),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: isSelected ? Colors.blue : Colors.grey.shade300,
            width: 2,
          ),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Radio(
              value: index,
              groupValue: _selectedAddressIndex,
              onChanged: (value) {
                setState(() {
                  _selectedAddressIndex = value as int;
                });
              },
              activeColor: Colors.blue,
            ),
            const SizedBox(width: 8),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    address['name']!,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(address['street']!),
                  Text('${address['city']}, ${address['state']} ${address['zip']}'),
                  Text(address['country']!),
                  const SizedBox(height: 4),
                  Text(address['phone']!),
                ],
              ),
            ),
            Column(
              children: [
                IconButton(
                  icon: const Icon(Icons.edit, size: 20),
                  onPressed: () {
                    // تحرير العنوان
                  },
                ),
                IconButton(
                  icon: const Icon(Icons.delete, size: 20),
                  onPressed: () {
                    // حذف العنوان
                    setState(() {
                      _savedAddresses.removeAt(index);
                      if (_selectedAddressIndex >= _savedAddresses.length) {
                        _selectedAddressIndex = _savedAddresses.length - 1;
                      }
                    });
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  void _showAddAddressDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('إضافة عنوان جديد'),
        content: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextFormField(
                  decoration: const InputDecoration(
                    labelText: 'الاسم الكامل',
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'الرجاء إدخال الاسم';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 12),
                TextFormField(
                  decoration: const InputDecoration(
                    labelText: 'العنوان',
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'الرجاء إدخال العنوان';
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
                          labelText: 'المدينة',
                          border: OutlineInputBorder(),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'الرجاء إدخال المدينة';
                          }
                          return null;
                        },
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: TextFormField(
                        decoration: const InputDecoration(
                          labelText: 'الرمز البريدي',
                          border: OutlineInputBorder(),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'الرجاء إدخال الرمز البريدي';
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
                    labelText: 'رقم الهاتف',
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'الرجاء إدخال رقم الهاتف';
                    }
                    return null;
                  },
                ),
              ],
            ),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('إلغاء'),
          ),
          ElevatedButton(
            onPressed: () {
              if (_formKey.currentState!.validate()) {
                // حفظ العنوان الجديد
                Navigator.pop(context);
              }
            },
            child: const Text('حفظ'),
          ),
        ],
      ),
    );
  }
}

