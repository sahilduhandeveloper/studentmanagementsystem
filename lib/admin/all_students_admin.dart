import 'package:flutter/material.dart';
import 'student_details.dart';
import 'add_student_admin.dart';
import 'edit_student.dart';

class AllStudentsAdminScreen extends StatefulWidget {
  final bool openFilterAutomatically;

  const AllStudentsAdminScreen({
    super.key,
    this.openFilterAutomatically = false,
  });

  @override
  State<AllStudentsAdminScreen> createState() =>
      _AllStudentsAdminScreenState();
}

class _AllStudentsAdminScreenState
    extends State<AllStudentsAdminScreen> {

  final TextEditingController searchController =
      TextEditingController();

  String searchText = '';
  String selectedClass = 'All';

  // ============================================================
  // INIT STATE
  // ============================================================

  @override
  void initState() {
    super.initState();

    if (widget.openFilterAutomatically) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (mounted) {
          showFilterSheet();
        }
      });
    }
  }

  // ============================================================
  // STUDENTS
  // ============================================================

  final List<Map<String, String>> students = [
    {
      'initials': 'RK',
      'name': 'Rahul Kumar',
      'class': 'Class 12',
      'email': 'rahul@gmail.com',
      'phone': '+91 98765 43210',
      'id': 'SMS2026042',
      'address':
          '123 Main Street, Sector 4, Salt Lake, Kolkata, West Bengal - 700091',
      'created': 'Jan 15, 2026',
      'updated': 'Feb 20, 2026',
    },
    {
      'initials': 'AS',
      'name': 'Aditi Sharma',
      'class': 'Class 11',
      'email': 'aditi@gmail.com',
      'phone': '+91 98765 43211',
      'id': 'SMS2026043',
      'address':
          '45 Green Park, New Delhi, Delhi - 110016',
      'created': 'Jan 18, 2026',
      'updated': 'Feb 22, 2026',
    },
    {
      'initials': 'PP',
      'name': 'Priya Patel',
      'class': 'Class 12',
      'email': 'priya@gmail.com',
      'phone': '+91 98765 43212',
      'id': 'SMS2026044',
      'address':
          '21 MG Road, Ahmedabad, Gujarat - 380001',
      'created': 'Jan 20, 2026',
      'updated': 'Feb 24, 2026',
    },
    {
      'initials': 'AS',
      'name': 'Amit Singh',
      'class': 'Class 12',
      'email': 'amit@gmail.com',
      'phone': '+91 98765 43213',
      'id': 'SMS2026045',
      'address':
          '12 Model Town, Chandigarh - 160019',
      'created': 'Jan 25, 2026',
      'updated': 'Feb 25, 2026',
    },
    {
      'initials': 'NS',
      'name': 'Neha Sharma',
      'class': 'Class 11',
      'email': 'neha@gmail.com',
      'phone': '+91 98765 43214',
      'id': 'SMS2026046',
      'address':
          '78 Civil Lines, Jaipur, Rajasthan - 302006',
      'created': 'Jan 28, 2026',
      'updated': 'Feb 27, 2026',
    },
  ];

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  List<Map<String, String>> get filteredStudents {
    final query = searchText.toLowerCase().trim();

    return students.where((student) {
      final matchesSearch =
          student['name']!
                  .toLowerCase()
                  .contains(query) ||
              student['email']!
                  .toLowerCase()
                  .contains(query) ||
              student['phone']!
                  .toLowerCase()
                  .contains(query) ||
              student['id']!
                  .toLowerCase()
                  .contains(query);

      final matchesClass =
          selectedClass == 'All' ||
              student['class'] == selectedClass;

      return matchesSearch && matchesClass;
    }).toList();
  }

  // ============================================================
  // ADD STUDENT
  // ============================================================

  Future<void> addStudent() async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) =>
            const AddStudentAdminScreen(),
      ),
    );

    if (result == null) return;

    final newStudent =
        Map<String, String>.from(result);

    setState(() {
      students.insert(0, newStudent);
    });

    _showMessage(
      'Student added successfully',
      const Color(0xFF16A34A),
    );
  }

  // ============================================================
  // EDIT STUDENT
  // ============================================================

  Future<void> editStudent(
    Map<String, String> student,
  ) async {
    final index = students.indexOf(student);

    if (index == -1) return;

    final result = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) =>
            EditStudentScreen(
          student: Map<String, String>.from(student),
        ),
      ),
    );

    if (result == null) return;

    final updatedStudent =
        Map<String, String>.from(result);

    setState(() {
      students[index] = updatedStudent;
    });

    _showMessage(
      'Student updated successfully',
      const Color(0xFF2563EB),
    );
  }

  // ============================================================
  // DELETE STUDENT
  // ============================================================

  Future<void> deleteStudent(
    Map<String, String> student,
  ) async {
    final shouldDelete =
        await showDialog<bool>(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius:
                BorderRadius.circular(18),
          ),
          title: const Text(
            'Delete Student?',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w700,
              color: Color(0xFF111827),
            ),
          ),
          content: Text(
            'Are you sure you want to delete ${student['name']}? This action cannot be undone.',
            style: const TextStyle(
              fontSize: 14,
              height: 1.5,
              color: Color(0xFF64748B),
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context, false);
              },
              child: const Text(
                'Cancel',
                style: TextStyle(
                  color: Color(0xFF64748B),
                ),
              ),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context, true);
              },
              style:
                  ElevatedButton.styleFrom(
                backgroundColor:
                    const Color(0xFFDC2626),
                foregroundColor: Colors.white,
                elevation: 0,
                shape:
                    RoundedRectangleBorder(
                  borderRadius:
                      BorderRadius.circular(9),
                ),
              ),
              child: const Text(
                'Delete',
              ),
            ),
          ],
        );
      },
    );

    if (shouldDelete != true) return;

    setState(() {
      students.remove(student);
    });

    _showMessage(
      'Student deleted successfully',
      const Color(0xFFDC2626),
    );
  }

  // ============================================================
  // DETAILS
  // ============================================================

  Future<void> openStudentDetails(
    Map<String, String> student,
  ) async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) =>
            StudentDetailsScreen(
          student: student,
        ),
      ),
    );

    if (result == null) return;

    if (result is Map) {
      final action = result['action'];

      if (action == 'edit') {
        await editStudent(student);
      }

      if (action == 'delete') {
        await deleteStudent(student);
      }
    }
  }

  // ============================================================
  // FILTER
  // ============================================================

  void showFilterSheet() {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(22),
        ),
      ),
      builder: (context) {
        return SafeArea(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(
              20,
              20,
              20,
              25,
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment:
                  CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment:
                      MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'Filter Students',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight:
                            FontWeight.w700,
                        color:
                            Color(0xFF111827),
                      ),
                    ),
                    IconButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      icon: const Icon(
                        Icons.close,
                        color:
                            Color(0xFF64748B),
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 10),

                const Text(
                  'Select Class',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight:
                        FontWeight.w600,
                    color:
                        Color(0xFF475569),
                  ),
                ),

                const SizedBox(height: 12),

                Wrap(
                  spacing: 10,
                  runSpacing: 10,
                  children: [
                    _filterOption('All'),
                    _filterOption('Class 10'),
                    _filterOption('Class 11'),
                    _filterOption('Class 12'),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _filterOption(String value) {
    final isSelected =
        selectedClass == value;

    return GestureDetector(
      onTap: () {
        setState(() {
          selectedClass = value;
        });

        Navigator.pop(context);
      },
      child: Container(
        padding:
            const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 10,
        ),
        decoration: BoxDecoration(
          color: isSelected
              ? const Color(0xFFEFF6FF)
              : Colors.white,
          borderRadius:
              BorderRadius.circular(10),
          border: Border.all(
            color: isSelected
                ? const Color(0xFF2563EB)
                : const Color(0xFFE2E8F0),
          ),
        ),
        child: Text(
          value,
          style: TextStyle(
            color: isSelected
                ? const Color(0xFF2563EB)
                : const Color(0xFF475569),
            fontSize: 13,
            fontWeight:
                FontWeight.w600,
          ),
        ),
      ),
    );
  }

  // ============================================================
  // MESSAGE
  // ============================================================

  void _showMessage(
    String message,
    Color color,
  ) {
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(
        SnackBar(
          content: Text(message),
          backgroundColor: color,
          behavior:
              SnackBarBehavior.floating,
          margin: const EdgeInsets.all(16),
          shape: RoundedRectangleBorder(
            borderRadius:
                BorderRadius.circular(10),
          ),
        ),
      );
  }

  // ============================================================
  // BUILD
  // ============================================================

  @override
  Widget build(BuildContext context) {
    final list = filteredStudents;

    return Scaffold(
      backgroundColor:
          const Color(0xFFF8FAFC),

      body: SafeArea(
        child: SingleChildScrollView(
          padding:
              const EdgeInsets.fromLTRB(
            24,
            20,
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
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: const Icon(
                      Icons.arrow_back_ios_new,
                      size: 20,
                      color:
                          Color(0xFF2563EB),
                    ),
                  ),

                  const SizedBox(width: 12),

                  const Expanded(
                    child: Text(
                      'All Students',
                      style: TextStyle(
                        fontSize: 27,
                        fontWeight:
                            FontWeight.w700,
                        color:
                            Color(0xFF111827),
                        letterSpacing: -0.6,
                      ),
                    ),
                  ),

                  GestureDetector(
                    onTap: addStudent,
                    child: Container(
                      width: 42,
                      height: 42,
                      decoration:
                          const BoxDecoration(
                        color:
                            Color(0xFF2563EB),
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(
                        Icons.add,
                        color: Colors.white,
                        size: 23,
                      ),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 24),

              // SEARCH
              Container(
                height: 50,
                decoration:
                    BoxDecoration(
                  color: Colors.white,
                  borderRadius:
                      BorderRadius.circular(12),
                  border: Border.all(
                    color:
                        const Color(0xFFE2E8F0),
                  ),
                ),
                child: TextField(
                  controller:
                      searchController,
                  onChanged: (value) {
                    setState(() {
                      searchText = value;
                    });
                  },
                  style:
                      const TextStyle(
                    color:
                        Color(0xFF1E293B),
                    fontSize: 14,
                  ),
                  decoration:
                      const InputDecoration(
                    border:
                        InputBorder.none,
                    prefixIcon: Icon(
                      Icons.search,
                      color:
                          Color(0xFF94A3B8),
                    ),
                    hintText:
                        'Search student by name, email, phone...',
                    hintStyle:
                        TextStyle(
                      color:
                          Color(0xFF94A3B8),
                      fontSize: 14,
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 14),

              // FILTER
              SingleChildScrollView(
                scrollDirection:
                    Axis.horizontal,
                child: Row(
                  children: [
                    GestureDetector(
                      onTap:
                          showFilterSheet,
                      child: Container(
                        padding:
                            const EdgeInsets
                                .symmetric(
                          horizontal: 13,
                          vertical: 9,
                        ),
                        decoration:
                            BoxDecoration(
                          color:
                              Colors.white,
                          borderRadius:
                              BorderRadius
                                  .circular(
                            20,
                          ),
                          border: Border.all(
                            color:
                                const Color(
                              0xFFE2E8F0,
                            ),
                          ),
                        ),
                        child: const Row(
                          children: [
                            Icon(
                              Icons.tune,
                              size: 16,
                              color:
                                  Color(
                                0xFF475569,
                              ),
                            ),
                            SizedBox(
                              width: 6,
                            ),
                            Text(
                              'Filter',
                              style:
                                  TextStyle(
                                color:
                                    Color(
                                  0xFF475569,
                                ),
                                fontSize: 13,
                                fontWeight:
                                    FontWeight
                                        .w600,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),

                    if (selectedClass !=
                        'All') ...[
                      const SizedBox(
                        width: 8,
                      ),
                      _activeChip(
                        selectedClass,
                      ),
                    ],
                  ],
                ),
              ),

              const SizedBox(height: 22),

              // COUNT
              Text(
                '${list.length} Students',
                style: const TextStyle(
                  fontSize: 14,
                  color:
                      Color(0xFF64748B),
                  fontWeight:
                      FontWeight.w500,
                ),
              ),

              const SizedBox(height: 10),

              // LIST
              if (list.isEmpty)
                _emptyState()
              else
                ...list.map(
                  (student) => Padding(
                    padding:
                        const EdgeInsets.only(
                      bottom: 12,
                    ),
                    child:
                        _studentCard(student),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }

  // ============================================================
  // ACTIVE CHIP
  // ============================================================

  Widget _activeChip(String text) {
    return GestureDetector(
      onTap: () {
        setState(() {
          selectedClass = 'All';
        });
      },
      child: Container(
        padding:
            const EdgeInsets.symmetric(
          horizontal: 12,
          vertical: 9,
        ),
        decoration:
            BoxDecoration(
          color:
              const Color(0xFFEFF6FF),
          borderRadius:
              BorderRadius.circular(20),
        ),
        child: Row(
          children: [
            Text(
              text,
              style: const TextStyle(
                color:
                    Color(0xFF2563EB),
                fontSize: 13,
                fontWeight:
                    FontWeight.w600,
              ),
            ),
            const SizedBox(width: 5),
            const Icon(
              Icons.close,
              size: 15,
              color:
                  Color(0xFF2563EB),
            ),
          ],
        ),
      ),
    );
  }

  // ============================================================
  // STUDENT CARD
  // ============================================================

  Widget _studentCard(
    Map<String, String> student,
  ) {
    return GestureDetector(
      onTap: () =>
          openStudentDetails(student),
      child: Container(
        padding:
            const EdgeInsets.symmetric(
          horizontal: 14,
          vertical: 14,
        ),
        decoration:
            BoxDecoration(
          color: Colors.white,
          borderRadius:
              BorderRadius.circular(15),
          border: Border.all(
            color:
                const Color(0xFFE2E8F0),
          ),
        ),
        child: Row(
          children: [

            Container(
              width: 48,
              height: 48,
              decoration:
                  const BoxDecoration(
                color:
                    Color(0xFFEFF6FF),
                shape: BoxShape.circle,
              ),
              alignment:
                  Alignment.center,
              child: Text(
                student['initials']!,
                style:
                    const TextStyle(
                  color:
                      Color(0xFF2563EB),
                  fontSize: 16,
                  fontWeight:
                      FontWeight.w700,
                ),
              ),
            ),

            const SizedBox(width: 14),

            Expanded(
              child: Column(
                crossAxisAlignment:
                    CrossAxisAlignment.start,
                children: [

                  Text(
                    student['name']!,
                    maxLines: 1,
                    overflow:
                        TextOverflow.ellipsis,
                    style:
                        const TextStyle(
                      color:
                          Color(0xFF1E293B),
                      fontSize: 15,
                      fontWeight:
                          FontWeight.w700,
                    ),
                  ),

                  const SizedBox(height: 4),

                  Text(
                    student['class']!,
                    style:
                        const TextStyle(
                      color:
                          Color(0xFF2563EB),
                      fontSize: 13,
                      fontWeight:
                          FontWeight.w600,
                    ),
                  ),

                  const SizedBox(height: 4),

                  Text(
                    '${student['email']} • ${student['phone']}',
                    maxLines: 1,
                    overflow:
                        TextOverflow.ellipsis,
                    style:
                        const TextStyle(
                      color:
                          Color(0xFF64748B),
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(width: 6),

            PopupMenuButton<String>(
              padding:
                  EdgeInsets.zero,
              icon: const Icon(
                Icons.more_vert,
                color:
                    Color(0xFF64748B),
                size: 21,
              ),
              onSelected: (value) {
                if (value == 'view') {
                  openStudentDetails(
                    student,
                  );
                }

                if (value == 'edit') {
                  editStudent(student);
                }

                if (value == 'delete') {
                  deleteStudent(student);
                }
              },
              itemBuilder:
                  (context) {
                return const [
                  PopupMenuItem(
                    value: 'view',
                    child:
                        Text('View Details'),
                  ),
                  PopupMenuItem(
                    value: 'edit',
                    child:
                        Text('Edit Student'),
                  ),
                  PopupMenuItem(
                    value: 'delete',
                    child:
                        Text('Delete Student'),
                  ),
                ];
              },
            ),
          ],
        ),
      ),
    );
  }

  // ============================================================
  // EMPTY STATE
  // ============================================================

  Widget _emptyState() {
    return Container(
      width: double.infinity,
      padding:
          const EdgeInsets.symmetric(
        vertical: 45,
        horizontal: 20,
      ),
      decoration:
          BoxDecoration(
        color: Colors.white,
        borderRadius:
            BorderRadius.circular(15),
        border: Border.all(
          color:
              const Color(0xFFE2E8F0),
        ),
      ),
      child: Column(
        children: [

          Container(
            width: 82,
            height: 82,
            decoration:
                const BoxDecoration(
              color:
                  Color(0xFFEFF6FF),
              shape: BoxShape.circle,
            ),
            child: const Icon(
              Icons.person_off_outlined,
              size: 40,
              color:
                  Color(0xFF2563EB),
            ),
          ),

          const SizedBox(height: 16),

          const Text(
            'No Students Found',
            style: TextStyle(
              fontSize: 18,
              fontWeight:
                  FontWeight.w700,
              color:
                  Color(0xFF111827),
            ),
          ),

          const SizedBox(height: 6),

          const Text(
            'Add your first student to get started.',
            textAlign:
                TextAlign.center,
            style: TextStyle(
              fontSize: 13,
              color:
                  Color(0xFF64748B),
            ),
          ),

          const SizedBox(height: 18),

          ElevatedButton(
            onPressed: addStudent,
            style:
                ElevatedButton.styleFrom(
              backgroundColor:
                  const Color(0xFF2563EB),
              foregroundColor:
                  Colors.white,
              elevation: 0,
              padding:
                  const EdgeInsets
                      .symmetric(
                horizontal: 28,
                vertical: 13,
              ),
              shape:
                  RoundedRectangleBorder(
                borderRadius:
                    BorderRadius.circular(
                  11,
                ),
              ),
            ),
            child: const Text(
              'Add Student',
              style: TextStyle(
                fontSize: 14,
                fontWeight:
                    FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }
}