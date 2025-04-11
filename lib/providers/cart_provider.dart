import 'package:flutter/material.dart';
import '../models/cart_item.dart';
import '../models/product.dart';

class CartProvider with ChangeNotifier {
  // قائمة عناصر السلة
  final Map<String, CartItem> _items = {};

  // الحصول على جميع عناصر السلة
  Map<String, CartItem> get items => {..._items};

  // عدد العناصر في السلة
  int get itemCount => _items.length;

  // إجمالي المبلغ في السلة
  double get totalAmount {
    var total = 0.0;
    _items.forEach((key, cartItem) {
      total += cartItem.price * cartItem.quantity;
    });
    return total;
  }

  // إضافة منتج إلى السلة
  void addItem(
    Product product,
    String selectedColor,
    String selectedSize,
    double selectedPrice,
  ) {
    // إنشاء معرف فريد للمنتج مع اللون والحجم المحددين
    final cartItemId = '${product.id}_$selectedColor}_$selectedSize';
    
    if (_items.containsKey(cartItemId)) {
      // زيادة الكمية إذا كان المنتج موجودًا بالفعل
      _items.update(
        cartItemId,
        (existingCartItem) => CartItem(
          id: existingCartItem.id,
          productId: existingCartItem.productId,
          name: existingCartItem.name,
          price: existingCartItem.price,
          quantity: existingCartItem.quantity + 1,
          imageUrl: existingCartItem.imageUrl,
          color: existingCartItem.color,
          size: existingCartItem.size,
        ),
      );
    } else {
      // إضافة منتج جديد إلى السلة
      _items.putIfAbsent(
        cartItemId,
        () => CartItem(
          id: cartItemId,
          productId: product.id,
          name: product.name,
          price: selectedPrice,
          quantity: 1,
          imageUrl: product.imageUrl,
          color: selectedColor,
          size: selectedSize,
        ),
      );
    }
    
    notifyListeners();
  }

  // تحديث كمية منتج في السلة
  void updateQuantity(String id, int quantity) {
    if (!_items.containsKey(id)) {
      return;
    }
    
    if (quantity <= 0) {
      // إزالة المنتج إذا كانت الكمية 0 أو أقل
      _items.remove(id);
    } else {
      // تحديث الكمية
      _items.update(
        id,
        (existingCartItem) => CartItem(
          id: existingCartItem.id,
          productId: existingCartItem.productId,
          name: existingCartItem.name,
          price: existingCartItem.price,
          quantity: quantity,
          imageUrl: existingCartItem.imageUrl,
          color: existingCartItem.color,
          size: existingCartItem.size,
        ),
      );
    }
    
    notifyListeners();
  }

  // إزالة منتج من السلة
  void removeItem(String id) {
    _items.remove(id);
    notifyListeners();
  }

  // تفريغ السلة
  void clear() {
    _items.clear();
    notifyListeners();
  }
}

