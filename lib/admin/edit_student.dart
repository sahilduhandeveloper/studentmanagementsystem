import 'package:flutter/material.dart';

class EditStudentScreen extends StatefulWidget {
  final Map<String, String> student;

  const EditStudentScreen({
    super.key,
    required this.student,
  });

  @override
  State<EditStudentScreen> createState() =>
      _EditStudentScreenState();
}

class _EditStudentScreenState
    extends State<EditStudentScreen> {
  final GlobalKey<FormState> formKey =
      GlobalKey<FormState>();

  late TextEditingController nameController;
  late TextEditingController emailController;
  late TextEditingController phoneController;
  late TextEditingController addressController;

  late String selectedClass;

  bool isLoading = false;

  @override
  void initState() {
    super.initState();

    nameController = TextEditingController(
      text: widget.student['name'] ?? '',
    );

    emailController = TextEditingController(
      text: widget.student['email'] ?? '',
    );

    phoneController = TextEditingController(
      text: widget.student['phone'] ?? '',
    );

    addressController = TextEditingController(
      text: widget.student['address'] ?? '',
    );

    selectedClass =
        widget.student['class'] ?? 'Class 12';
  }

  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    phoneController.dispose();
    addressController.dispose();
    super.dispose();
  }

  String _getInitials(String name) {
    final words = name
        .trim()
        .split(' ')
        .where((e) => e.isNotEmpty)
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

  Future<void> updateStudent() async {
    FocusScope.of(context).unfocus();

    if (!formKey.currentState!.validate()) {
      return;
    }

    setState(() {
      isLoading = true;
    });

    await Future.delayed(
      const Duration(milliseconds: 600),
    );

    if (!mounted) return;

    final updated = Map<String, String>.from(
      widget.student,
    );

    updated['initials'] =
        _getInitials(nameController.text.trim());

    updated['name'] =
        nameController.text.trim();

    updated['email'] =
        emailController.text.trim();

    updated['phone'] =
        phoneController.text.trim();

    updated['class'] =
        selectedClass;

    updated['address'] =
        addressController.text.trim();

    updated['updated'] =
        _formatDate(DateTime.now());

    Navigator.pop(
      context,
      updated,
    );
  }

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

  InputDecoration inputDecoration(
    String hint,
  ) {
    return InputDecoration(
      hintText: hint,
      hintStyle: const TextStyle(
        color:
            Color(0xFF94A3B8),
        fontSize: 14,
      ),
      filled: true,
      fillColor: Colors.white,
      contentPadding:
          const EdgeInsets.symmetric(
        horizontal: 15,
        vertical: 15,
      ),
      border:
          OutlineInputBorder(
        borderRadius:
            BorderRadius.circular(11),
        borderSide:
            const BorderSide(
          color:
              Color(0xFFE2E8F0),
        ),
      ),
      enabledBorder:
          OutlineInputBorder(
        borderRadius:
            BorderRadius.circular(11),
        borderSide:
            const BorderSide(
          color:
              Color(0xFFE2E8F0),
        ),
      ),
      focusedBorder:
          OutlineInputBorder(
        borderRadius:
            BorderRadius.circular(11),
        borderSide:
            const BorderSide(
          color:
              Color(0xFF2563EB),
          width: 1.5,
        ),
      ),
      errorBorder:
          OutlineInputBorder(
        borderRadius:
            BorderRadius.circular(11),
        borderSide:
            const BorderSide(
          color:
              Color(0xFFDC2626),
        ),
      ),
    );
  }

  Widget label(String text) {
    return Text(
      text,
      style: const TextStyle(
        color:
            Color(0xFF475569),
        fontSize: 13,
        fontWeight:
            FontWeight.w600,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:
          const Color(0xFFF8FAFC),

      body: SafeArea(
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

                GestureDetector(
                  onTap: isLoading
                      ? null
                      : () =>
                          Navigator.pop(
                            context,
                          ),
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

                const Text(
                  'Edit Student',
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

                label('Student Name'),
                const SizedBox(height: 8),

                TextFormField(
                  controller:
                      nameController,
                  textCapitalization:
                      TextCapitalization.words,
                  decoration:
                      inputDecoration(
                    'Student name',
                  ),
                  validator: (value) {
                    if (value == null ||
                        value.trim().isEmpty) {
                      return 'Please enter student name';
                    }
                    return null;
                  },
                ),

                const SizedBox(height: 20),

                label('Email Address'),
                const SizedBox(height: 8),

                TextFormField(
                  controller:
                      emailController,
                  keyboardType:
                      TextInputType.emailAddress,
                  decoration:
                      inputDecoration(
                    'Email address',
                  ),
                  validator: (value) {
                    final email =
                        value?.trim() ?? '';

                    if (email.isEmpty) {
                      return 'Please enter email';
                    }

                    final regex =
                        RegExp(
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

                label('Phone Number'),
                const SizedBox(height: 8),

                TextFormField(
                  controller:
                      phoneController,
                  keyboardType:
                      TextInputType.phone,
                  decoration:
                      inputDecoration(
                    'Phone number',
                  ),
                  validator: (value) {
                    final digits =
                        (value ?? '')
                            .replaceAll(
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

                label('Class'),
                const SizedBox(height: 8),

                Container(
                  height: 50,
                  padding:
                      const EdgeInsets
                          .symmetric(
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

                label('Address'),
                const SizedBox(height: 8),

                TextFormField(
                  controller:
                      addressController,
                  maxLines: 4,
                  decoration:
                      inputDecoration(
                    'Complete residential address',
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

                SizedBox(
                  width: double.infinity,
                  height: 50,
                  child:
                      ElevatedButton(
                    onPressed:
                        isLoading
                            ? null
                            : updateStudent,
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
                      shape:
                          RoundedRectangleBorder(
                        borderRadius:
                            BorderRadius.circular(
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
                              strokeWidth: 2.5,
                              color:
                                  Colors.white,
                            ),
                          )
                        : const Text(
                            'Update Student',
                            style:
                                TextStyle(
                              fontSize: 16,
                              fontWeight:
                                  FontWeight.w600,
                            ),
                          ),
                  ),
                ),

                const SizedBox(height: 18),

                Center(
                  child: TextButton(
                    onPressed: isLoading
                        ? null
                        : () {
                            Navigator.pop(
                              context,
                              {
                                'action':
                                    'delete',
                              },
                            );
                          },
                    child: const Text(
                      'Delete Student',
                      style: TextStyle(
                        color:
                            Color(0xFFDC2626),
                        fontSize: 14,
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
    );
  }
}