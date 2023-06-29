
class Student {
  final int studentID;

  Student({required this.studentID});

  factory Student.fromJson(Map<String, dynamic> json) {
    return Student(studentID: json['studentid'] ?? 0);
  }
}

