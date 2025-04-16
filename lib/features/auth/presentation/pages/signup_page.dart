import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todotask/core/routes/app_routes.dart';
import 'package:todotask/features/auth/presentation/controllers/auth_controller.dart';
import 'package:todotask/features/auth/presentation/widgets/custom_input_field.dart';

class SignupPage extends StatelessWidget {
  const SignupPage({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = context.watch<AuthController>();
    
    return Scaffold(
      backgroundColor: const Color(0xFFFFF5F1),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Form(
              key: controller.formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(height: 24),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(
                        'assets/img/todo_logo.png',
                        height: 24,
                      ),
                      const SizedBox(width: 8),
                      const Text(
                        'TO-DO',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFFE17055),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 48),
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(24),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(24),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.05),
                          blurRadius: 10,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            GestureDetector(
                              onTap: () => controller.navigateToLogin(context),
                              child: Container(
                                padding: const EdgeInsets.all(8),
                                decoration: BoxDecoration(
                                  color: const Color(0xFFF7F8F8),
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: const Icon(
                                  Icons.arrow_back_ios_new,
                                  color: Color(0xFF1D1517),
                                  size: 20,
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 24),
                        const Text(
                          'Sign up',
                          style: TextStyle(
                            fontSize: 32,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF1D1517),
                          ),
                        ),
                        const SizedBox(height: 8),
                        Row(
                          children: [
                            Text(
                              'Already have an account? ',
                              style: TextStyle(
                                fontSize: 14,
                                color: Colors.grey[600],
                              ),
                            ),
                            GestureDetector(
                              onTap: () => controller.navigateToLogin(context),
                              child: const Text(
                                'Login',
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                  color: Color(0xFFE17055),
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 32),
                        CustomInputField(
                          label: 'Full Name',
                          controller: controller.fullNameController,
                          validator: controller.validateFullName,
                        ),
                        const SizedBox(height: 24),
                        CustomInputField(
                          label: 'Email',
                          controller: controller.emailController,
                          validator: controller.validateEmail,
                          keyboardType: TextInputType.emailAddress,
                        ),
                        const SizedBox(height: 24),
                        CustomInputField(
                          label: 'Date of birth',
                          controller: controller.dateController,
                          validator: controller.validateDate,
                          readOnly: true,
                          onTap: () async {
                            final date = await showDatePicker(
                              context: context,
                              initialDate: DateTime.now(),
                              firstDate: DateTime(1900),
                              lastDate: DateTime.now(),
                            );
                            if (date != null) {
                              controller.dateController.text =
                                  '${date.day.toString().padLeft(2, '0')}/${date.month.toString().padLeft(2, '0')}/${date.year}';
                            }
                          },
                          suffixIcon: const Icon(
                            Icons.calendar_today,
                            color: Colors.grey,
                            size: 20,
                          ),
                        ),
                        const SizedBox(height: 24),
                        CustomInputField(
                          label: 'Phone Number',
                          controller: controller.phoneController,
                          validator: controller.validatePhone,
                          keyboardType: TextInputType.phone,
                          prefixText: '+91 ',
                        ),
                        const SizedBox(height: 24),
                        CustomInputField(
                          label: 'Set Password',
                          controller: controller.passwordController,
                          validator: controller.validatePassword,
                          obscureText: !controller.isPasswordVisible,
                          suffixIcon: IconButton(
                            icon: Icon(
                              controller.isPasswordVisible
                                  ? Icons.visibility_off
                                  : Icons.visibility,
                              color: Colors.grey,
                              size: 20,
                            ),
                            onPressed: controller.togglePasswordVisibility,
                          ),
                        ),
                        const SizedBox(height: 32),
                        SizedBox(
                          width: double.infinity,
                          height: 56,
                          child: ElevatedButton(
                            onPressed: controller.isLoading
                                ? null
                                : () => controller.register(context),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0xFFE17055),
                              foregroundColor: Colors.white,
                              elevation: 0,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(14),
                              ),
                            ),
                            child: controller.isLoading
                                ? const SizedBox(
                                    width: 24,
                                    height: 24,
                                    child: CircularProgressIndicator(
                                      strokeWidth: 2,
                                      valueColor: AlwaysStoppedAnimation<Color>(
                                          Colors.white),
                                    ),
                                  )
                                : const Text(
                                    'Register',
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w600,
                                    ),
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
        ),
      ),
    );
  }
} 