import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ionicons/ionicons.dart';
import 'package:todo/models/task_model.dart';
import 'package:todo/shared/network/firebase/firebase_manager.dart';
import 'package:todo/shared/styles/colors.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class UpdateTask extends StatefulWidget {
  final TaskModel taskModel;

  UpdateTask({required this.taskModel, super.key});

  @override
  State<UpdateTask> createState() => _UpdateTaskState();
}

class _UpdateTaskState extends State<UpdateTask> {
  var titleController = TextEditingController();
  var descriptionController = TextEditingController();

  //selectedDate is empty to receive data from constructor lately
  late DateTime selectedDate;

  @override
  /*initState is the first action will call when the StatefulWidget create
  it runs out only once when the screen showed
  the the build runs out*/
  void initState() {
    super.initState();
    titleController.text = widget.taskModel.title;
    descriptionController.text = widget.taskModel.description;
    //to take the date's Task
    selectedDate = DateTime.fromMillisecondsSinceEpoch(widget.taskModel.date);
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Scaffold(
        backgroundColor: mintGreen,
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.blue,
          leading: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: Icon(
                Ionicons.chevron_back_outline,
                color: Colors.white,
              )),
          leadingWidth: 50,
          title: Text(
            AppLocalizations.of(context)!.appTitle,
            style: TextStyle(
                color: Colors.white, fontWeight: FontWeight.bold, fontSize: 22),
          ),
        ),
        body: Stack(
          children: [
            Container(
              width: double.infinity,
              height: 100,
              color: Colors.blue,
            ),
            Container(
              width: double.infinity,
              margin: EdgeInsets.symmetric(vertical: 30, horizontal: 30),
              height: MediaQuery.of(context).size.height - 200,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(18),
              ),
              child: Padding(
                padding: const EdgeInsets.all(18.0),
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Text(
                      "Edit Task",
                      textAlign: TextAlign.center,
                      style: GoogleFonts.poppins(
                          fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      height: 40,
                    ),
                    TextFormField(
                      controller: titleController,
                      decoration: InputDecoration(
                        label: Text("Task Title"),
                        enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: BorderSide(
                              color: Colors.blue,
                            )),
                        focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: BorderSide(
                              color: Colors.blue,
                            )),
                      ),
                    ),
                    SizedBox(
                      height: 25,
                    ),
                    TextFormField(
                      controller: descriptionController,
                      decoration: InputDecoration(
                        label: Text("Task Description"),
                        enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: BorderSide(
                              color: Colors.blue,
                            )),
                        focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: BorderSide(
                              color: Colors.blue,
                            )),
                      ),
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    Text(
                      "Select Date",
                      style: GoogleFonts.poppins(
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                      ),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    InkWell(
                      onTap: () {
                        showPicker();
                      },
                      child: Text(
                        textAlign: TextAlign.center,
                        selectedDate.toString().substring(0, 10),
                        style: GoogleFonts.poppins(
                            fontWeight: FontWeight.w500,
                            fontSize: 14,
                            color: Colors.blue),
                      ),
                    ),
                    SizedBox(height: 90),
                    ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            backgroundColor: primary,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20),
                            )),
                        onPressed: () {
                          loading();
                          TaskModel taskModel = TaskModel(
                              title: titleController.text,
                              description: descriptionController.text,
                              date: DateUtils.dateOnly(selectedDate)
                                  .millisecondsSinceEpoch,
                              userId: widget.taskModel.userId,
                              id: widget.taskModel.id,
                              isDone: widget.taskModel.isDone);
                          FirebaseManager.editTask(taskModel);
                          Navigator.pop(context);
                          Navigator.pop(context);
                        },
                        child: Text(
                          "Save Changes",
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                              fontWeight: FontWeight.bold),
                        ))
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  loading() {
    return showDialog(
      context: context,
      builder: (context) {
        return CircularProgressIndicator();
      },
    );
  }

  showPicker() async {
    DateTime? chosenDate = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        firstDate: DateTime.now(),
        lastDate: DateTime.now().add(Duration(days: 365)));

    if (chosenDate == null) {
      return;
    }
    selectedDate = DateUtils.dateOnly(chosenDate);
    setState(() {});
  }
}
