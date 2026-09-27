import 'package:flutter/material.dart';

class StudentDetailsScreen extends StatelessWidget {
  final Map<String, String> student;

  const StudentDetailsScreen({
    super.key,
    required this.student,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:
          const Color(0xFFF8FAFC),

      body: SafeArea(
        child: SingleChildScrollView(
          padding:
              const EdgeInsets.fromLTRB(
            24,
            12,
            24,
            30,
          ),
          child: Column(
            crossAxisAlignment:
                CrossAxisAlignment.start,
            children: [

              // HEADER
              Row(
                children: [

                  GestureDetector(
                    onTap: () =>
                        Navigator.pop(context),
                    child: const Row(
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

                  const Spacer(),

                  TextButton(
                    onPressed: () {
                      Navigator.pop(
                        context,
                        {
                          'action': 'edit',
                        },
                      );
                    },
                    child: const Text(
                      'Edit',
                      style: TextStyle(
                        color:
                            Color(0xFF2563EB),
                        fontSize: 14,
                        fontWeight:
                            FontWeight.w600,
                      ),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 20),

              const Text(
                'Student Details',
                style: TextStyle(
                  fontSize: 28,
                  fontWeight:
                      FontWeight.w700,
                  color:
                      Color(0xFF111827),
                  letterSpacing: -0.6,
                ),
              ),

              const SizedBox(height: 24),

              // PROFILE CARD
              Container(
                width: double.infinity,
                padding:
                    const EdgeInsets.symmetric(
                  vertical: 24,
                  horizontal: 20,
                ),
                decoration:
                    BoxDecoration(
                  color: Colors.white,
                  borderRadius:
                      BorderRadius.circular(
                    20,
                  ),
                  border: Border.all(
                    color:
                        const Color(
                      0xFFE2E8F0,
                    ),
                  ),
                ),
                child: Column(
                  children: [

                    Container(
                      width: 80,
                      height: 80,
                      decoration:
                          const BoxDecoration(
                        color:
                            Color(0xFFEFF6FF),
                        shape:
                            BoxShape.circle,
                      ),
                      alignment:
                          Alignment.center,
                      child: Text(
                        student[
                                'initials'] ??
                            'ST',
                        style:
                            const TextStyle(
                          color:
                              Color(
                            0xFF2563EB,
                          ),
                          fontSize: 27,
                          fontWeight:
                              FontWeight.w700,
                        ),
                      ),
                    ),

                    const SizedBox(height: 16),

                    Text(
                      student['name'] ??
                          '',
                      textAlign:
                          TextAlign.center,
                      style:
                          const TextStyle(
                        fontSize: 22,
                        fontWeight:
                            FontWeight.w700,
                        color:
                            Color(
                          0xFF111827,
                        ),
                      ),
                    ),

                    const SizedBox(height: 5),

                    Text(
                      'ID: ${student['id'] ?? '-'}',
                      style:
                          const TextStyle(
                        color:
                            Color(
                          0xFF2563EB,
                        ),
                        fontSize: 14,
                        fontWeight:
                            FontWeight.w600,
                      ),
                    ),

                    const SizedBox(height: 8),

                    Container(
                      padding:
                          const EdgeInsets
                              .symmetric(
                        horizontal: 12,
                        vertical: 6,
                      ),
                      decoration:
                          BoxDecoration(
                        color:
                            const Color(
                          0xFFEFF6FF,
                        ),
                        borderRadius:
                            BorderRadius
                                .circular(
                          20,
                        ),
                      ),
                      child: Text(
                        student['class'] ??
                            '',
                        style:
                            const TextStyle(
                          color:
                              Color(
                            0xFF2563EB,
                          ),
                          fontSize: 12,
                          fontWeight:
                              FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 24),

              _infoCard(
                title: 'Contact Information',
                children: [
                  _infoItem(
                    'EMAIL ADDRESS',
                    student['email'] ??
                        '-',
                  ),
                  const SizedBox(height: 18),
                  _infoItem(
                    'PHONE NUMBER',
                    student['phone'] ??
                        '-',
                  ),
                ],
              ),

              const SizedBox(height: 20),

              _infoCard(
                title: 'Residential Address',
                children: [
                  _infoItem(
                    'ADDRESS',
                    student['address'] ??
                        '-',
                  ),
                ],
              ),

              const SizedBox(height: 20),

              _infoCard(
                title: 'Account Management',
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: _infoItem(
                          'CREATED ON',
                          student[
                                  'created'] ??
                              '-',
                        ),
                      ),
                      Expanded(
                        child: _infoItem(
                          'LAST UPDATED',
                          student[
                                  'updated'] ??
                              '-',
                        ),
                      ),
                    ],
                  ),
                ],
              ),

              const SizedBox(height: 22),

              // DELETE
              SizedBox(
                width: double.infinity,
                height: 48,
                child:
                    OutlinedButton(
                  onPressed: () {
                    Navigator.pop(
                      context,
                      {
                        'action': 'delete',
                      },
                    );
                  },
                  style:
                      OutlinedButton
                          .styleFrom(
                    foregroundColor:
                        const Color(
                      0xFFDC2626,
                    ),
                    side:
                        const BorderSide(
                      color:
                          Color(0xFFFECACA),
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
                  child: const Text(
                    'Delete Student',
                    style:
                        TextStyle(
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
    );
  }

  Widget _infoCard({
    required String title,
    required List<Widget> children,
  }) {
    return Container(
      width: double.infinity,
      padding:
          const EdgeInsets.all(18),
      decoration:
          BoxDecoration(
        color: Colors.white,
        borderRadius:
            BorderRadius.circular(16),
        border: Border.all(
          color:
              const Color(0xFFE2E8F0),
        ),
      ),
      child: Column(
        crossAxisAlignment:
            CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style:
                const TextStyle(
              fontSize: 16,
              fontWeight:
                  FontWeight.w700,
              color:
                  Color(0xFF1E293B),
            ),
          ),
          const SizedBox(height: 16),
          ...children,
        ],
      ),
    );
  }

  Widget _infoItem(
    String label,
    String value,
  ) {
    return Column(
      crossAxisAlignment:
          CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style:
              const TextStyle(
            color:
                Color(0xFF94A3B8),
            fontSize: 12,
            fontWeight:
                FontWeight.w600,
          ),
        ),
        const SizedBox(height: 5),
        Text(
          value,
          style:
              const TextStyle(
            color:
                Color(0xFF1E293B),
            fontSize: 14,
            fontWeight:
                FontWeight.w500,
            height: 1.4,
          ),
        ),
      ],
    );
  }
}