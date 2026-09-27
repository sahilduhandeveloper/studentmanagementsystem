import 'package:flutter/material.dart';
import 'screen_otp.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  State<ForgotPasswordScreen> createState() =>
      _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState
    extends State<ForgotPasswordScreen> {
  final TextEditingController emailController =
      TextEditingController();

  final GlobalKey<FormState> formKey =
      GlobalKey<FormState>();

  bool isLoading = false;

  @override
  void dispose() {
    emailController.dispose();
    super.dispose();
  }

  Future<void> sendOtp() async {
  FocusScope.of(context).unfocus();

  if (!formKey.currentState!.validate()) {
    return;
  }

  setState(() {
    isLoading = true;
  });

  // Abhi testing ke liye delay.
  // Baad mein yahin Forgot Password API lagegi.
  await Future.delayed(
    const Duration(seconds: 1),
  );

  if (!mounted) return;

  setState(() {
    isLoading = false;
  });

  // OTP Screen par jao
  Navigator.push(
    context,
    MaterialPageRoute(
      builder: (context) => const OtpScreen(),
    ),
  );
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8FAFC),

      body: SafeArea(
        child: GestureDetector(
          onTap: () {
            FocusScope.of(context).unfocus();
          },

          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 24,
              ),

              child: Form(
                key: formKey,

                child: Column(
                  crossAxisAlignment:
                      CrossAxisAlignment.start,

                  children: [

                    // ----------------------------------------
                    // TOP SPACE
                    // ----------------------------------------

                    const SizedBox(height: 25),

                    // ----------------------------------------
                    // BACK
                    // ----------------------------------------

                    GestureDetector(
                      onTap: () {
                        Navigator.pop(context);
                      },

                      child: const Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(
                            Icons.chevron_left,
                            color: Color(0xFF2563EB),
                            size: 22,
                          ),

                          SizedBox(width: 2),

                          Text(
                            'Back',
                            style: TextStyle(
                              color: Color(0xFF2563EB),
                              fontSize: 14,
                              fontWeight:
                                  FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 25),

                    // ----------------------------------------
                    // TITLE
                    // ----------------------------------------

                    const Text(
                      'Forgot Password?',
                      style: TextStyle(
                        color: Color(0xFF111827),
                        fontSize: 28,
                        fontWeight: FontWeight.w700,
                        letterSpacing: -0.6,
                      ),
                    ),

                    const SizedBox(height: 8),

                    // ----------------------------------------
                    // SUBTITLE
                    // ----------------------------------------

                    const Text(
                      'Enter your registered email and we\'ll send you a\nverification code.',
                      style: TextStyle(
                        color: Color(0xFF64748B),
                        fontSize: 15,
                        height: 1.45,
                        fontWeight: FontWeight.w400,
                      ),
                    ),

                    const SizedBox(height: 34),

                    // ----------------------------------------
                    // EMAIL LABEL
                    // ----------------------------------------

                    const Text(
                      'Email Address',
                      style: TextStyle(
                        color: Color(0xFF475569),
                        fontSize: 13,
                        fontWeight: FontWeight.w600,
                      ),
                    ),

                    const SizedBox(height: 8),

                    // ----------------------------------------
                    // EMAIL FIELD
                    // ----------------------------------------

                    TextFormField(
                      controller: emailController,

                      keyboardType:
                          TextInputType.emailAddress,

                      textInputAction:
                          TextInputAction.done,

                      style: const TextStyle(
                        color: Color(0xFF1E293B),
                        fontSize: 15,
                      ),

                      decoration: InputDecoration(
                        hintText:
                            'your-email@edu.com',

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

                        border:
                            OutlineInputBorder(
                          borderRadius:
                              BorderRadius.circular(12),
                          borderSide:
                              const BorderSide(
                            color: Color(0xFFE2E8F0),
                          ),
                        ),

                        enabledBorder:
                            OutlineInputBorder(
                          borderRadius:
                              BorderRadius.circular(12),
                          borderSide:
                              const BorderSide(
                            color: Color(0xFFE2E8F0),
                          ),
                        ),

                        focusedBorder:
                            OutlineInputBorder(
                          borderRadius:
                              BorderRadius.circular(12),
                          borderSide:
                              const BorderSide(
                            color: Color(0xFF2563EB),
                            width: 1.5,
                          ),
                        ),

                        errorBorder:
                            OutlineInputBorder(
                          borderRadius:
                              BorderRadius.circular(12),
                          borderSide:
                              const BorderSide(
                            color: Color(0xFFDC2626),
                          ),
                        ),

                        focusedErrorBorder:
                            OutlineInputBorder(
                          borderRadius:
                              BorderRadius.circular(12),
                          borderSide:
                              const BorderSide(
                            color: Color(0xFFDC2626),
                            width: 1.5,
                          ),
                        ),
                      ),

                      validator: (value) {
                        final email =
                            value?.trim() ?? '';

                        if (email.isEmpty) {
                          return 'Please enter your email';
                        }

                        final emailRegex = RegExp(
                          r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$',
                        );

                        if (!emailRegex.hasMatch(email)) {
                          return 'Please enter a valid email';
                        }

                        return null;
                      },

                      onFieldSubmitted: (_) {
                        sendOtp();
                      },
                    ),

                    const SizedBox(height: 24),

                    // ----------------------------------------
                    // SEND OTP BUTTON
                    // ----------------------------------------

                    SizedBox(
                      width: double.infinity,
                      height: 50,

                      child: ElevatedButton(
                        onPressed:
                            isLoading ? null : sendOtp,

                        style:
                            ElevatedButton.styleFrom(
                          backgroundColor:
                              const Color(0xFF2563EB),

                          disabledBackgroundColor:
                              const Color(0xFF93B4F7),

                          foregroundColor:
                              Colors.white,

                          elevation: 2,

                          shadowColor:
                              const Color(0x332563EB),

                          shape:
                              RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.circular(12),
                          ),
                        ),

                        child: isLoading
                            ? const SizedBox(
                                width: 22,
                                height: 22,

                                child:
                                    CircularProgressIndicator(
                                  strokeWidth: 2.5,
                                  color: Colors.white,
                                ),
                              )
                            : const Text(
                                'Send OTP',
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight:
                                      FontWeight.w600,
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
      ),
    );
  }
}