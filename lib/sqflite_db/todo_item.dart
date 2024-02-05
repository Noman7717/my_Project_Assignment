class TodoItem {
  int? id;
  final String date;
  final String title;
  final String description;

  TodoItem({
    this.id,
    required this.date,
    required this.title,
    required this.description,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'date': date,
      'title': title,
      'description': description,
    };
  }

  static TodoItem fromMap(Map<String, dynamic> map) {
    return TodoItem(
      id: map['id'],
      date: map['date'],
      title: map['title'],
      description: map['description'],
    );
  }
}
