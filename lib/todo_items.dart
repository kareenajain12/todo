import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:todo_app/todo.dart';

class TodoItems extends StatelessWidget {
  const TodoItems(
      {super.key, required this.todo, required this.onDeleteItem, required this.onToDoChanged});

  final ToDo todo;
  final onToDoChanged;
  final onDeleteItem;


  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(5, 5, 5, 20),
      child: ListTile(
        onTap: () {
          onToDoChanged(todo);
        },
        tileColor: Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        leading: Icon(
          todo.isDone ? Icons.check_box : Icons.check_box_outline_blank,
          color: Colors.black,
          size: 30,
        ),
        contentPadding: const EdgeInsets.symmetric(
            horizontal: 20.0, vertical: 5),
        title: Text(
          todo.todoText,
          style: TextStyle(
              color: Colors.black,
              fontSize: 25,
              decoration: todo.isDone ? TextDecoration.lineThrough : null),
        ),
        trailing: IconButton(
          color: Colors.red,
          onPressed: () {
            onDeleteItem(todo.id);
          },
          icon: const Icon(Icons.delete),
          iconSize: 30,
        ),
      ),
    );
  }
}
