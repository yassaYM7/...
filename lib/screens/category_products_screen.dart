import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/product_provider.dart';
import '../widgets/product_grid_item.dart';
import '../models/product.dart';

class CategoryProductsScreen extends StatefulWidget {
  final String categoryName;

  const CategoryProductsScreen({
    Key? key,
    required this.categoryName,
  }) : super(key: key);

  @override
  State<CategoryProductsScreen> createState() => _CategoryProductsScreenState();
}

class _CategoryProductsScreenState extends State<CategoryProductsScreen> {
  String _searchQuery = '';
  String _sortOption = 'featured';
  final TextEditingController _searchController = TextEditingController();
  final FocusNode _searchFocusNode = FocusNode();
  bool _isSearching = false;

  // قاموس الترجمة للكلمات الشائعة (يمكن توسيعه)
  final Map<String, List<String>> _arabicToEnglishMap = {
    'ايفون': ['iphone', 'phone', 'smartphone'],
    'هاتف': ['phone', 'iphone', 'smartphone'],
    'ماك': ['mac', 'macbook', 'laptop'],
    'لابتوب': ['laptop', 'macbook', 'computer'],
    'حاسوب': ['computer', 'laptop', 'mac'],
    'ايباد': ['ipad', 'tablet'],
    'تابلت': ['tablet', 'ipad'],
    'ساعة': ['watch', 'apple watch'],
    'سماعة': ['airpods', 'headphones', 'earphones'],
    'تلفزيون': ['tv', 'television', 'apple tv'],
    'اكسسوارات': ['accessories', 'cable', 'charger'],
    'شاحن': ['charger', 'cable', 'accessories'],
    'برو': ['pro', 'professional'],
    'اير': ['air'],
    'ماكس': ['max', 'maximum'],
    'ميني': ['mini', 'small'],
    'جديد': ['new', 'latest'],
    'احدث': ['new', 'latest', 'newest'],
    'افضل': ['best', 'top', 'featured'],
    'رخيص': ['cheap', 'affordable', 'low price'],
    'غالي': ['expensive', 'premium', 'high price'],
    'سامسونج': ['samsung', 'galaxy'],
    'جوجل': ['google', 'pixel'],
    'شاومي': ['xiaomi', 'mi', 'redmi'],
    'اندرويد': ['android'],
  };

  @override
  void dispose() {
    _searchController.dispose();
    _searchFocusNode.dispose();
    super.dispose();
  }

  // دالة البحث المحسنة التي تدعم الترجمة من العربية للإنجليزية
  List<Product> _getFilteredProducts(ProductProvider provider) {
    final categoryProducts = provider.getProductsByCategory(widget.categoryName);
    
    if (_searchQuery.isEmpty) {
      return _sortProducts(categoryProducts);
    }

    // تحويل استعلام البحث إلى أحرف صغيرة
    final query = _searchQuery.toLowerCase();
    
    // البحث المباشر أولاً
    var results = categoryProducts.where((product) {
      return product.name.toLowerCase().contains(query) ||
             product.description.toLowerCase().contains(query);
    }).toList();

    // إذا لم نجد نتائج، نحاول الترجمة من العربية للإنجليزية
    if (results.isEmpty) {
      // تقسيم الاستعلام إلى كلمات
      final queryWords = query.split(' ');
      
      // جمع كل الترجمات المحتملة لكل كلمة
      final List<String> possibleTranslations = [];
      
      for (final word in queryWords) {
        // البحث عن ترجمات للكلمة
        for (final entry in _arabicToEnglishMap.entries) {
          if (word.contains(entry.key) || entry.key.contains(word)) {
            possibleTranslations.addAll(entry.value);
          }
        }
      }
      
      // البحث باستخدام الترجمات
      if (possibleTranslations.isNotEmpty) {
        results = categoryProducts.where((product) {
          final nameLower = product.name.toLowerCase();
          final descLower = product.description.toLowerCase();
          
          for (final translation in possibleTranslations) {
            if (nameLower.contains(translation) || descLower.contains(translation)) {
              return true;
            }
          }
          return false;
        }).toList();
      }
    }
    
    return _sortProducts(results);
  }

  // دالة الترتيب
  List<Product> _sortProducts(List<Product> products) {
    switch (_sortOption) {
      case 'featured':
        return products..sort((a, b) => b.isFeatured ? 1 : -1);
      case 'newest':
        return products..sort((a, b) => b.isNew ? 1 : -1);
      case 'price_low':
        return products..sort((a, b) => a.price.compareTo(b.price));
      case 'price_high':
        return products..sort((a, b) => b.price.compareTo(a.price));
      case 'name_asc':
        return products..sort((a, b) => a.name.compareTo(b.name));
      case 'rating':
        return products..sort((a, b) => b.rating.compareTo(a.rating));
      default:
        return products;
    }
  }

