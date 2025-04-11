import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/cart_provider.dart';

class CheckoutSummaryCard extends StatelessWidget {
  const CheckoutSummaryCard({super.key});

  @override
  Widget build(BuildContext context) {
    final cartProvider = Provider.of<CartProvider>(context);
    final cartItems = cartProvider.items.values.toList();
    
    final subtotal = cartProvider.totalAmount;
    final shipping = 0.0; // Free shipping
    final tax = subtotal * 0.05; // 5% tax
    final total = subtotal + shipping + tax;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Order Summary',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 16),
        
        // Display Cart Items
        _buildSectionCard(
          title: 'Cart Items',
          content: Column(
            children: cartItems.map((item) => ListTile(
              title: Text(item.name), // Updated from 'title' to 'name'
              subtitle: Text('Quantity: ${item.quantity}'),
              trailing: Text('\$${item.price.toStringAsFixed(2)}'),
            )).toList(),
          ),
        ),
        
        // Shipping Information
        _buildSectionCard(
          title: 'Shipping Information',
          content: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Ahmed Mohamed',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 4),
              const Text('King Fahd Street'),
              const Text('Riyadh, Riyadh 12345'),
              const Text('Saudi Arabia'),
              const SizedBox(height: 4),
              const Text('+966 50 123 4567'),
              const SizedBox(height: 8),
              Row(
                children: [
                  const Icon(Icons.local_shipping_outlined, size: 16),
                  const SizedBox(width: 4),
                  Text(
                    'Standard Delivery (3-5 business days)',
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.grey[600],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        
        // Payment Method
        _buildSectionCard(
          title: 'Payment Method',
          content: Row(
            children: [
              const Icon(Icons.credit_card),
              const SizedBox(width: 12),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Credit Card',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  Text(
                    'Visa ****1234',
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.grey[600],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        
        // Total Amount
        _buildSectionCard(
          title: 'Total Amount',
          content: Text(
            '\$${total.toStringAsFixed(2)}',
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
          ),
        ),
      ],
    );
  }

  Widget _buildSectionCard({required String title, required Widget content}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Card(
        elevation: 2,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),
              content,
            ],
          ),
        ),
      ),
    );
  }
}
