import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/auth_provider.dart';
import '../screens/welcome_screen.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context);
    
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: const Text(
          'حسابي',
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 16),
            
            // صورة الملف الشخصي
            CircleAvatar(
              radius: 50,
              backgroundColor: Colors.grey[200],
              child: const Icon(
                Icons.person,
                size: 50,
                color: Colors.grey,
              ),
            ),
            const SizedBox(height: 16),
            
            // اسم المستخدم
            Text(
              authProvider.userName ?? 'مستخدم',
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 4),
            
            // البريد الإلكتروني
            Text(
              authProvider.userEmail ?? 'user@example.com',
              style: TextStyle(
                fontSize: 16,
                color: Colors.grey[600],
              ),
            ),
            const SizedBox(height: 32),
            
            // قائمة الإعدادات
            _buildSettingsItem(
              context,
              icon: Icons.person_outline,
              title: 'معلومات الحساب',
              onTap: () {},
            ),
            _buildSettingsItem(
              context,
              icon: Icons.shopping_bag_outlined,
              title: 'طلباتي',
              onTap: () {},
            ),
            _buildSettingsItem(
              context,
              icon: Icons.location_on_outlined,
              title: 'العناوين',
              onTap: () {},
            ),
            _buildSettingsItem(
              context,
              icon: Icons.payment_outlined,
              title: 'طرق الدفع',
              onTap: () {},
            ),
            _buildSettingsItem(
              context,
              icon: Icons.favorite_outline,
              title: 'المفضلة',
              onTap: () {},
            ),
            _buildSettingsItem(
              context,
              icon: Icons.notifications_outlined,
              title: 'الإشعارات',
              onTap: () {},
            ),
            _buildSettingsItem(
              context,
              icon: Icons.settings_outlined,
              title: 'الإعدادات',
              onTap: () {},
            ),
            _buildSettingsItem(
              context,
              icon: Icons.help_outline,
              title: 'المساعدة والدعم',
              onTap: () {},
            ),
            _buildSettingsItem(
              context,
              icon: Icons.info_outline,
              title: 'عن التطبيق',
              onTap: () {},
            ),
            _buildSettingsItem(
              context,
              icon: Icons.logout,
              title: 'تسجيل الخروج',
              onTap: () async {
                // تأكيد تسجيل الخروج
                final confirm = await showDialog<bool>(
                  context: context,
                  builder: (context) => AlertDialog(
                    title: const Text('تسجيل الخروج'),
                    content: const Text('هل أنت متأكد من رغبتك في تسجيل الخروج؟'),
                    actions: [
                      TextButton(
                        onPressed: () => Navigator.pop(context, false),
                        child: const Text('إلغاء'),
                      ),
                      TextButton(
                        onPressed: () => Navigator.pop(context, true),
                        child: const Text('تأكيد'),
                      ),
                    ],
                  ),
                );
                
                if (confirm == true) {
                  await authProvider.logout();
                  if (context.mounted) {
                    Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(builder: (context) => const WelcomeScreen()),
                      (route) => false,
                    );
                  }
                }
              },
              textColor: Colors.red,
            ),
            const SizedBox(height: 32),
          ],
        ),
      ),
    );
  }

  Widget _buildSettingsItem(
    BuildContext context, {
    required IconData icon,
    required String title,
    required VoidCallback onTap,
    Color? textColor,
  }) {
    return ListTile(
      leading: Icon(icon, color: textColor ?? Colors.black),
      title: Text(
        title,
        style: TextStyle(
          color: textColor ?? Colors.black,
          fontWeight: FontWeight.w500,
        ),
      ),
      trailing: const Icon(Icons.arrow_forward_ios, size: 16),
      onTap: onTap,
    );
  }
}

