import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'register_screen.dart';
import '../authentication/screen_forgot_password.dart';
import '../admin/admin_dashboard_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() =>
      _LoginScreenState();
}

class _LoginScreenState
    extends State<LoginScreen> {

  // ============================================================
  // CONTROLLERS
  // ============================================================

  final TextEditingController emailController =
      TextEditingController();

  final TextEditingController passwordController =
      TextEditingController();

  // ============================================================
  // VARIABLES
  // ============================================================

  bool obscurePassword = true;
  bool isLoading = false;

  // ============================================================
  // EXISTING ADMIN LOGIN
  // ============================================================

  static const String adminEmail =
      'sahil@gmail.com';

  static const String adminPassword =
      'sahil123';

  // ============================================================
  // DISPOSE
  // ============================================================

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  // ============================================================
  // LOGIN
  // ============================================================

  Future<void> login() async {
    FocusScope.of(context).unfocus();

    final String email =
        emailController.text
            .trim()
            .toLowerCase();

    final String password =
        passwordController.text.trim();

    // ==========================================================
    // EMPTY EMAIL
    // ==========================================================

    if (email.isEmpty) {
      _showMessage(
        'Please enter your email',
      );
      return;
    }

    // ==========================================================
    // EMPTY PASSWORD
    // ==========================================================

    if (password.isEmpty) {
      _showMessage(
        'Please enter your password',
      );
      return;
    }

    setState(() {
      isLoading = true;
    });

    // ==========================================================
    // SMALL LOADING DELAY
    // ==========================================================

    await Future.delayed(
      const Duration(milliseconds: 500),
    );

    if (!mounted) return;

    // ==========================================================
    // CHECK DEFAULT ADMIN ACCOUNT
    // ==========================================================

    if (email == adminEmail &&
        password == adminPassword) {
      _openDashboard();
      return;
    }

    // ==========================================================
    // CHECK REGISTERED ACCOUNTS
    // ==========================================================

    try {
      final prefs =
          await SharedPreferences.getInstance();

      final String savedAccounts =
          prefs.getString(
                'registered_accounts',
              ) ??
              '[]';

      final List<dynamic> accounts =
          jsonDecode(savedAccounts);

      Map<String, dynamic>? matchedAccount;

      for (final account in accounts) {
        if (account['email'] == email &&
            account['password'] ==
                password) {
          matchedAccount =
              Map<String, dynamic>.from(
            account,
          );
          break;
        }
      }

      if (!mounted) return;

      if (matchedAccount != null) {
        _openDashboard();
        return;
      }

      setState(() {
        isLoading = false;
      });

      _showMessage(
        'Invalid email or password',
      );
    } catch (e) {
      if (!mounted) return;

      setState(() {
        isLoading = false;
      });

      _showMessage(
        'Something went wrong. Please try again.',
      );
    }
  }

  // ============================================================
  // OPEN DASHBOARD
  // ============================================================

  void _openDashboard() {
    if (!mounted) return;

    setState(() {
      isLoading = false;
    });

    Navigator.of(context).pushAndRemoveUntil(
      MaterialPageRoute(
        builder: (context) =>
            const AdminDashboardScreen(),
      ),
      (route) => false,
    );
  }

  // ============================================================
  // MESSAGE
  // ============================================================

  void _showMessage(
    String message, {
    bool isError = true,
  }) {
    ScaffoldMessenger.of(context)
        .hideCurrentSnackBar();

    ScaffoldMessenger.of(context)
        .showSnackBar(
      SnackBar(
        content: Text(
          message,
          style: const TextStyle(
            fontSize: 14,
            fontWeight:
                FontWeight.w500,
          ),
        ),

        backgroundColor: isError
            ? const Color(0xFFDC2626)
            : const Color(0xFF16A34A),

        behavior:
            SnackBarBehavior.floating,

        margin:
            const EdgeInsets.all(16),

        shape:
            RoundedRectangleBorder(
          borderRadius:
              BorderRadius.circular(12),
        ),
      ),
    );
  }

  // ============================================================
  // FORGOT PASSWORD
  // ============================================================

  void forgotPassword() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) =>
            const ForgotPasswordScreen(),
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

      enabledBorder:
          OutlineInputBorder(
        borderRadius:
            BorderRadius.circular(12),
        borderSide: const BorderSide(
          color: Color(0xFFE2E8F0),
        ),
      ),

      focusedBorder:
          OutlineInputBorder(
        borderRadius:
            BorderRadius.circular(12),
        borderSide: const BorderSide(
          color: Color(0xFF2563EB),
          width: 1.5,
        ),
      ),

      errorBorder:
          OutlineInputBorder(
        borderRadius:
            BorderRadius.circular(12),
        borderSide: const BorderSide(
          color: Color(0xFFDC2626),
        ),
      ),

      focusedErrorBorder:
          OutlineInputBorder(
        borderRadius:
            BorderRadius.circular(12),
        borderSide: const BorderSide(
          color: Color(0xFFDC2626),
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
        child: GestureDetector(
          onTap: () {
            FocusScope.of(context)
                .unfocus();
          },

          child: SingleChildScrollView(
            keyboardDismissBehavior:
                ScrollViewKeyboardDismissBehavior
                    .onDrag,

            child: Padding(
              padding:
                  const EdgeInsets.symmetric(
                horizontal: 24,
              ),

              child: Column(
                crossAxisAlignment:
                    CrossAxisAlignment.start,

                children: [

                  const SizedBox(height: 45),

                  // ==================================================
                  // TITLE
                  // ==================================================

                  const Text(
                    'Welcome Back',
                    style: TextStyle(
                      color:
                          Color(0xFF111827),
                      fontSize: 28,
                      fontWeight:
                          FontWeight.w700,
                      letterSpacing: -0.6,
                    ),
                  ),

                  const SizedBox(height: 7),

                  const Text(
                    'Login to manage your students',
                    style: TextStyle(
                      color:
                          Color(0xFF64748B),
                      fontSize: 15,
                    ),
                  ),

                  const SizedBox(height: 35),

                  // ==================================================
                  // EMAIL
                  // ==================================================

                  const Text(
                    'Email Address',
                    style: TextStyle(
                      color:
                          Color(0xFF475569),
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

                    textInputAction:
                        TextInputAction.next,

                    decoration:
                        inputDecoration(
                      hintText:
                          'Enter your email address',
                    ),
                  ),

                  const SizedBox(height: 20),

                  // ==================================================
                  // PASSWORD
                  // ==================================================

                  const Text(
                    'Password',
                    style: TextStyle(
                      color:
                          Color(0xFF475569),
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

                    textInputAction:
                        TextInputAction.done,

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

                    onSubmitted: (_) {
                      login();
                    },
                  ),

                  const SizedBox(height: 10),

                  // ==================================================
                  // FORGOT PASSWORD
                  // ==================================================

                  Align(
                    alignment:
                        Alignment.centerRight,

                    child:
                        GestureDetector(
                      onTap:
                          forgotPassword,

                      child: const Text(
                        'Forgot Password?',

                        style: TextStyle(
                          color:
                              Color(0xFF2563EB),
                          fontSize: 14,
                          fontWeight:
                              FontWeight.w500,
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(height: 20),

                  // ==================================================
                  // LOGIN BUTTON
                  // ==================================================

                  SizedBox(
                    width:
                        double.infinity,

                    height: 50,

                    child:
                        ElevatedButton(
                      onPressed:
                          isLoading
                              ? null
                              : login,

                      style:
                          ElevatedButton.styleFrom(
                        backgroundColor:
                            const Color(
                          0xFF2563EB,
                        ),

                        disabledBackgroundColor:
                            const Color(
                          0xFF93B4F7,
                        ),

                        foregroundColor:
                            Colors.white,

                        elevation: 2,

                        shape:
                            RoundedRectangleBorder(
                          borderRadius:
                              BorderRadius
                                  .circular(12),
                        ),
                      ),

                      child: isLoading
                          ? const SizedBox(
                              width: 22,
                              height: 22,
                              child:
                                  CircularProgressIndicator(
                                strokeWidth:
                                    2.5,
                                color:
                                    Colors.white,
                              ),
                            )
                          : const Text(
                              'Login',
                              style:
                                  TextStyle(
                                fontSize: 16,
                                fontWeight:
                                    FontWeight.w600,
                              ),
                            ),
                    ),
                  ),

                  const SizedBox(height: 25),

                  // ==================================================
                  // REGISTER
                  // ==================================================

                  Center(
                    child:
                        GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder:
                                (context) =>
                                    const RegisterScreen(),
                          ),
                        );
                      },

                      child: RichText(
                        text:
                            const TextSpan(
                          text:
                              "Don't have an account? ",

                          style: TextStyle(
                            color:
                                Color(0xFF64748B),
                            fontSize: 14,
                          ),

                          children: [
                            TextSpan(
                              text:
                                  'Register',

                              style:
                                  TextStyle(
                                color:
                                    Color(
                                  0xFF2563EB,
                                ),
                                fontWeight:
                                    FontWeight
                                        .w600,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(height: 30),
                ],
              ),
            ),
          ),
        ),
        
      ),
    );
  }
}