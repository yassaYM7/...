import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/product_provider.dart';
import '../widgets/product_grid_item.dart';
import '../models/product.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final _searchController = TextEditingController();
  String _searchQuery = '';
  
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
  };
  
  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  // دالة البحث المحسنة التي تدعم الترجمة من العربية للإنجليزية
  List<Product> _getSearchResults(ProductProvider provider) {
    if (_searchQuery.isEmpty) {
      return [];
    }

    // تحويل استعلام البحث إلى أحرف صغيرة
    final query = _searchQuery.toLowerCase();
    
    // البحث المباشر أولاً
    var results = provider.products.where((product) {
      return product.name.toLowerCase().contains(query) ||
             product.description.toLowerCase().contains(query) ||
             product.category.toLowerCase().contains(query);
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
        results = provider.products.where((product) {
          final nameLower = product.name.toLowerCase();
          final descLower = product.description.toLowerCase();
          final categoryLower = product.category.toLowerCase();
          
          for (final translation in possibleTranslations) {
            if (nameLower.contains(translation) || 
                descLower.contains(translation) ||
                categoryLower.contains(translation)) {
              return true;
            }
          }
          return false;
        }).toList();
      }
    }
    
    return results;
  }

  @override
  Widget build(BuildContext context) {
    final productProvider = Provider.of<ProductProvider>(context);
    final searchResults = _getSearchResults(productProvider);
    
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: TextField(
          controller: _searchController,
          decoration: InputDecoration(
            hintText: 'ابحث عن منتجات...',
            border: InputBorder.none,
            suffixIcon: _searchQuery.isNotEmpty
                ? IconButton(
                    icon: const Icon(Icons.clear),
                    onPressed: () {
                      _searchController.clear();
                      setState(() {
                        _searchQuery = '';
                      });
                    },
                  )
                : null,
          ),
          textDirection: TextDirection.rtl, // دعم النص العربي
          onChanged: (value) {
            setState(() {
              _searchQuery = value;
            });
          },
          autofocus: true,
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: _searchQuery.isEmpty
          ? _buildInitialContent()
          : _buildSearchResults(searchResults),
    );
  }

  Widget _buildInitialContent() {
    final productProvider = Provider.of<ProductProvider>(context, listen: false);
    final categories = productProvider.categories;
    
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'الفئات',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 16),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: categories.map((category) {
              return InkWell(
                onTap: () {
                  _searchController.text = category;
                  setState(() {
                    _searchQuery = category;
                  });
                },
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  decoration: BoxDecoration(
                    color: Colors.grey[200],
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(category),
                ),
              );
            }).toList(),
          ),
          const SizedBox(height: 32),
          const Text(
            'اقتراحات البحث',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 16),
          _buildSearchSuggestion('iPhone 15 Pro'),
          _buildSearchSuggestion('MacBook Air'),
          _buildSearchSuggestion('AirPods Pro'),
          _buildSearchSuggestion('Apple Watch'),
          _buildSearchSuggestion('iPad Pro'),
        ],
      ),
    );
  }

  Widget _buildSearchSuggestion(String suggestion) {
    return ListTile(
      leading: const Icon(Icons.search),
      title: Text(suggestion),
      onTap: () {
        _searchController.text = suggestion;
        setState(() {
          _searchQuery = suggestion;
        });
      },
    );
  }

  Widget _buildSearchResults(List<Product> results) {
    if (results.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.search_off,
              size: 80,
              color: Colors.grey[400],
            ),
            const SizedBox(height: 16),
            Text(
              'لا توجد نتائج لـ "$_searchQuery"',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.grey[700],
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'حاول البحث بكلمات مختلفة',
              style: TextStyle(
                fontSize: 16,
                color: Colors.grey[600],
              ),
            ),
          ],
        ),
      );
    }
    
    return GridView.builder(
      padding: const EdgeInsets.all(16),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 0.75,
        crossAxisSpacing: 16,
        mainAxisSpacing: 16,
      ),
      itemCount: results.length,
      itemBuilder: (context, index) {
        return ProductGridItem(product: results[index]);
      },
    );
  }
}