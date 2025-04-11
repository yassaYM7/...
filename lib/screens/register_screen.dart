import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/auth_provider.dart';
import '../screens/login_screen.dart';
import '../screens/home_screen.dart';
import '../utils/app_theme.dart';
import '../utils/validators.dart';
import '../widgets/password_strength_indicator.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  
  bool _isVisuallyImpaired = false;
  bool _isSecondaryUser = false;
  bool _obscurePassword = true;
  bool _obscureConfirmPassword = true;
  bool _isLoading = false;
  
  double _passwordStrength = 0.0;
  String _passwordStrengthText = "ضعيف";
  Color _passwordStrengthColor = Colors.red;

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  void _updatePasswordStrength(String password) {
    if (password.isEmpty) {
      setState(() {
        _passwordStrength = 0.0;
        _passwordStrengthText = "ضعيف";
        _passwordStrengthColor = Colors.red;
      });
      return;
    }
    
    // حساب قوة كلمة المرور
    double strength = 0;
    
    // التحقق من طول كلمة المرور
    if (password.length >= 8) strength += 0.25;
    
    // التحقق من وجود أحرف كبيرة وصغيرة
    if (password.contains(RegExp(r'[A-Z]')) && password.contains(RegExp(r'[a-z]'))) {
      strength += 0.25;
    }
    
    // التحقق من وجود أرقام
    if (password.contains(RegExp(r'[0-9]'))) strength += 0.25;
    
    // التحقق من وجود رموز خاصة
    if (password.contains(RegExp(r'[!@#$%^&*(),.?":{}|<>]'))) strength += 0.25;
    
    // تحديث حالة قوة كلمة المرور
    setState(() {
      _passwordStrength = strength;
      
      if (strength <= 0.25) {
        _passwordStrengthText = "ضعيف";
        _passwordStrengthColor = Colors.red;
      } else if (strength <= 0.5) {
        _passwordStrengthText = "متوسط";
        _passwordStrengthColor = Colors.orange;
      } else if (strength <= 0.75) {
        _passwordStrengthText = "جيد";
        _passwordStrengthColor = Colors.yellow;
      } else {
        _passwordStrengthText = "قوي";
        _passwordStrengthColor = Colors.green;
      }
    });
  }

  Future<void> _register() async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        _isLoading = true;
      });
      
      try {
        final authProvider = Provider.of<AuthProvider>(context, listen: false);
        
        // محاكاة عملية التسجيل
        await authProvider.register(
          _nameController.text,
          _emailController.text,
          _passwordController.text,
          _isVisuallyImpaired,
          _isSecondaryUser,
        );
        
        if (mounted) {
          // عرض رسالة نجاح
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('تم إنشاء الحساب بنجاح!'),
              backgroundColor: AppTheme.accentColor,
            ),
          );
          
          // الانتقال إلى الشاشة الرئيسية
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => const HomeScreen()),
          );
        }
      } catch (e) {
        // عرض رسالة خطأ
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('حدث خطأ: ${e.toString()}'),
              backgroundColor: AppTheme.errorColor,
            ),
          );
        }
      } finally {
        if (mounted) {
          setState(() {
            _isLoading = false;
          });
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('إنشاء حساب جديد'),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // عنوان الصفحة
                const Text(
                  'أهلاً بك!',
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8),
                const Text(
                  'أنشئ حسابك للاستمتاع بتجربة تسوق مميزة',
                  style: TextStyle(
                    fontSize: 16,
                    color: AppTheme.secondaryTextColor,
                  ),
                ),
                const SizedBox(height: 32),
                
                // حقل الاسم
                TextFormField(
                  controller: _nameController,
                  decoration: const InputDecoration(
                    labelText: 'الاسم الكامل',
                    prefixIcon: Icon(Icons.person_outline),
                  ),
                  validator: Validators.validateName,
                  textInputAction: TextInputAction.next,
                ),
                const SizedBox(height: 16),
                
                // حقل البريد الإلكتروني
                TextFormField(
                  controller: _emailController,
                  decoration: const InputDecoration(
                    labelText: 'البريد الإلكتروني',
                    prefixIcon: Icon(Icons.email_outlined),
                  ),
                  keyboardType: TextInputType.emailAddress,
                  validator: Validators.validateEmail,
                  textInputAction: TextInputAction.next,
                ),
                const SizedBox(height: 16),
                
                // حقل كلمة المرور
                TextFormField(
                  controller: _passwordController,
                  decoration: InputDecoration(
                    labelText: 'كلمة المرور',
                    prefixIcon: const Icon(Icons.lock_outline),
                    suffixIcon: IconButton(
                      icon: Icon(
                        _obscurePassword ? Icons.visibility_outlined : Icons.visibility_off_outlined,
                      ),
                      onPressed: () {
                        setState(() {
                          _obscurePassword = !_obscurePassword;
                        });
                      },
                    ),
                  ),
                  obscureText: _obscurePassword,
                  validator: Validators.validatePassword,
                  onChanged: _updatePasswordStrength,
                  textInputAction: TextInputAction.next,
                ),
                const SizedBox(height: 8),
                
                // مؤشر قوة كلمة المرور
                PasswordStrengthIndicator(
                  strength: _passwordStrength,
                  text: _passwordStrengthText,
                  color: _passwordStrengthColor,
                ),
                const SizedBox(height: 16),
                
                // حقل تأكيد كلمة المرور
                TextFormField(
                  controller: _confirmPasswordController,
                  decoration: InputDecoration(
                    labelText: 'تأكيد كلمة المرور',
                    prefixIcon: const Icon(Icons.lock_outline),
                    suffixIcon: IconButton(
                      icon: Icon(
                        _obscureConfirmPassword ? Icons.visibility_outlined : Icons.visibility_off_outlined,
                      ),
                      onPressed: () {
                        setState(() {
                          _obscureConfirmPassword = !_obscureConfirmPassword;
                        });
                      },
                    ),
                  ),
                  obscureText: _obscureConfirmPassword,
                  validator: (value) => Validators.validateConfirmPassword(
                    value,
                    _passwordController.text,
                  ),
                  textInputAction: TextInputAction.done,
                ),
                const SizedBox(height: 24),
                
                // خيارات إضافية
                const Text(
                  'خيارات إضافية',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8),
                
                // خيار ضعاف البصر
                CheckboxListTile(
                  value: _isVisuallyImpaired,
                  onChanged: (value) {
                    setState(() {
                      _isVisuallyImpaired = value ?? false;
                    });
                  },
                  title: const Text('أعاني من ضعف البصر'),
                  subtitle: const Text('تفعيل ميزات إمكانية الوصول المساعدة'),
                  contentPadding: EdgeInsets.zero,
                  controlAffinity: ListTileControlAffinity.leading,
                  dense: true,
                ),
                
                // خيار المستخدمين الثانويين
                CheckboxListTile(
                  value: _isSecondaryUser,
                  onChanged: (value) {
                    setState(() {
                      _isSecondaryUser = value ?? false;
                    });
                  },
                  title: const Text('مستخدم ثانوي'),
                  subtitle: const Text('إضافة حساب ثانوي مرتبط بحساب رئيسي'),
                  contentPadding: EdgeInsets.zero,
                  controlAffinity: ListTileControlAffinity.leading,
                  dense: true,
                ),
                const SizedBox(height: 32),
                
                // زر التسجيل
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: _isLoading ? null : _register,
                    child: _isLoading
                        ? const SizedBox(
                            width: 24,
                            height: 24,
                            child: CircularProgressIndicator(
                              color: Colors.white,
                              strokeWidth: 2.0,
                            ),
                          )
                        : const Text('إنشاء حساب'),
                  ),
                ),
                const SizedBox(height: 16),
                
                // رابط تسجيل الدخول
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      'لديك حساب بالفعل؟',
                      style: TextStyle(color: AppTheme.secondaryTextColor),
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(builder: (context) => const LoginScreen()),
                        );
                      },
                      child: const Text('تسجيل الدخول'),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

