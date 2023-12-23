import 'dart:ffi';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hive/hive.dart';

class TasksPage extends StatefulWidget {
  @override
  _TasksPageState createState() => _TasksPageState();
}

class _TasksPageState extends State<TasksPage> {
  final tasksBox = Hive.box('tasks');
  String inputAdd = "";

  List taskList = [];

  _TasksPageState() {
    taskList = List.generate(
        tasksBox.get("tasks").length, (index) => tasksBox.get("tasks")[index]);
    print(taskList); //printing tasklist after updation
  }

  void addTask() {
    if (inputAdd.length == 0 || inputAdd.length < 13) {
      Fluttertoast.showToast(
        msg: "Task is either empty or short ❌",
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.black,
        textColor: Colors.white,
        fontSize: 16.0,
      );
      return;
    }
    
    taskList.add({
      "description": inputAdd,
      "date": DateTime.now().year.toString() +
          " " +
          DateTime.now().month.toString() +
          " " +
          DateTime.now().day.toString(),
      "status": false
    });
    Fluttertoast.showToast(
      msg: "Task added ✅",
      toastLength: Toast.LENGTH_LONG,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 1,
      backgroundColor: Colors.black,
      textColor: Colors.white,
      fontSize: 16.0,
    );
    setState(() {});
    tasksBox.put("tasks", taskList);
    Navigator.pop(context,true);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        floatingActionButton: FloatingActionButton.extended(
          onPressed: () {
            showDialog(
                context: context,
                builder: (context) {
                  return (AlertDialog(
                    backgroundColor: Colors.black,
                    title: Text(
                      "Add a new task ✍️",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.w700),
                      textAlign: TextAlign.center,
                    ),
                    content: Container(
                      height: 200,
                      width: 500,
                      child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            SizedBox(
                              height: 25,
                            ),
                            TextField(
                              onChanged: (value) {
                                inputAdd = value;
                              },
                              style:
                                  TextStyle(color: Colors.white, fontSize: 19),
                              decoration: InputDecoration(
                                hintText: "Task name",
                                hintStyle: TextStyle(color: Colors.white),
                                border: new OutlineInputBorder(
                                    borderSide: BorderSide(color: Colors.white),
                                    borderRadius: BorderRadius.circular(12)),
                                focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(color: Colors.white),
                                    borderRadius: BorderRadius.circular(12)),
                                prefixIcon: const Icon(
                                  CupertinoIcons.arrow_down_circle,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            ElevatedButton(
                                onPressed: addTask,
                                style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.white,
                                    padding: EdgeInsets.only(
                                        left: 30,
                                        right: 30,
                                        top: 18,
                                        bottom: 18)),
                                child: Column(
                                  children: [
                                    Text(
                                      "Add task +",
                                      style: TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w700,
                                          color: Colors.black),
                                    ),
                                  ],
                                ))
                          ]),
                    ),
                  ));
                });
          },
          backgroundColor: Color.fromARGB(255, 32, 32, 32),
          splashColor: Colors.white,
          label: Row(children: [
            Text("Add task",
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 15,
                    fontWeight: FontWeight.w500)),
            SizedBox(width: 5),
            Icon(
              Icons.add,
              color: Colors.white,
            ),
          ]),
        ),
        backgroundColor: const Color.fromARGB(255, 41, 41, 41),
        body: SingleChildScrollView(
          child: Center(
            child: Container(
                child: Padding(
              padding: EdgeInsets.all(30),
              child: Column(children: [
                SizedBox(height: 80),
                Row(children: [
                  Text(
                    "Your Tasks ➡",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 35,
                        fontWeight: FontWeight.w500),
                  )
                      .animate()
                      .shake(duration: Duration(milliseconds: 700))
                      .shimmer(
                          duration: Duration(seconds: 1), color: Colors.black)
                ]),

                SizedBox(
                  child: taskList.length == 0
                      ? Column(
                          children: [
                            SizedBox(
                              height: 100,
                            ),
                            Image.asset(
                              'assets/images/empty.png',height: 160,
                            ).animate().slideY(
                                begin: 10,
                                end: 0,
                                duration: Duration(seconds: 1),
                                delay: Duration(milliseconds: 500)),
                            SizedBox(
                              height: 30,
                            ),
                            Text(
                              "No tasks are added yet 😕",
                              style: TextStyle(
                                  fontSize: 20,
                                  color: Colors.white,
                                  fontWeight: FontWeight.w700),
                            ).animate().slideX(
                                begin: 10,
                                end: 0,
                                duration: Duration(milliseconds: 1500),
                                delay: Duration(milliseconds: 500)),
                          ],
                        )
                      : SizedBox(height: 25),
                ),

                //columns to hold tasks
                Column(children: [
                  Container(
                      child: Wrap(
                          spacing: 8,
                          runSpacing: 8,
                          direction: Axis.vertical,
                          children: List.generate(
                            taskList.length,
                            (index) => Container(
                                child: Container(
                              child: Row(children: [
                                Column(
                                  
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        taskList[index]['description']
                                                    .toString()
                                                    .length >
                                                13
                                            ? taskList[index]['description']
                                                    .toString()
                                                    .substring(0, 10) + "..."
                                            : taskList[index]['description']
                                                .toString(),
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 20,
                                            fontWeight: FontWeight.w500,
                                            ),
                                      ),
                                      SizedBox(height: 2),
                                      Text(
                                        "Added on " +
                                            taskList[index]['date'].toString() +
                                            " ↴",
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 12.5,
                                            fontWeight: FontWeight.w500),
                                      ),
                                      Text(
                                        taskList[index]['status'] == true
                                            ? "Status completed"
                                            : "Status incomplete",
                                        style: TextStyle(
                                            color: taskList[index]['status'] ==
                                                    true
                                                ? Colors.green
                                                : Colors.red,
                                            fontSize: 15,
                                            fontWeight: FontWeight.w600),
                                      ),
                                    ]),
                                SizedBox(
                                  width: 55,
                                ),
                                MaterialButton(
                                  onPressed: () {},
                                  child: Row(children: [
                                    Checkbox(
                                      value: taskList[index]['status'] == true
                                          ? true
                                          : false,
                                      onChanged: (con) {
                                        if (taskList[index]['status']) {
                                          taskList[index]['status'] = false;
                                        } else {
                                          taskList[index]['status'] = true;
                                        }
                                        setState(() {});
                                        tasksBox.put("tasks", taskList);
                                      },
                                      activeColor:
                                          Color.fromARGB(255, 56, 56, 56),
                                      checkColor: Colors.white,
                                    ),
                                    GestureDetector(
                                      onTap: () {
                                        taskList.removeAt(index);
                                        setState(() {});
                                        tasksBox.put("tasks", taskList);
                                      },
                                      child: Icon(Icons.delete,
                                          color: Colors.white),
                                    )
                                  ]),
                                )
                              ]),
                              decoration: BoxDecoration(
                                  color: Colors.black,
                                  borderRadius: BorderRadius.circular(12)),
                              width: MediaQuery.of(context).size.width - 52,
                              padding: EdgeInsets.only(
                                  top: 35, bottom: 35, left: 40, right: 10),
                            )).animate().slideY(
                                begin: 15,
                                end: 0,
                                duration:
                                    Duration(milliseconds: (index + 1) * 300)),
                          ))),
                ]),
              ]),
            )),
          ),
        ));
  }
}
