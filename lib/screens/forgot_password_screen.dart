import 'package:flutter/material.dart';
import '../utils/app_theme.dart';
import '../utils/validators.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  bool _isLoading = false;
  bool _emailSent = false;

  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }

  Future<void> _resetPassword() async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        _isLoading = true;
      });
      
      try {
        // محاكاة إرسال بريد إلكتروني لإعادة تعيين كلمة المرور
        await Future.delayed(const Duration(seconds: 2));
        
        if (mounted) {
          setState(() {
            _emailSent = true;
          });
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
        title: const Text('نسيت كلمة المرور'),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24.0),
          child: _emailSent ? _buildSuccessView() : _buildFormView(),
        ),
      ),
    );
  }

  Widget _buildFormView() {
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // عنوان الصفحة
          const Text(
            'نسيت كلمة المرور؟',
            style: TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8),
          const Text(
            'أدخل بريدك الإلكتروني وسنرسل لك رابطًا لإعادة تعيين كلمة المرور',
            style: TextStyle(
              fontSize: 16,
              color: AppTheme.secondaryTextColor,
            ),
          ),
          const SizedBox(height: 32),
          
          // حقل البريد الإلكتروني
          TextFormField(
            controller: _emailController,
            decoration: const InputDecoration(
              labelText: 'البريد الإلكتروني',
              prefixIcon: Icon(Icons.email_outlined),
            ),
            keyboardType: TextInputType.emailAddress,
            validator: Validators.validateEmail,
            textInputAction: TextInputAction.done,
          ),
          const SizedBox(height: 32),
          
          // زر إرسال
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: _isLoading ? null : _resetPassword,
              child: _isLoading
                  ? const SizedBox(
                      width: 24,
                      height: 24,
                      child: CircularProgressIndicator(
                        color: Colors.white,
                        strokeWidth: 2.0,
                      ),
                    )
                  : const Text('إرسال رابط إعادة التعيين'),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSuccessView() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const SizedBox(height: 32),
        const Icon(
          Icons.check_circle_outline,
          color: AppTheme.accentColor,
          size: 80,
        ),
        const SizedBox(height: 24),
        const Text(
          'تم إرسال رابط إعادة التعيين!',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 16),
        Text(
          'لقد أرسلنا رابط إعادة تعيين كلمة المرور إلى ${_emailController.text}',
          style: const TextStyle(
            fontSize: 16,
            color: AppTheme.secondaryTextColor,
          ),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 8),
        const Text(
          'يرجى التحقق من بريدك الإلكتروني واتباع التعليمات لإعادة تعيين كلمة المرور الخاصة بك.',
          style: TextStyle(
            fontSize: 16,
            color: AppTheme.secondaryTextColor,
          ),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 32),
        SizedBox(
          width: double.infinity,
          child: ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: const Text('العودة إلى تسجيل الدخول'),
          ),
        ),
      ],
    );
  }
}

