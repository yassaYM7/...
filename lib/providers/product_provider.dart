import 'package:flutter/material.dart';
import '../models/product.dart';

class ProductProvider with ChangeNotifier {
  // قائمة المنتجات
  final List<Product> _products = [
    Product(
      id: '1',
      name: 'iPhone 15 Pro',
      price: 999.0,
      imageUrl: 'https://store.storeimages.cdn-apple.com/4982/as-images.apple.com/is/iphone-15-pro-finish-select-202309-6-7inch-naturaltitanium?wid=5120&hei=2880&fmt=p-jpg&qlt=80&.v=1692845702708',
      description: 'iPhone 15 Pro. تيتانيوم. قوي. خفيف. Pro.',
      category: 'iPhone',
      colors: [
        ProductColor(name: 'تيتانيوم طبيعي', colorCode: 0xFFE3D0BA),
        ProductColor(name: 'تيتانيوم أزرق', colorCode: 0xFF7D9AAA),
        ProductColor(name: 'تيتانيوم أبيض', colorCode: 0xFFF5F5F0),
        ProductColor(name: 'تيتانيوم أسود', colorCode: 0xFF4D4D4D),
      ],
      sizes: [
        ProductSize(name: '128GB', price: 999.0),
        ProductSize(name: '256GB', price: 1099.0),
        ProductSize(name: '512GB', price: 1299.0),
        ProductSize(name: '1TB', price: 1499.0),
      ],
      isFeatured: true,
      isNew: true,
      rating: 4.8,
      reviewCount: 2543,
      specifications: [
        'شاشة Super Retina XDR مقاس 6.7 بوصة',
        'تصميم تيتانيوم - أخف وأقوى',
        'شريحة A17 Pro - أداء استثنائي',
        'نظام كاميرا Pro ثلاثي 48 ميجابكسل',
        'زر إجراء قابل للتخصيص',
        'عمر بطارية يدوم طوال اليوم',
        'USB-C مع سرعات نقل بيانات عالية',
        'iOS 17',
      ],
    ),
    Product(
      id: '2',
      name: 'MacBook Air',
      price: 1199.0,
      imageUrl: 'https://store.storeimages.cdn-apple.com/4982/as-images.apple.com/is/macbook-air-midnight-config-20220606?wid=820&hei=498&fmt=jpeg&qlt=90&.v=1654122880566',
      description: 'MacBook Air مع شريحة M2. خفيف الوزن. قوي الأداء.',
      category: 'Mac',
      colors: [
        ProductColor(name: 'رمادي فلكي', colorCode: 0xFF4A4A4A),
        ProductColor(name: 'فضي', colorCode: 0xFFE3E3E3),
        ProductColor(name: 'ذهبي', colorCode: 0xFFE8D0B8),
        ProductColor(name: 'منتصف الليل', colorCode: 0xFF1E1E1E),
      ],
      sizes: [
        ProductSize(name: '8GB / 256GB', price: 1199.0),
        ProductSize(name: '8GB / 512GB', price: 1399.0),
        ProductSize(name: '16GB / 512GB', price: 1599.0),
        ProductSize(name: '16GB / 1TB', price: 1799.0),
      ],
      isFeatured: true,
      isNew: false,
      rating: 4.9,
      reviewCount: 3210,
      specifications: [
        'شريحة M2 من Apple',
        'شاشة Liquid Retina مقاس 13.6 بوصة',
        'ذاكرة وصول عشوائي موحدة تصل إلى 16GB',
        'تخزين SSD يصل إلى 1TB',
        'كاميرا FaceTime HD بدقة 1080p',
        'نظام صوت رباعي السماعات',
        'ما يصل إلى 18 ساعة من عمر البطارية',
        'منفذان Thunderbolt / USB 4',
      ],
    ),
    Product(
      id: '3',
      name: 'iPad Pro',
      price: 799.0,
      imageUrl: 'https://store.storeimages.cdn-apple.com/4982/as-images.apple.com/is/ipad-pro-model-select-gallery-2-202210?wid=5120&hei=2880&fmt=p-jpg&qlt=80&.v=1664411207212',
      description: 'iPad Pro. قوة فائقة. تصميم نحيف بشكل مذهل.',
      category: 'iPad',
      colors: [
        ProductColor(name: 'فضي', colorCode: 0xFFE3E3E3),
        ProductColor(name: 'رمادي فلكي', colorCode: 0xFF4A4A4A),
      ],
      sizes: [
        ProductSize(name: '11 بوصة - 128GB', price: 799.0),
        ProductSize(name: '11 بوصة - 256GB', price: 899.0),
        ProductSize(name: '12.9 بوصة - 128GB', price: 1099.0),
        ProductSize(name: '12.9 بوصة - 256GB', price: 1199.0),
      ],
      isFeatured: true,
      isNew: false,
      rating: 4.7,
      reviewCount: 1876,
      specifications: [
        'شريحة M2 من Apple',
        'شاشة Liquid Retina XDR',
        'كاميرا خلفية بدقة 12 ميجابكسل + LiDAR',
        'كاميرا أمامية بدقة 12 ميجابكسل',
        'تخزين يصل إلى 2TB',
        'متوافق مع Apple Pencil وMagic Keyboard',
        'منفذ USB-C',
        'Face ID',
      ],
    ),
    Product(
      id: '4',
      name: 'Apple Watch Series 9',
      price: 399.0,
      imageUrl: 'https://store.storeimages.cdn-apple.com/4982/as-images.apple.com/is/watch-card-40-s9-202309_GEO_US?wid=680&hei=528&fmt=jpeg&qlt=90&.v=1693501980242',
      description: 'الساعة الأكثر تقدمًا وقوة حتى الآن.',
      category: 'Watch',
      colors: [
        ProductColor(name: 'ألمنيوم أسود', colorCode: 0xFF1D1D1D),
        ProductColor(name: 'ألمنيوم فضي', colorCode: 0xFFE3E3E3),
        ProductColor(name: 'ألمنيوم ذهبي', colorCode: 0xFFE8D0B8),
        ProductColor(name: 'ستانلس ستيل', colorCode: 0xFFB8B8B8),
      ],
      sizes: [
        ProductSize(name: '41mm GPS', price: 399.0),
        ProductSize(name: '45mm GPS', price: 429.0),
        ProductSize(name: '41mm GPS + Cellular', price: 499.0),
        ProductSize(name: '45mm GPS + Cellular', price: 529.0),
      ],
      isFeatured: true,
      isNew: true,
      rating: 4.6,
      reviewCount: 1432,
      specifications: [
        'شاشة Retina دائمة التشغيل',
        'شريحة S9 SiP',
        'مقاوم للماء حتى 50 مترًا',
        'مستشعر أكسجين الدم',
        'مخطط كهربية القلب (ECG)',
        'إشعارات معدل ضربات القلب',
        'تتبع النوم',
        'اكتشاف السقوط والتصادم',
      ],
    ),
    Product(
      id: '5',
      name: 'AirPods Pro',
      price: 249.0,
      imageUrl: 'https://store.storeimages.cdn-apple.com/4982/as-images.apple.com/is/MQD83?wid=1144&hei=1144&fmt=jpeg&qlt=90&.v=1660803972361',
      description: 'إلغاء الضوضاء النشط. وضع الشفافية. صوت محيطي.',
      category: 'AirPods',
      colors: [
        ProductColor(name: 'أبيض', colorCode: 0xFFFFFFFF),
      ],
      sizes: [
        ProductSize(name: 'AirPods Pro', price: 249.0),
      ],
      isFeatured: true,
      isNew: false,
      rating: 4.7,
      reviewCount: 2876,
      specifications: [
        'إلغاء الضوضاء النشط',
        'وضع الشفافية',
        'الصوت المكاني مع تتبع حركة الرأس',
        'مقاومة للماء والعرق',
        'شريحة H2',
        'عمر بطارية يصل إلى 6 ساعات',
        'شحن MagSafe',
        'مكبرات صوت ديناميكية عالية النطاق',
      ],
    ),
    Product(
      id: '6',
      name: 'HomePod mini',
      price: 99.0,
      imageUrl: 'https://store.storeimages.cdn-apple.com/4982/as-images.apple.com/is/homepod-mini-select-blue-202110?wid=1000&hei=1000&fmt=jpeg&qlt=95&.v=1632925511000',
      description: 'صوت كبير. مساعد ذكي. تحكم منزلي.',
      category: 'HomePod',
      colors: [
        ProductColor(name: 'أبيض', colorCode: 0xFFFFFFFF),
        ProductColor(name: 'أسود', colorCode: 0xFF1D1D1D),
        ProductColor(name: 'أزرق', colorCode: 0xFF2D68C4),
        ProductColor(name: 'برتقالي', colorCode: 0xFFFF6A13),
        ProductColor(name: 'أصفر', colorCode: 0xFFFFE681),
      ],
      sizes: [
        ProductSize(name: 'HomePod mini', price: 99.0),
      ],
      isFeatured: true,
      isNew: false,
      rating: 4.5,
      reviewCount: 987,
      specifications: [
        'صوت 360 درجة',
        'شريحة S5',
        'Siri',
        'التحكم المنزلي الذكي',
        'بث متعدد الغرف',
        'تجربة استريو',
        'تقنية الصوت المحيط',
        'تقنية Intercom',
      ],
    ),
    Product(
      id: '7',
      name: 'AirPods Max',
      price: 549.0,
      imageUrl: 'https://store.storeimages.cdn-apple.com/4982/as-images.apple.com/is/airpods-max-select-skyblue-202011?wid=940&hei=1112&fmt=png-alpha&.v=1604022365000',
      description: 'سماعات رأس لاسلكية عالية الأداء.',
      category: 'AirPods',
      colors: [
        ProductColor(name: 'فضي', colorCode: 0xFFE3E3E3),
        ProductColor(name: 'أسود', colorCode: 0xFF1D1D1D),
        ProductColor(name: 'أزرق سماوي', colorCode: 0xFF76AECE),
        ProductColor(name: 'وردي', colorCode: 0xFFE5C0C0),
        ProductColor(name: 'أخضر', colorCode: 0xFF8FBC94),
      ],
      sizes: [
        ProductSize(name: 'AirPods Max', price: 549.0),
      ],
      isFeatured: false,
      isNew: true,
      rating: 4.6,
      reviewCount: 1245,
      specifications: [
        'إلغاء الضوضاء النشط',
        'وضع الشفافية',
        'الصوت المكاني',
        'شريحة H1',
        'عمر بطارية يصل إلى 20 ساعة',
        'تصميم مريح',
        'جودة صوت استثنائية',
        'تحكم رقمي بالتاج',
      ],
    ),
    Product(
      id: '8',
      name: 'Apple TV 4K',
      price: 179.0,
      imageUrl: 'https://store.storeimages.cdn-apple.com/4982/as-images.apple.com/is/apple-tv-4k-hero-select-202210?wid=1076&hei=1070&fmt=jpeg&qlt=90&.v=1664896361408',
      description: 'تجربة مشاهدة مذهلة. تطبيقات رائعة. تحكم منزلي ذكي.',
      category: 'TV',
      colors: [
        ProductColor(name: 'أسود', colorCode: 0xFF1D1D1D),
      ],
      sizes: [
        ProductSize(name: '64GB', price: 179.0),
        ProductSize(name: '128GB', price: 199.0),
      ],
      isFeatured: false,
      isNew: true,
      rating: 4.7,
      reviewCount: 876,
      specifications: [
        'دقة 4K HDR مع Dolby Vision',
        'شريحة A15 Bionic',
        'جهاز تحكم Siri Remote',
        'دعم Dolby Atmos',
        'Apple TV+',
        'Apple Arcade',
        'Apple Fitness+',
        'التحكم المنزلي',
      ],
    ),
  ];

