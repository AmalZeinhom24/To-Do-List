import 'package:confetti/confetti.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:todo/models/task_model.dart';
import 'package:todo/screens/tasks/update_task.dart';
import 'package:todo/shared/network/firebase/firebase_manager.dart';
import 'package:todo/shared/styles/colors.dart';

class TaskItem extends StatefulWidget {
  TaskModel taskTitle;

  TaskItem(this.taskTitle, {super.key});

  @override
  State<TaskItem> createState() => _TaskItemState();
}

class _TaskItemState extends State<TaskItem> {
  final controller = ConfettiController();

  bool isPlaying = false;

  @override
  void initState() {
    super.initState();
    controller.addListener(() {
      setState(() {
        isPlaying = controller.state == ConfettiControllerState.playing;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 12,
      margin: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      shape: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide(
          color: Colors.transparent,
        ),
      ),
      child: Slidable(
        startActionPane: ActionPane(motion: DrawerMotion(), children: [
          SlidableAction(
            onPressed: (BuildContext context) {
              FirebaseManager.deleteTask(widget.taskTitle.id);
            },
            backgroundColor: Colors.red,
            label: "Delete",
            icon: Icons.delete,
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(12), bottomLeft: Radius.circular(12)),
          ),
          SlidableAction(
            onPressed: (BuildContext context) {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => UpdateTask(
                            taskModel: widget.taskTitle,
                          )));
            },
            backgroundColor: Colors.blue,
            label: "Edit",
            icon: Icons.edit,
          ),
        ]),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Stack(
            alignment: Alignment.topCenter,
            children: [
              ConfettiWidget(
                  confettiController: controller,
                  shouldLoop: true,
                  blastDirectionality: BlastDirectionality.explosive,
              gravity: 1,
              ),
              Row(
                children: [
                  Container(
                    height: 80,
                    width: 4,
                    decoration: BoxDecoration(
                        color: widget.taskTitle.isDone ? Colors.green : primary,
                        borderRadius: BorderRadius.circular(24),
                        border: Border.all(color: Colors.blue)),
                  ),
                  SizedBox(width: 20),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.taskTitle.title,
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color:
                              widget.taskTitle.isDone ? Colors.green : primary,
                        ),
                      ),
                      Text(widget.taskTitle.description,
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                            color: widget.taskTitle.isDone
                                ? Colors.green
                                : primary,
                          ))
                    ],
                  ),
                  Spacer(),
                  InkWell(
                    onTap: () {
                      if (isPlaying) {
                        controller.stop();
                      } else {
                        controller.play();
                      }
                      FirebaseManager.updateTask(widget.taskTitle.id, true);
                    },
                    child: Container(
                      margin: EdgeInsets.only(right: 12),
                      padding:
                          EdgeInsets.symmetric(horizontal: 16, vertical: 2),
                      decoration: BoxDecoration(
                        color: widget.taskTitle.isDone ? Colors.green : primary,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: widget.taskTitle.isDone
                          ? Text(
                              "Done!",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 18,
                                  fontWeight: FontWeight.w500),
                            )
                          : Icon(
                              Icons.done,
                              color: Colors.white,
                              size: 30,
                            ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
