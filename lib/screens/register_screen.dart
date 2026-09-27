import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final TextEditingController nameController =
      TextEditingController();

  final TextEditingController emailController =
      TextEditingController();

  final TextEditingController passwordController =
      TextEditingController();

  final TextEditingController confirmPasswordController =
      TextEditingController();

  bool obscurePassword = true;
  bool obscureConfirmPassword = true;
  bool isLoading = false;

  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    super.dispose();
  }

  // ============================================================
  // CREATE ACCOUNT
  // ============================================================

  Future<void> createAccount() async {
    FocusScope.of(context).unfocus();

    final String name =
        nameController.text.trim();

    final String email =
        emailController.text.trim().toLowerCase();

    final String password =
        passwordController.text.trim();

    final String confirmPassword =
        confirmPasswordController.text.trim();

    // ==========================================================
    // VALIDATION
    // ==========================================================

    if (name.isEmpty) {
      showMessage('Please enter your full name');
      return;
    }

    if (email.isEmpty) {
      showMessage('Please enter your email');
      return;
    }

    if (!email.contains('@') ||
        !email.contains('.')) {
      showMessage('Please enter a valid email');
      return;
    }

    if (password.isEmpty) {
      showMessage('Please enter your password');
      return;
    }

    if (password.length < 6) {
      showMessage(
        'Password must be at least 6 characters',
      );
      return;
    }

    if (confirmPassword.isEmpty) {
      showMessage('Please confirm your password');
      return;
    }

    if (password != confirmPassword) {
      showMessage('Passwords do not match');
      return;
    }

    setState(() {
      isLoading = true;
    });

    try {
      final prefs =
          await SharedPreferences.getInstance();

      // Existing accounts get karo
      final String savedAccounts =
          prefs.getString('registered_accounts') ?? '[]';

      final List<dynamic> accounts =
          jsonDecode(savedAccounts);

      // Same email already registered?
      final bool alreadyExists = accounts.any(
        (account) =>
            account['email'] == email,
      );

      if (alreadyExists) {
        if (!mounted) return;

        setState(() {
          isLoading = false;
        });

        showMessage(
          'This email is already registered',
        );

        return;
      }

      // New account
      final Map<String, String> newAccount = {
        'name': name,
        'email': email,
        'password': password,
      };

      accounts.add(newAccount);

      // Save all accounts
      await prefs.setString(
        'registered_accounts',
        jsonEncode(accounts),
      );

      if (!mounted) return;

      setState(() {
        isLoading = false;
      });

      // Success message
      showMessage(
        'Account created successfully',
        isError: false,
      );

      // Login screen par wapas
      await Future.delayed(
        const Duration(milliseconds: 700),
      );

      if (!mounted) return;

      Navigator.pop(context);
    } catch (e) {
      if (!mounted) return;

      setState(() {
        isLoading = false;
      });

      showMessage(
        'Something went wrong. Please try again.',
      );
    }
  }

  // ============================================================
  // MESSAGE
  // ============================================================

  void showMessage(
    String message, {
    bool isError = true,
  }) {
    ScaffoldMessenger.of(context)
        .hideCurrentSnackBar();

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: isError
            ? const Color(0xFFDC2626)
            : const Color(0xFF16A34A),
        behavior: SnackBarBehavior.floating,
        margin: const EdgeInsets.all(16),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
      ),
    );
  }

  // ============================================================
  // INPUT DECORATION
  // ============================================================

  InputDecoration inputDecoration({
    required String hintText,
    Widget? suffixIcon,
  }) {
    return InputDecoration(
      hintText: hintText,

      hintStyle: const TextStyle(
        color: Color(0xFF94A3B8),
        fontSize: 15,
      ),

      filled: true,
      fillColor: Colors.white,

      contentPadding:
          const EdgeInsets.symmetric(
        horizontal: 15,
        vertical: 16,
      ),

      suffixIcon: suffixIcon,

      border: OutlineInputBorder(
        borderRadius:
            BorderRadius.circular(12),
        borderSide: const BorderSide(
          color: Color(0xFFE2E8F0),
        ),
      ),

      enabledBorder: OutlineInputBorder(
        borderRadius:
            BorderRadius.circular(12),
        borderSide: const BorderSide(
          color: Color(0xFFE2E8F0),
        ),
      ),

      focusedBorder: OutlineInputBorder(
        borderRadius:
            BorderRadius.circular(12),
        borderSide: const BorderSide(
          color: Color(0xFF2563EB),
          width: 1.5,
        ),
      ),
    );
  }

  // ============================================================
  // BUILD
  // ============================================================

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:
          const Color(0xFFF8FAFC),

      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding:
                const EdgeInsets.symmetric(
              horizontal: 24,
            ),

            child: Column(
              crossAxisAlignment:
                  CrossAxisAlignment.start,

              children: [

                const SizedBox(height: 25),

                // ==================================================
                // BACK
                // ==================================================

                GestureDetector(
                  onTap: () {
                    Navigator.pop(context);
                  },

                  child: const Row(
                    mainAxisSize:
                        MainAxisSize.min,

                    children: [

                      Icon(
                        Icons.chevron_left,
                        color:
                            Color(0xFF2563EB),
                        size: 22,
                      ),

                      SizedBox(width: 2),

                      Text(
                        'Back',
                        style: TextStyle(
                          color:
                              Color(0xFF2563EB),
                          fontSize: 14,
                          fontWeight:
                              FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 25),

                // ==================================================
                // TITLE
                // ==================================================

                const Text(
                  'Create Account',
                  style: TextStyle(
                    color: Color(0xFF111827),
                    fontSize: 28,
                    fontWeight:
                        FontWeight.w700,
                    letterSpacing: -0.6,
                  ),
                ),

                const SizedBox(height: 7),

                const Text(
                  'Register as an administrator',
                  style: TextStyle(
                    color: Color(0xFF64748B),
                    fontSize: 15,
                  ),
                ),

                const SizedBox(height: 32),

                // ==================================================
                // NAME
                // ==================================================

                const Text(
                  'Full Name',
                  style: TextStyle(
                    color: Color(0xFF475569),
                    fontSize: 13,
                    fontWeight:
                        FontWeight.w600,
                  ),
                ),

                const SizedBox(height: 8),

                TextField(
                  controller:
                      nameController,
                  textCapitalization:
                      TextCapitalization.words,
                  decoration:
                      inputDecoration(
                    hintText:
                        'Enter your full name',
                  ),
                ),

                const SizedBox(height: 17),

                // ==================================================
                // EMAIL
                // ==================================================

                const Text(
                  'Email Address',
                  style: TextStyle(
                    color: Color(0xFF475569),
                    fontSize: 13,
                    fontWeight:
                        FontWeight.w600,
                  ),
                ),

                const SizedBox(height: 8),

                TextField(
                  controller:
                      emailController,
                  keyboardType:
                      TextInputType.emailAddress,
                  decoration:
                      inputDecoration(
                    hintText:
                        'Enter your email address',
                  ),
                ),

                const SizedBox(height: 17),

                // ==================================================
                // PASSWORD
                // ==================================================

                const Text(
                  'Password',
                  style: TextStyle(
                    color: Color(0xFF475569),
                    fontSize: 13,
                    fontWeight:
                        FontWeight.w600,
                  ),
                ),

                const SizedBox(height: 8),

                TextField(
                  controller:
                      passwordController,
                  obscureText:
                      obscurePassword,
                  decoration:
                      inputDecoration(
                    hintText:
                        'Enter your password',

                    suffixIcon:
                        IconButton(
                      onPressed: () {
                        setState(() {
                          obscurePassword =
                              !obscurePassword;
                        });
                      },

                      icon: Icon(
                        obscurePassword
                            ? Icons
                                .visibility_outlined
                            : Icons
                                .visibility_off_outlined,
                        color:
                            const Color(
                          0xFF64748B,
                        ),
                        size: 21,
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 17),

                // ==================================================
                // CONFIRM PASSWORD
                // ==================================================

                const Text(
                  'Confirm Password',
                  style: TextStyle(
                    color: Color(0xFF475569),
                    fontSize: 13,
                    fontWeight:
                        FontWeight.w600,
                  ),
                ),

                const SizedBox(height: 8),

                TextField(
                  controller:
                      confirmPasswordController,
                  obscureText:
                      obscureConfirmPassword,
                  decoration:
                      inputDecoration(
                    hintText:
                        'Confirm your password',

                    suffixIcon:
                        IconButton(
                      onPressed: () {
                        setState(() {
                          obscureConfirmPassword =
                              !obscureConfirmPassword;
                        });
                      },

                      icon: Icon(
                        obscureConfirmPassword
                            ? Icons
                                .visibility_outlined
                            : Icons
                                .visibility_off_outlined,
                        color:
                            const Color(
                          0xFF64748B,
                        ),
                        size: 21,
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 27),

                // ==================================================
                // CREATE ACCOUNT
                // ==================================================

                SizedBox(
                  width:
                      double.infinity,
                  height: 50,

                  child: ElevatedButton(
                    onPressed: isLoading
                        ? null
                        : createAccount,

                    style:
                        ElevatedButton.styleFrom(
                      backgroundColor:
                          const Color(
                        0xFF2563EB,
                      ),

                      foregroundColor:
                          Colors.white,

                      disabledBackgroundColor:
                          const Color(
                        0xFF93B4F7,
                      ),

                      elevation: 2,

                      shape:
                          RoundedRectangleBorder(
                        borderRadius:
                            BorderRadius.circular(
                          12,
                        ),
                      ),
                    ),

                    child: isLoading
                        ? const SizedBox(
                            height: 22,
                            width: 22,
                            child:
                                CircularProgressIndicator(
                              color: Colors.white,
                              strokeWidth: 2.5,
                            ),
                          )
                        : const Text(
                            'Create Account',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight:
                                  FontWeight.w600,
                            ),
                          ),
                  ),
                ),

                const SizedBox(height: 25),
              ],
            ),
          ),
        ),
      ),
    );
  }
}