  // قائمة الفئات
  final List<String> _categories = [
    'iPhone',
    'Mac',
    'iPad',
    'Watch',
    'AirPods',
    'TV',
    'Accessories',
  ];

  // الحصول على جميع المنتجات
  List<Product> get products => [..._products];

  // الحصول على جميع الفئات
  List<String> get categories => [..._categories];

  // الحصول على المنتجات المميزة
  List<Product> get featuredProducts => _products.where((product) => product.isFeatured).toList();

  // الحصول على المنتجات الجديدة
  List<Product> get newProducts => _products.where((product) => product.isNew).toList();

  // الحصول على منتج بواسطة المعرف
  Product findById(String id) {
    return _products.firstWhere((product) => product.id == id);
  }

  // الحصول على منتجات حسب الفئة
  List<Product> getProductsByCategory(String category) {
    return _products.where((product) => product.category == category).toList();
  }

  // البحث عن منتجات
  List<Product> searchProducts(String query) {
    if (query.isEmpty) {
      return [];
    }
    
    final lowercaseQuery = query.toLowerCase();
    return _products.where((product) {
      return product.name.toLowerCase().contains(lowercaseQuery) ||
             product.description.toLowerCase().contains(lowercaseQuery) ||
             product.category.toLowerCase().contains(lowercaseQuery);
    }).toList();
  }
}