  @override
  Widget build(BuildContext context) {
    final productProvider = Provider.of<ProductProvider>(context);
    final filteredProducts = _getFilteredProducts(productProvider);
    
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: _isSearching
            ? TextField(
                controller: _searchController,
                focusNode: _searchFocusNode,
                decoration: InputDecoration(
                  hintText: 'ابحث في ${_getCategoryDisplayName(widget.categoryName)}...',
                  border: InputBorder.none,
                  hintStyle: TextStyle(color: Colors.grey[400]),
                ),
                textDirection: TextDirection.rtl, // دعم النص العربي
                onChanged: (value) {
                  setState(() {
                    _searchQuery = value;
                  });
                },
              )
            : Text(
                _getCategoryDisplayName(widget.categoryName),
                style: const TextStyle(color: Colors.black),
              ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        actions: [
          // زر البحث
          IconButton(
            icon: Icon(
              _isSearching ? Icons.close : Icons.search,
              color: Colors.black,
            ),
            onPressed: () {
              setState(() {
                if (_isSearching) {
                  _searchQuery = '';
                  _searchController.clear();
                }
                _isSearching = !_isSearching;
                if (_isSearching) {
                  _searchFocusNode.requestFocus();
                }
              });
            },
          ),
          // زر الترتيب
          PopupMenuButton<String>(
            icon: const Icon(Icons.sort, color: Colors.black),
            onSelected: (value) {
              setState(() {
                _sortOption = value;
              });
            },
            itemBuilder: (context) => [
              const PopupMenuItem(
                value: 'featured',
                child: Text('المميزة'),
              ),
              const PopupMenuItem(
                value: 'newest',
                child: Text('الأحدث'),
              ),
              const PopupMenuItem(
                value: 'price_low',
                child: Text('السعر: من الأقل للأعلى'),
              ),
              const PopupMenuItem(
                value: 'price_high',
                child: Text('السعر: من الأعلى للأقل'),
              ),
              const PopupMenuItem(
                value: 'name_asc',
                child: Text('الاسم: أ-ي'),
              ),
              const PopupMenuItem(
                value: 'rating',
                child: Text('التقييم'),
              ),
            ],
          ),
        ],
      ),
      body: Column(
        children: [
          // شريط الفلترة
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            decoration: BoxDecoration(
              color: Colors.grey[100],
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.05),
                  blurRadius: 5,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: Row(
              children: [
                Text(
                  'عرض ${filteredProducts.length} منتج',
                  style: TextStyle(
                    color: Colors.grey[700],
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const Spacer(),
                // عرض الفلتر النشط
                Row(
                  children: [
                    Icon(
                      _getSortIcon(_sortOption),
                      size: 18,
                      color: Colors.grey[700],
                    ),
                    const SizedBox(width: 4),
                    Text(
                      _getSortName(_sortOption),
                      style: TextStyle(
                        color: Colors.grey[700],
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          
          // قائمة المنتجات
          Expanded(
            child: filteredProducts.isEmpty
                ? Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.search_off,
                          size: 80,
                          color: Colors.grey[300],
                        ),
                        const SizedBox(height: 16),
                        Text(
                          _searchQuery.isEmpty
                              ? 'لا توجد منتجات في هذه الفئة'
                              : 'لا توجد نتائج لـ "$_searchQuery"',
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        if (_searchQuery.isNotEmpty)
                          Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 32,
                              vertical: 8,
                            ),
                            child: Text(
                              'حاول البحث بكلمات مختلفة أو تحقق من التهجئة',
                              style: TextStyle(
                                fontSize: 16,
                                color: Colors.grey[600],
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ),
                      ],
                    ),
                  )
                : GridView.builder(
                    padding: const EdgeInsets.all(16),
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      childAspectRatio: 0.75,
                      crossAxisSpacing: 16,
                      mainAxisSpacing: 16,
                    ),
                    itemCount: filteredProducts.length,
                    itemBuilder: (context, index) {
                      return ProductGridItem(product: filteredProducts[index]);
                    },
                  ),
          ),
        ],
      ),
    );
  }

  // الحصول على اسم الترتيب بالعربية
  String _getSortName(String sortOption) {
    switch (sortOption) {
      case 'featured':
        return 'المميزة';
      case 'newest':
        return 'الأحدث';
      case 'price_low':
        return 'السعر (الأقل)';
      case 'price_high':
        return 'السعر (الأعلى)';
      case 'name_asc':
        return 'الاسم (أ-ي)';
      case 'rating':
        return 'التقييم';
      default:
        return 'المميزة';
    }
  }

  // الحصول على أيقونة الترتيب
  IconData _getSortIcon(String sortOption) {
    switch (sortOption) {
      case 'featured':
        return Icons.star;
      case 'newest':
        return Icons.new_releases;
      case 'price_low':
        return Icons.arrow_upward;
      case 'price_high':
        return Icons.arrow_downward;
      case 'name_asc':
        return Icons.sort_by_alpha;
      case 'rating':
        return Icons.thumb_up;
      default:
        return Icons.sort;
    }
  }

  // الحصول على اسم العرض المناسب لكل فئة
  String _getCategoryDisplayName(String category) {
    switch (category) {
      case 'iPhone':
        return 'آيفون Apple';
      case 'Smartphones':
        return 'الهواتف الذكية';
      case 'Mac':
        return 'أجهزة ماك';
      case 'iPad':
        return 'آيباد Apple';
      case 'Watch':
        return 'الساعات الذكية';
      case 'AirPods':
        return 'سماعات AirPods';
      case 'TV':
        return 'أجهزة التلفزيون الذكية';
      case 'Accessories':
        return 'الإكسسوارات والملحقات';
      default:
        return category;
    }
  }
}