import 'package:flutter/material.dart';

class AuthProvider with ChangeNotifier {
  bool _isAuthenticated = false;
  String? _token;
  String? _userId;
  String? _userName;
  String? _userEmail;
  bool _isVisuallyImpaired = false;
  bool _isSecondaryUser = false;

  bool get isAuthenticated => _isAuthenticated;
  String? get token => _token;
  String? get userId => _userId;
  String? get userName => _userName;
  String? get userEmail => _userEmail;
  bool get isVisuallyImpaired => _isVisuallyImpaired;
  bool get isSecondaryUser => _isSecondaryUser;

  // تسجيل مستخدم جديد
  Future<void> register(
    String name,
    String email,
    String password,
    bool isVisuallyImpaired,
    bool isSecondaryUser,
  ) async {
    // محاكاة طلب API للتسجيل
    await Future.delayed(const Duration(seconds: 2));
    
    // في تطبيق حقيقي، سنرسل طلب إلى الخادم هنا
    
    // تعيين بيانات المستخدم بعد التسجيل الناجح
    _isAuthenticated = true;
    _token = 'dummy_token_${DateTime.now().millisecondsSinceEpoch}';
    _userId = 'user_${DateTime.now().millisecondsSinceEpoch}';
    _userName = name;
    _userEmail = email;
    _isVisuallyImpaired = isVisuallyImpaired;
    _isSecondaryUser = isSecondaryUser;
    
    notifyListeners();
  }

  // تسجيل الدخول
  Future<void> login(
    String email,
    String password,
    bool rememberMe,
  ) async {
    // محاكاة طلب API لتسجيل الدخول
    await Future.delayed(const Duration(seconds: 2));
    
    // في تطبيق حقيقي، سنرسل طلب إلى الخادم هنا
    
    // تعيين بيانات المستخدم بعد تسجيل الدخول الناجح
    _isAuthenticated = true;
    _token = 'dummy_token_${DateTime.now().millisecondsSinceEpoch}';
    _userId = 'user_123';
    _userName = 'مستخدم تجريبي';
    _userEmail = email;
    
    // في تطبيق حقيقي، سنحصل على هذه البيانات من الخادم
    _isVisuallyImpaired = false;
    _isSecondaryUser = false;
    
    notifyListeners();
  }

  // تسجيل الخروج
  Future<void> logout() async {
    _isAuthenticated = false;
    _token = null;
    _userId = null;
    _userName = null;
    _userEmail = null;
    _isVisuallyImpaired = false;
    _isSecondaryUser = false;
    
    notifyListeners();
  }
}

