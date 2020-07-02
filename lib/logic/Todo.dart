class Todo {
  int id;
  String title;
  String createdBy;
  String createdAt;
  String updatedAt;
  // List<Item> items;

  Todo({this.id, this.title, this.createdBy, this.createdAt,
      this.updatedAt});

  factory Todo.fromJson(Map<String, dynamic> json){
    return Todo(
      id: json['id'],
      title: json['title'],
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
      createdBy: json['created_by']
    );
  }

  @override
  int get hashCode => id;

  @override
  bool operator ==(Object other) => other is Todo && other.id == id;
}