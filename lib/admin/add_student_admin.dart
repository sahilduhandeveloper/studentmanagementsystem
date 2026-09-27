import 'package:flutter/material.dart';

class AddStudentAdminScreen extends StatefulWidget {
  const AddStudentAdminScreen({super.key});

  @override
  State<AddStudentAdminScreen> createState() =>
      _AddStudentAdminScreenState();
}

class _AddStudentAdminScreenState
    extends State<AddStudentAdminScreen> {
  final GlobalKey<FormState> formKey =
      GlobalKey<FormState>();

  final TextEditingController nameController =
      TextEditingController();

  final TextEditingController emailController =
      TextEditingController();

  final TextEditingController phoneController =
      TextEditingController();

  final TextEditingController addressController =
      TextEditingController();

  String selectedClass = 'Class 12';

  bool isLoading = false;

  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    phoneController.dispose();
    addressController.dispose();
    super.dispose();
  }

  // ============================================================
  // ADD STUDENT
  // ============================================================

  Future<void> addStudent() async {
    FocusScope.of(context).unfocus();

    if (!formKey.currentState!.validate()) {
      return;
    }

    setState(() {
      isLoading = true;
    });

    await Future.delayed(
      const Duration(milliseconds: 700),
    );

    if (!mounted) return;

    final name = nameController.text.trim();
    final email = emailController.text.trim();
    final phone = phoneController.text.trim();
    final address = addressController.text.trim();

    final initials = _getInitials(name);

    final student = <String, String>{
      'initials': initials,
      'name': name,
      'class': selectedClass,
      'email': email,
      'phone': phone,
      'id': 'SMS${DateTime.now().millisecondsSinceEpoch}',
      'address': address,
      'created': _formatDate(DateTime.now()),
      'updated': _formatDate(DateTime.now()),
    };

    setState(() {
      isLoading = false;
    });

    if (!mounted) return;

    Navigator.pop(
      context,
      student,
    );
  }

  // ============================================================
  // INITIALS
  // ============================================================

  String _getInitials(String name) {
    final words = name
        .trim()
        .split(' ')
        .where((word) => word.isNotEmpty)
        .toList();

    if (words.isEmpty) {
      return 'ST';
    }

    if (words.length == 1) {
      return words[0][0].toUpperCase();
    }

    return '${words[0][0]}${words[1][0]}'
        .toUpperCase();
  }

  // ============================================================
  // DATE
  // ============================================================

  String _formatDate(DateTime date) {
    const months = [
      'Jan',
      'Feb',
      'Mar',
      'Apr',
      'May',
      'Jun',
      'Jul',
      'Aug',
      'Sep',
      'Oct',
      'Nov',
      'Dec',
    ];

    return '${months[date.month - 1]} '
        '${date.day}, ${date.year}';
  }

  // ============================================================
  // INPUT DECORATION
  // ============================================================

  InputDecoration inputDecoration({
    required String hintText,
  }) {
    return InputDecoration(
      hintText: hintText,

      hintStyle: const TextStyle(
        color: Color(0xFF94A3B8),
        fontSize: 14,
      ),

      filled: true,
      fillColor: Colors.white,

      contentPadding:
          const EdgeInsets.symmetric(
        horizontal: 15,
        vertical: 15,
      ),

      border: OutlineInputBorder(
        borderRadius:
            BorderRadius.circular(11),
        borderSide: const BorderSide(
          color: Color(0xFFE2E8F0),
        ),
      ),

      enabledBorder: OutlineInputBorder(
        borderRadius:
            BorderRadius.circular(11),
        borderSide: const BorderSide(
          color: Color(0xFFE2E8F0),
        ),
      ),

      focusedBorder: OutlineInputBorder(
        borderRadius:
            BorderRadius.circular(11),
        borderSide: const BorderSide(
          color: Color(0xFF2563EB),
          width: 1.5,
        ),
      ),

      errorBorder: OutlineInputBorder(
        borderRadius:
            BorderRadius.circular(11),
        borderSide: const BorderSide(
          color: Color(0xFFDC2626),
        ),
      ),

      focusedErrorBorder:
          OutlineInputBorder(
        borderRadius:
            BorderRadius.circular(11),
        borderSide: const BorderSide(
          color: Color(0xFFDC2626),
          width: 1.5,
        ),
      ),
    );
  }

  // ============================================================
  // LABEL
  // ============================================================

  Widget fieldLabel(String text) {
    return Text(
      text,
      style: const TextStyle(
        color: Color(0xFF475569),
        fontSize: 13,
        fontWeight: FontWeight.w600,
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
            FocusScope.of(context).unfocus();
          },

          child: SingleChildScrollView(
            keyboardDismissBehavior:
                ScrollViewKeyboardDismissBehavior
                    .onDrag,

            padding:
                const EdgeInsets.fromLTRB(
              24,
              8,
              24,
              30,
            ),

            child: Form(
              key: formKey,

              child: Column(
                crossAxisAlignment:
                    CrossAxisAlignment.start,

                children: [

                  // ==================================================
                  // BACK
                  // ==================================================

                  GestureDetector(
                    onTap: isLoading
                        ? null
                        : () {
                            Navigator.pop(
                              context,
                            );
                          },

                    child: const Row(
                      mainAxisSize:
                          MainAxisSize.min,
                      children: [

                        Icon(
                          Icons
                              .arrow_back_ios_new,
                          size: 16,
                          color:
                              Color(0xFF2563EB),
                        ),

                        SizedBox(width: 5),

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
                    'Add Student',
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight:
                          FontWeight.w700,
                      color:
                          Color(0xFF111827),
                      letterSpacing: -0.6,
                    ),
                  ),

                  const SizedBox(height: 28),

                  // ==================================================
                  // NAME
                  // ==================================================

                  fieldLabel('Student Name'),

                  const SizedBox(height: 8),

                  TextFormField(
                    controller:
                        nameController,

                    textCapitalization:
                        TextCapitalization.words,

                    textInputAction:
                        TextInputAction.next,

                    style: const TextStyle(
                      color:
                          Color(0xFF1E293B),
                      fontSize: 14,
                    ),

                    decoration:
                        inputDecoration(
                      hintText:
                          'e.g. Rahul Kumar',
                    ),

                    validator: (value) {
                      final name =
                          value?.trim() ?? '';

                      if (name.isEmpty) {
                        return 'Please enter student name';
                      }

                      if (name.length < 2) {
                        return 'Please enter a valid name';
                      }

                      return null;
                    },
                  ),

                  const SizedBox(height: 20),

                  // ==================================================
                  // EMAIL
                  // ==================================================

                  fieldLabel('Email Address'),

                  const SizedBox(height: 8),

                  TextFormField(
                    controller:
                        emailController,

                    keyboardType:
                        TextInputType.emailAddress,

                    textInputAction:
                        TextInputAction.next,

                    style: const TextStyle(
                      color:
                          Color(0xFF1E293B),
                      fontSize: 14,
                    ),

                    decoration:
                        inputDecoration(
                      hintText:
                          'e.g. rahul@gmail.com',
                    ),

                    validator: (value) {
                      final email =
                          value?.trim() ?? '';

                      if (email.isEmpty) {
                        return 'Please enter email';
                      }

                      final regex = RegExp(
                        r'^[\w\.-]+@[\w\.-]+\.\w+$',
                      );

                      if (!regex.hasMatch(
                        email,
                      )) {
                        return 'Please enter a valid email';
                      }

                      return null;
                    },
                  ),

                  const SizedBox(height: 20),

                  // ==================================================
                  // PHONE
                  // ==================================================

                  fieldLabel('Phone Number'),

                  const SizedBox(height: 8),

                  TextFormField(
                    controller:
                        phoneController,

                    keyboardType:
                        TextInputType.phone,

                    textInputAction:
                        TextInputAction.next,

                    style: const TextStyle(
                      color:
                          Color(0xFF1E293B),
                      fontSize: 14,
                    ),

                    decoration:
                        inputDecoration(
                      hintText:
                          'e.g. +91 98765 43210',
                    ),

                    validator: (value) {
                      final phone =
                          value?.trim() ?? '';

                      if (phone.isEmpty) {
                        return 'Please enter phone number';
                      }

                      final digits =
                          phone.replaceAll(
                        RegExp(r'\D'),
                        '',
                      );

                      if (digits.length < 10) {
                        return 'Please enter a valid phone number';
                      }

                      return null;
                    },
                  ),

                  const SizedBox(height: 20),

                  // ==================================================
                  // CLASS
                  // ==================================================

                  fieldLabel('Class'),

                  const SizedBox(height: 8),

                  Container(
                    height: 50,

                    padding:
                        const EdgeInsets.symmetric(
                      horizontal: 14,
                    ),

                    decoration:
                        BoxDecoration(
                      color: Colors.white,
                      borderRadius:
                          BorderRadius.circular(
                        11,
                      ),
                      border: Border.all(
                        color:
                            const Color(
                          0xFFE2E8F0,
                        ),
                      ),
                    ),

                    child:
                        DropdownButtonHideUnderline(
                      child:
                          DropdownButton<String>(
                        value: selectedClass,

                        isExpanded: true,

                        icon: const Icon(
                          Icons
                              .keyboard_arrow_down,
                          color:
                              Color(0xFF64748B),
                        ),

                        style:
                            const TextStyle(
                          color:
                              Color(0xFF1E293B),
                          fontSize: 14,
                        ),

                        items: const [
                          DropdownMenuItem(
                            value: 'Class 10',
                            child:
                                Text('Class 10'),
                          ),
                          DropdownMenuItem(
                            value: 'Class 11',
                            child:
                                Text('Class 11'),
                          ),
                          DropdownMenuItem(
                            value: 'Class 12',
                            child:
                                Text('Class 12'),
                          ),
                        ],

                        onChanged: (value) {
                          if (value == null) {
                            return;
                          }

                          setState(() {
                            selectedClass =
                                value;
                          });
                        },
                      ),
                    ),
                  ),

                  const SizedBox(height: 20),

                  // ==================================================
                  // ADDRESS
                  // ==================================================

                  fieldLabel('Address'),

                  const SizedBox(height: 8),

                  TextFormField(
                    controller:
                        addressController,

                    maxLines: 4,

                    textCapitalization:
                        TextCapitalization.sentences,

                    style: const TextStyle(
                      color:
                          Color(0xFF1E293B),
                      fontSize: 14,
                    ),

                    decoration:
                        inputDecoration(
                      hintText:
                          'Enter complete residential address...',
                    ),

                    validator: (value) {
                      if (value == null ||
                          value.trim().isEmpty) {
                        return 'Please enter address';
                      }

                      return null;
                    },
                  ),

                  const SizedBox(height: 28),

                  // ==================================================
                  // ADD BUTTON
                  // ==================================================

                  SizedBox(
                    width: double.infinity,
                    height: 50,

                    child:
                        ElevatedButton(
                      onPressed:
                          isLoading
                              ? null
                              : addStudent,

                      style:
                          ElevatedButton
                              .styleFrom(
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

                        shadowColor:
                            const Color(
                          0x332563EB,
                        ),

                        shape:
                            RoundedRectangleBorder(
                          borderRadius:
                              BorderRadius
                                  .circular(
                            11,
                          ),
                        ),
                      ),

                      child: isLoading
                          ? const SizedBox(
                              width: 21,
                              height: 21,
                              child:
                                  CircularProgressIndicator(
                                strokeWidth:
                                    2.5,
                                color:
                                    Colors.white,
                              ),
                            )
                          : const Text(
                              'Add Student',
                              style:
                                  TextStyle(
                                fontSize: 16,
                                fontWeight:
                                    FontWeight.w600,
                              ),
                            ),
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