import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/product.dart';
import '../providers/cart_provider.dart';
import '../screens/cart_screen.dart';

class ProductDetailScreen extends StatefulWidget {
  final Product product;

  const ProductDetailScreen({super.key, required this.product});

  @override
  State<ProductDetailScreen> createState() => _ProductDetailScreenState();
}

class _ProductDetailScreenState extends State<ProductDetailScreen> {
  int _currentImageIndex = 0;
  late PageController _pageController;
  int _selectedColorIndex = 0;
  int _selectedSizeIndex = 0;
  
  @override
  void initState() {
    super.initState();
    _pageController = PageController();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final cartProvider = Provider.of<CartProvider>(context, listen: false);
    
    return Scaffold(
      backgroundColor: Colors.white,
      body: CustomScrollView(
        slivers: [
          // شريط التطبيق
          SliverAppBar(
            pinned: true,
            backgroundColor: Colors.white,
            elevation: 0,
            leading: IconButton(
              icon: const Icon(Icons.arrow_back, color: Colors.black),
              onPressed: () => Navigator.pop(context),
            ),
            actions: [
              IconButton(
                icon: const Icon(Icons.share_outlined, color: Colors.black),
                onPressed: () {},
              ),
              IconButton(
                icon: const Icon(Icons.shopping_bag_outlined, color: Colors.black),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const CartScreen()),
                  );
                },
              ),
            ],
          ),
          
          // صور المنتج
          SliverToBoxAdapter(
            child: Column(
              children: [
                SizedBox(
                  height: 400,
                  child: PageView.builder(
                    controller: _pageController,
                    itemCount: 1, // استخدام صورة واحدة فقط للتبسيط
                    onPageChanged: (index) {
                      setState(() {
                        _currentImageIndex = index;
                      });
                    },
                    itemBuilder: (context, index) {
                      return Image.network(
                        widget.product.imageUrl,
                        fit: BoxFit.contain,
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
          
          // تفاصيل المنتج
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        widget.product.name,
                        style: const TextStyle(
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      IconButton(
                        icon: const Icon(Icons.favorite_border),
                        onPressed: () {},
                      ),
                    ],
                  ),
                  Text(
                    '\$${widget.product.price.toStringAsFixed(2)}',
                    style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.w500,
                      color: Colors.black87,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      const Icon(Icons.star, color: Colors.amber, size: 18),
                      const Icon(Icons.star, color: Colors.amber, size: 18),
                      const Icon(Icons.star, color: Colors.amber, size: 18),
                      const Icon(Icons.star, color: Colors.amber, size: 18),
                      const Icon(Icons.star_half, color: Colors.amber, size: 18),
                      const SizedBox(width: 4),
                      Text(
                        '${widget.product.rating} (${widget.product.reviewCount} تقييم)',
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.grey[600],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 24),
                  const Text(
                    'اختر اللون',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 12),
                  _buildColorSelector(),
                  const SizedBox(height: 24),
                  const Text(
                    'اختر السعة',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 12),
                  _buildSizeSelector(),
                  const SizedBox(height: 24),
                  const Text(
                    'الوصف',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    widget.product.description,
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.grey[700],
                      height: 1.5,
                    ),
                  ),
                  const SizedBox(height: 24),
                  const Text(
                    'المواصفات الرئيسية',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 12),
                  ...widget.product.specifications.map((spec) => _buildSpecItem(spec)),
                  const SizedBox(height: 100),
                ],
              ),
            ),
          ),
        ],
      ),
      bottomSheet: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
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
            Expanded(
              child: ElevatedButton(
                onPressed: () {
                  // إضافة المنتج إلى السلة
                  cartProvider.addItem(
                    widget.product,
                    widget.product.colors[_selectedColorIndex].name,
                    widget.product.sizes[_selectedSizeIndex].name,
                    widget.product.sizes[_selectedSizeIndex].price,
                  );
                  
                  // عرض رسالة تأكيد
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: const Text('تمت إضافة المنتج إلى السلة'),
                      action: SnackBarAction(
                        label: 'عرض السلة',
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => const CartScreen()),
                          );
                        },
                      ),
                    ),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: const Text(
                  'إضافة إلى السلة',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            const SizedBox(width: 12),
            Container(
              decoration: BoxDecoration(
                color: Colors.grey[200],
                borderRadius: BorderRadius.circular(12),
              ),
              child: IconButton(
                onPressed: () {
                  // الشراء الآن
                },
                icon: const Icon(Icons.shopping_cart_checkout),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildColorSelector() {
    return Wrap(
      spacing: 12,
      children: List.generate(
        widget.product.colors.length,
        (index) => GestureDetector(
          onTap: () {
            setState(() {
              _selectedColorIndex = index;
            });
          },
          child: Column(
            children: [
              Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  color: Color(widget.product.colors[index].colorCode),
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: _selectedColorIndex == index
                        ? Colors.blue
                        : Colors.grey.shade300,
                    width: 2,
                  ),
                ),
              ),
              const SizedBox(height: 4),
              Text(
                widget.product.colors[index].name,
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: _selectedColorIndex == index
                      ? FontWeight.bold
                      : FontWeight.normal,
                  color: _selectedColorIndex == index
                      ? Colors.black
                      : Colors.grey[600],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSizeSelector() {
    return Column(
      children: List.generate(
        widget.product.sizes.length,
        (index) => GestureDetector(
          onTap: () {
            setState(() {
              _selectedSizeIndex = index;
            });
          },
          child: Container(
            margin: const EdgeInsets.only(bottom: 12),
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            decoration: BoxDecoration(
              border: Border.all(
                color: _selectedSizeIndex == index
                    ? Colors.blue
                    : Colors.grey.shade300,
                width: 2,
              ),
              borderRadius: BorderRadius.circular(12),
              color: _selectedSizeIndex == index
                  ? Colors.blue.withOpacity(0.05)
                  : Colors.white,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  widget.product.sizes[index].name,
                  style: TextStyle(
                    fontWeight: _selectedSizeIndex == index
                        ? FontWeight.bold
                        : FontWeight.normal,
                    fontSize: 16,
                  ),
                ),
                Text(
                  '\$${widget.product.sizes[index].price.toStringAsFixed(2)}',
                  style: TextStyle(
                    fontWeight: _selectedSizeIndex == index
                        ? FontWeight.bold
                        : FontWeight.normal,
                    fontSize: 16,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildSpecItem(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Row(
        children: [
          const Icon(Icons.check_circle, color: Colors.green, size: 20),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              text,
              style: const TextStyle(fontSize: 16),
            ),
          ),
        ],
      ),
    );
  }
}

