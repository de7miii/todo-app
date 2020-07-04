import 'dart:convert';

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

  String toJson(Todo todo){
    return json.encode(todo);
  }

  @override
  int get hashCode => id;

  @override
  bool operator ==(Object other) => other is Todo && other.id == id;

  @override
  String toString() {
    return "{ \nid: \"${this.id}\", \ntitle: \"${this.title}\", \ncreated_by: \"${this.createdBy}\", \ncreated_at: \"${this.createdAt}\", \nupdated_at: \"${this.updatedAt}\" }";
  }
}