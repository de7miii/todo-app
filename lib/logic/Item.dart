class Item {
  int id;
  int todoId;
  String content;
  String createdAt;
  String updatedAt;
  bool status;

  Item({this.id, this.todoId, this.content, this.createdAt, this.updatedAt,
      this.status});

  factory Item.fromJson(Map<String, dynamic> json){
    return Item(
      id: json['id'],
      todoId: json['todo_id'],
      content: json['content'],
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
      status: json['status']
    );
  }

  @override
  int get hashCode => id;

  @override
  bool operator ==(Object other) => other is Item && other.id == id;
}