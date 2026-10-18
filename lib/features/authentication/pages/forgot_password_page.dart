import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_dimensions.dart';
import '../../../core/theme/app_text_styles.dart';
import '../../../app/routes/app_routes.dart';
import '../controllers/auth_controller.dart';
import '../widgets/auth_header.dart';
import '../widgets/auth_text_field.dart';
import '../widgets/auth_button.dart';

/// Forgot Password screen with reset email request and success feedback UI.
class ForgotPasswordPage extends StatefulWidget {
  const ForgotPasswordPage({super.key});

  @override
  State<ForgotPasswordPage> createState() => _ForgotPasswordPageState();
}

class _ForgotPasswordPageState extends State<ForgotPasswordPage> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  bool _isSubmitted = false;

  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }

  void _submitReset(AuthController authCtrl) async {
    if (_formKey.currentState?.validate() == true) {
      final success = await authCtrl.forgotPassword(_emailController.text.trim());
      if (success) {
        setState(() {
          _isSubmitted = true;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final authCtrl = Get.find<AuthController>();

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.background,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: AppColors.white),
          onPressed: () => Get.back(),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          padding: const EdgeInsets.symmetric(
            horizontal: AppDimensions.screenPaddingHorizontal,
          ),
          child: Column(
            children: [
              const SizedBox(height: 20),
              if (!_isSubmitted) ...[
                const AuthHeader(
                  title: 'Reset Password',
                  subtitle:
                      "Enter your email and we'll send you a password reset link.",
                ),
                Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      AuthTextField(
                        label: 'Email Address',
                        hint: 'your email address',
                        controller: _emailController,
                        prefixIcon: Icons.email_outlined,
                        keyboardType: TextInputType.emailAddress,
                        validator: (val) {
                          if (val == null || val.trim().isEmpty) {
                            return 'Email is required';
                          }
                          if (!GetUtils.isEmail(val.trim())) {
                            return 'Please enter a valid email format';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 20),
                      Obx(
                        () => AuthButton(
                          title: 'Send Reset Link',
                          isLoading: authCtrl.isLoading.value,
                          onPressed: () => _submitReset(authCtrl),
                        ),
                      ),
                    ],
                  ),
                ),
              ] else ...[
                // Success State Feedback UI
                const SizedBox(height: 40),
                Container(
                  width: 80,
                  height: 80,
                  decoration: const BoxDecoration(
                    color: AppColors.surface,
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(
                    Icons.check_circle_outline,
                    color: AppColors.primary,
                    size: 48,
                  ),
                ),
                const SizedBox(height: 24),
                Text(
                  'Check your email',
                  style: AppTextStyles.display.copyWith(fontSize: 24),
                ),
                const SizedBox(height: 8),
                Text(
                  'Password reset instructions have been sent to:\n${_emailController.text}',
                  textAlign: TextAlign.center,
                  style: AppTextStyles.subtitle.copyWith(height: 1.4),
                ),
                const SizedBox(height: 36),
                AuthButton(
                  title: 'Back to Login',
                  isLoading: false,
                  onPressed: () => Get.offAllNamed(AppRoutes.login),
                ),
              ],
              const SizedBox(height: 30),
            ],
          ),
        ),
      ),
    );
  }
}
