import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/product_provider.dart';
import '../widgets/product_grid_item.dart';
import '../widgets/category_item.dart';
import '../screens/cart_screen.dart';
import '../screens/search_screen.dart';
import '../screens/profile_screen.dart';
import '../screens/product_detail_screen.dart';
import '../screens/category_products_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentIndex = 0;
  
  @override
  Widget build(BuildContext context) {
    final productProvider = Provider.of<ProductProvider>(context);
    final featuredProducts = productProvider.featuredProducts;
    final newProducts = productProvider.newProducts;
    final categories = productProvider.categories;
    
    return Scaffold(
      backgroundColor: Colors.white,
      body: _currentIndex == 0 ? CustomScrollView(
        slivers: [
          // شريط التطبيق
          SliverAppBar(
            floating: true,
            backgroundColor: Colors.white,
            elevation: 0,
            title: Row(
              children: [
                Image.network(
                  'https://www.apple.com/ac/globalnav/7/en_US/images/be15095f-5a20-57d0-ad14-cf4c638e223a/globalnav_apple_image__b5er5ngrzxqq_large.svg',
                  height: 20,
                ),
                const Spacer(),
                IconButton(
                  icon: const Icon(Icons.search, color: Colors.black),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const SearchScreen()),
                    );
                  },
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
          ),
          
          // عنوان قسم الفئات
          const SliverToBoxAdapter(
            child: Padding(
              padding: EdgeInsets.fromLTRB(16, 16, 16, 8),
              child: Text(
                'تصفح الفئات',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          
          // قسم الفئات المحسن
          SliverToBoxAdapter(
            child: Container(
              height: 120,
              padding: const EdgeInsets.symmetric(vertical: 8),
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.symmetric(horizontal: 16),
                itemCount: categories.length,
                itemBuilder: (context, index) {
                  return CategoryItem(
                    title: _getCategoryDisplayName(categories[index]),
                    icon: _getCategoryIcon(categories[index]),
                    onTap: () {
                      // التنقل إلى صفحة الفئة المحسنة
// تصحيح الخطأ في التنقل إلى صفحة الفئة
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => CategoryProductsScreen(
                            categoryName: categories[index],
                          ),
                        ),
                      );
                    },
                  );
                },
              ),
            ),
          ),
          
          // صورة ترويجية كبيرة
          SliverToBoxAdapter(
            child: Container(
              margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
              height: 400,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                image: const DecorationImage(
                  image: NetworkImage('https://store.storeimages.cdn-apple.com/4982/as-images.apple.com/is/store-card-40-iphone-15-pro-202309?wid=800&hei=1000&fmt=p-jpg&qlt=95&.v=1692910040844'),
                  fit: BoxFit.cover,
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.2),
                    blurRadius: 15,
                    offset: const Offset(0, 5),
                  ),
                ],
              ),
              child: Stack(
                children: [
                  // تأثير التدرج لتحسين قراءة النص
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          Colors.transparent,
                          Colors.black.withOpacity(0.7),
                        ],
                        stops: const [0.6, 1.0],
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: 20,
                    left: 20,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                          decoration: BoxDecoration(
                            color: Colors.black.withOpacity(0.8),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: const Text(
                            'جديد',
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 12,
                            ),
                          ),
                        ),
                        const SizedBox(height: 8),
                        const Text(
                          'iPhone 15 Pro',
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 28,
                            shadows: [
                              Shadow(
                                blurRadius: 10.0,
                                color: Colors.black,
                                offset: Offset(2.0, 2.0),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 4),
                        const Text(
                          'تيتانيوم. قوي. خفيف. Pro.',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            shadows: [
                              Shadow(
                                blurRadius: 8.0,
                                color: Colors.black,
                                offset: Offset(2.0, 2.0),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 12),
                        ElevatedButton(
                          onPressed: () {
                            // التنقل إلى صفحة تفاصيل المنتج
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => ProductDetailScreen(
                                  product: productProvider.findById('1'), // iPhone 15 Pro
                                ),
                              ),
                            );
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.white,
                            foregroundColor: Colors.black,
                            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                            elevation: 5,
                          ),
                          child: const Text(
                            'تسوق الآن',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          
          // عنوان المنتجات المميزة
          const SliverToBoxAdapter(
            child: Padding(
              padding: EdgeInsets.fromLTRB(16, 24, 16, 8),
              child: Text(
                'منتجات مميزة',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          
          // شبكة المنتجات المميزة
          SliverPadding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            sliver: SliverGrid(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 0.75,
                crossAxisSpacing: 16,
                mainAxisSpacing: 16,
              ),
              delegate: SliverChildBuilderDelegate(
                (context, index) {
                  return ProductGridItem(product: featuredProducts[index]);
                },
                childCount: featuredProducts.length,
              ),
            ),
          ),
          
          // عنوان المنتجات الجديدة
          const SliverToBoxAdapter(
            child: Padding(
              padding: EdgeInsets.fromLTRB(16, 32, 16, 8),
              child: Text(
                'وصل حديثًا',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          
          // قائمة المنتجات الجديدة - تم تحديثها لتكون ديناميكية
          SliverToBoxAdapter(
            child: Container(
              height: 320,
              padding: const EdgeInsets.only(left: 16),
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: newProducts.length,
                itemBuilder: (context, index) {
                  final product = newProducts[index];
                  return GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ProductDetailScreen(product: product),
                        ),
                      );
                    },
                    child: Container(
                      width: 220,
                      margin: const EdgeInsets.only(right: 16, bottom: 16),
                      decoration: BoxDecoration(
                        color: Colors.grey[100],
                        borderRadius: BorderRadius.circular(16),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.05),
                            blurRadius: 10,
                            offset: const Offset(0, 5),
                          ),
                        ],
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          ClipRRect(
                            borderRadius: const BorderRadius.only(
                              topLeft: Radius.circular(16),
                              topRight: Radius.circular(16),
                            ),
                            child: Image.network(
                              product.imageUrl,
                              height: 180,
                              width: double.infinity,
                              fit: BoxFit.cover,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(12),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  product.name,
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16,
                                  ),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  product.description,
                                  style: TextStyle(
                                    color: Colors.grey[600],
                                    fontSize: 14,
                                  ),
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                ),
                                const SizedBox(height: 8),
                                Text(
                                  '\$${product.price.toStringAsFixed(2)}',
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
          
          // مساحة إضافية في الأسفل
          const SliverToBoxAdapter(
            child: SizedBox(height: 32),
          ),
        ],
      ) : _getScreen(),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        type: BottomNavigationBarType.fixed,
        selectedItemColor: Colors.black,
        unselectedItemColor: Colors.grey,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home_outlined),
            activeIcon: Icon(Icons.home),
            label: 'الرئيسية',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.explore_outlined),
            activeIcon: Icon(Icons.explore),
            label: 'استكشاف',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_bag_outlined),
            activeIcon: Icon(Icons.shopping_bag),
            label: 'السلة',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite_outline),
            activeIcon: Icon(Icons.favorite),
            label: 'المفضلة',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person_outline),
            activeIcon: Icon(Icons.person),
            label: 'حسابي',
          ),
        ],
      ),
    );
  }

  Widget _getScreen() {
    switch (_currentIndex) {
      case 0:
        return Container(); // الشاشة الرئيسية
      case 1:
        return const Center(child: Text('استكشاف')); // شاشة الاستكشاف
      case 2:
        return const CartScreen(); // شاشة السلة
      case 3:
        return const Center(child: Text('المفضلة')); // شاشة المفضلة
      case 4:
        return const ProfileScreen(); // شاشة الملف الشخصي
      default:
        return Container();
    }
  }

  // الحصول على أيقونة مناسبة لكل فئة
  IconData _getCategoryIcon(String category) {
    switch (category) {
      case 'iPhone':
        return Icons.phone_iphone;
      case 'Smartphones':
        return Icons.smartphone;
      case 'Mac':
        return Icons.laptop_mac;
      case 'iPad':
        return Icons.tablet_mac;
      case 'Watch':
        return Icons.watch;
      case 'AirPods':
        return Icons.headphones;
      case 'TV':
        return Icons.tv;
      case 'Accessories':
        return Icons.cable;
      default:
        return Icons.devices_other;
    }
  }

  // الحصول على اسم العرض المناسب لكل فئة
  String _getCategoryDisplayName(String category) {
    switch (category) {
      case 'iPhone':
        return 'آيفون\nApple';
      case 'Smartphones':
        return 'الهواتف\nالذكية';
      case 'Mac':
        return 'ماك\nApple';
      case 'iPad':
        return 'آيباد\nApple';
      case 'Watch':
        return 'ساعات\nذكية';
      case 'AirPods':
        return 'سماعات\nلاسلكية';
      case 'TV':
        return 'تلفزيونات\nذكية';
      case 'Accessories':
        return 'إكسسوارات\nوملحقات';
      default:
        return category;
    }
  }
}