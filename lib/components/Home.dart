import 'package:dockIt/routes/routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

class HomePage extends StatelessWidget {
  final content = [
    "Plan your day easily",
    "Stay always orgaized",
    "Daily task schedular",
    "Utilize time properly"
  ];

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    return Material(
      color: Color.fromARGB(255, 232, 232, 232),
      child: Container(
        decoration: BoxDecoration(color: const Color.fromARGB(255, 41, 41, 41)),
        child: Padding(
            padding: EdgeInsets.all(30),
            child: SingleChildScrollView(
              child: Container(
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(height: screenWidth <= 400 ? 60 : 160),

                      Text("DockIt🤞",
                          style: TextStyle(
                              fontSize: 49,
                              fontWeight: FontWeight.w700,
                              color: Colors.white)).animate().fadeIn(duration: Duration(milliseconds: 1200)),
                      Text("Your handy daily task planner↴",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontSize: 35,
                              fontWeight: FontWeight.w500,
                              height: 0.9,
                              letterSpacing: 1,
                              color: Colors.white)).animate().fadeIn(duration: Duration(milliseconds: 1200)),
                      SizedBox(height: 40),
                      Wrap(
                        spacing: 5,
                        runSpacing: 5,
                        children: List.generate(
                          4,
                          (index) => AnimatedContainer(
                            padding: EdgeInsets.all(30),
                            width: screenWidth <= 400 ? 130 : 170,
                            height: screenWidth <= 400 ? 130 : 170,
                            decoration: BoxDecoration(
                              color: Color.fromARGB(255, 0, 0, 0),
                              borderRadius: BorderRadius.circular(7),
                            ),
                            duration: Duration(seconds: 1),
                            child: Column(children: [
                              Text(
                                index == 0
                                    ? "📝"
                                    : index == 1
                                        ? "✍️"
                                        : index == 2
                                            ? "✅"
                                            : "⏰",
                                style: TextStyle(fontSize: 25),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Text(content.elementAt(index),
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      fontSize: screenWidth <= 400 ? 10 : 15,
                                      fontWeight: FontWeight.w600,
                                      color: Colors.white))
                            ]),
                          ).animate().slideX(begin: index%2 == 0 ? 20 : -20,duration: Duration(milliseconds: (index+1)*500),delay: Duration(microseconds: 1000)).fadeIn(delay: Duration(microseconds: 800)),
                        ),
                      ),
                      SizedBox(
                        height: 50,
                      ),
                      Container(
                        width: 300,
                            child: ElevatedButton(
                                onPressed: () {
                                  Navigator.pushNamed(context, MyRoutes.tasksRoute);
                                },
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.black,
                                  padding: EdgeInsets.all(18),
                                ),
                                child: Container(
                                  child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Text("Get started",
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 18,
                                                fontWeight: FontWeight.w700)),
                                        SizedBox(
                                          width: 10,
                                        ),
                                        Icon(
                                          Icons.arrow_forward_ios_rounded,
                                          size: 18,
                                          color: Colors.white,
                                        )
                                      ]),
                                )
                      ),
                      ).animate().slideY(begin: 20,delay: Duration(microseconds: 2800),duration: Duration(milliseconds: 2400)),
                    ]),
              ),
            )),
      ),
    );
  }
}
