import 'package:flutter/material.dart';
import 'package:todo_app/todo.dart';
import 'package:todo_app/todo_items.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {

  final List<ToDo> todosList = ToDo.todoList();
  TextEditingController addController = TextEditingController();
  List<ToDo> foundToDo = [];

  @override
  void initState() {
    foundToDo = todosList;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.black,
        appBar: appBar(),
        bottomNavigationBar: Row(
          children: [
            Expanded(
              child: Container(
                margin: const EdgeInsets.only(bottom: 20, left: 20, right: 20),
                decoration: BoxDecoration(
                  color: Colors.pink.shade50,
                  boxShadow: const [
                    BoxShadow(
                        color: Colors.grey,
                        blurRadius: 5.0,
                        spreadRadius: 1,
                        offset: Offset(0.0, 0.0)),
                  ],
                  borderRadius: BorderRadius.circular(25),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextField(
                    controller: addController,
                    decoration: const InputDecoration(
                      contentPadding: EdgeInsets.all(4),
                      hintText: "Add a new item",
                      hintStyle: TextStyle(fontSize: 18),
                      border: InputBorder.none,
                    ),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 20, right: 20),
              child: ElevatedButton(
                onPressed: () {
                  addToDoItem(addController.text);
                },
                style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.black,
                    elevation: 10,
                    minimumSize: const Size(70, 50),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(100))),
                child: const Text(
                  "+",
                  style: TextStyle(fontSize: 40, color: Colors.white,),
                ),
              ),
            )
          ],
        ),
        body: Column(
          children: [
            searchBox(),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(10, 20, 0, 0),
                child: Material(
                  // to avoid the listview bug
                  color: Colors.black,
                  child: ListView(
                    children: [
                      const Text(
                        "All To Do's",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 40,
                            fontWeight: FontWeight.w600),
                      ),
                      for (ToDo todo in foundToDo) TodoItems(todo: todo,
                          onDeleteItem: deleteToDoItems,
                          onToDoChanged: handleToDoChange),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void handleToDoChange(ToDo todo) {
    setState(() {
      todo.isDone = !todo.isDone;
    });
  }

  void deleteToDoItems(String id) {
    setState(() {
      todosList.removeWhere((item) => item.id == id);
    });
  }

  AppBar appBar() {
    return AppBar(
      backgroundColor: Colors.black,
      title: const Text(
        "To Do App",
        style: TextStyle(
            color: Colors.white, fontSize: 30, fontWeight: FontWeight.w600),
      ),
      leading: const Icon(
        Icons.menu,
        size: 35,
        color: Colors.white,
      ),
      actions: const <Widget>[
        Padding(
          padding: EdgeInsets.fromLTRB(0, 4, 8, 0),
          child: CircleAvatar(
            backgroundImage: AssetImage("assets/kareena.jpeg"),
          ),
        )
      ],
    );
  }

  Widget searchBox() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(10, 60, 10, 10),
      child: Container(
        decoration: BoxDecoration(
            color: Colors.white, borderRadius: BorderRadius.circular(30)),
        child: TextField(
          onChanged: (value) => runFilter(value),
          cursorColor: Colors.black,
          decoration: const InputDecoration(
              prefixIcon: Icon(Icons.search),
              contentPadding: EdgeInsets.all(11),
              hintText: "Search",
              border: InputBorder.none),
        ),
      ),
    );
  }

  void addToDoItem(String todo) {
    setState(() {
      todosList.add(ToDo(id: DateTime
          .now()
          .millisecondsSinceEpoch
          .toString(), todoText: todo));
      addController.clear();
    });

  }

  void runFilter(String enteredKeyword) {
    List<ToDo> results = [];
    if (enteredKeyword.isEmpty) {
      results = todosList;
    } else {
      results = todosList
          .where((item) => item.todoText
          .toLowerCase()
          .contains(enteredKeyword.toLowerCase()))
          .toList();
    }

    setState(() {
      foundToDo = results;
    });
  }

}