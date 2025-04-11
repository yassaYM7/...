class Validators {
  // التحقق من الاسم
  static String? validateName(String? value) {
    if (value == null || value.isEmpty) {
      return 'الرجاء إدخال الاسم';
    }
    if (value.length < 3) {
      return 'يجب أن يكون الاسم 3 أحرف على الأقل';
    }
    return null;
  }

  // التحقق من البريد الإلكتروني
  static String? validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return 'الرجاء إدخال البريد الإلكتروني';
    }
    
    // التحقق من صيغة البريد الإلكتروني
    final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
    if (!emailRegex.hasMatch(value)) {
      return 'الرجاء إدخال بريد إلكتروني صحيح';
    }
    
    return null;
  }

  // التحقق من كلمة المرور
  static String? validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'الرجاء إدخال كلمة المرور';
    }
    
    if (value.length < 8) {
      return 'يجب أن تكون كلمة المرور 8 أحرف على الأقل';
    }
    
    // التحقق من وجود حرف كبير على الأقل
    if (!value.contains(RegExp(r'[A-Z]'))) {
      return 'يجب أن تحتوي كلمة المرور على حرف كبير واحد على الأقل';
    }
    
    // التحقق من وجود رقم على الأقل
    if (!value.contains(RegExp(r'[0-9]'))) {
      return 'يجب أن تحتوي كلمة المرور على رقم واحد على الأقل';
    }
    
    // التحقق من وجود حرف خاص على الأقل
    if (!value.contains(RegExp(r'[!@#$%^&*(),.?":{}|<>]'))) {
      return 'يجب أن تحتوي كلمة المرور على حرف خاص واحد على الأقل';
    }
    
    return null;
  }

  // التحقق من كلمة المرور عند تسجيل الدخول (أقل صرامة)
  static String? validateLoginPassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'الرجاء إدخال كلمة المرور';
    }
    
    if (value.length < 6) {
      return 'كلمة المرور غير صحيحة';
    }
    
    return null;
  }

  // التحقق من تطابق كلمة المرور
  static String? validateConfirmPassword(String? value, String password) {
    if (value == null || value.isEmpty) {
      return 'الرجاء تأكيد كلمة المرور';
    }
    
    if (value != password) {
      return 'كلمات المرور غير متطابقة';
    }
    
    return null;
  }
}

