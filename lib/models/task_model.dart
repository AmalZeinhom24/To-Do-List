class TaskModel {
  /*Anytime you deal with database or model in firebase,
   make it nullable, because it may return null*/

  String id;
  String title;
  String description;
  int date;
  String userId; //each task must created for a specific use id
  bool isDone;

  TaskModel(
      {this.id = '',
      required this.title,
      required this.description,
      required this.date,
      required this.userId,
      this.isDone = false});

  /*Firebase works with map only, and sometimes I have to work with model,
  *So we need the next two functions to convert between model to map and vesa versa*/
  //1. This fun takes map and converts to model
  TaskModel.fromJson(Map<String, dynamic> json)
      : this(
          //Instead of fun below, I can replace it with named constructor takes map,
          //(this) indicates on the main constructor "TaskModel"
          id: json['id'],
          title: json['title'],
          description: json['description'],
          date: json['date'],
          userId: json['userID'],
          isDone: json['isDone'],
        );

  /*TaskModel fromJson(Map<String, dynamic>json) {
    //This fun takes map and converts to model
    return TaskModel(
      id: json['id'],
      title: json['title'],
      description: json['description'],
      date: json['date'],
      isDone: json['isDone'],
    );
  }*/

  //2. This fun takes model and converts to map
  Map<String, dynamic> toJson() {
    return {
      //Map= "key": "value"
      "id": id,
      "title": title,
      "description": description,
      "date": date,
      "userID": userId,
      "isDone": isDone,
    };
  }
}
