import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:todo/models/task_model.dart';
import 'package:todo/models/user_model.dart';

class FirebaseManager {
  static CollectionReference<TaskModel> getTasksCollection() {
    /* (.add) need a map to save data, but it is hard to remember all keys for all tables that i have
    so to facilitate this create a model has all data which I need to add*/
    return FirebaseFirestore.instance
        .collection("Tasks")
        .withConverter<TaskModel>(
      fromFirestore: (snapshot, _) {
        return TaskModel.fromJson(snapshot.data()!);
      },
      toFirestore: (task, _) {
        return task.toJson();
      },
    );
  }

  static CollectionReference<UserModel> getUsersCollection() {
    /* (.add) need a map to save data, but it is hard to remember all keys for all tables that i have
    so to facilitate this create a model has all data which I need to add*/
    return FirebaseFirestore.instance
        .collection("Users")
        .withConverter<UserModel>(
      fromFirestore: (snapshot, _) {
        return UserModel.fromJson(snapshot.data()!);
      },
      toFirestore: (user, _) {
        return user.toJson();
      },
    );
  }

  //I will call this function after create the account(createAccount fun)
  static Future<void> addUserToFirestore(UserModel users) {
    var collection = getUsersCollection();
    //Id auto generated from authentication
    var docRef = collection.doc(users.id);
    return docRef.set(users);
  }

  static Future<void> addTask(TaskModel task) {
    //1. create collection
    var collection = getTasksCollection();
    //2. create document
    //Id manually created
    var docRef = collection.doc();
    //3. Set ID automatic
    task.id = docRef.id;
    return docRef.set(task);
  }

  static Stream<QuerySnapshot<TaskModel>> getTasks(DateTime date) {
    return getTasksCollection()
        //Filteration must be with date and user id
        .where("userID", isEqualTo: FirebaseAuth.instance.currentUser!.uid)
        .where("date", isEqualTo: DateUtils.dateOnly(date).millisecondsSinceEpoch)
        .snapshots();
  }

  static Future<void> deleteTask(String taskId) {
    return getTasksCollection().doc(taskId).delete();
  }

  static void updateTask(String taskId, bool isDone) {
    getTasksCollection().doc(taskId).update({"isDone": isDone});
  }

  static Future<void> createAccount(String email, String password, String name,
      Function onSuccess, Function onError) async {
    try {
      final credential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      UserModel userModel =
          UserModel(id: credential.user!.uid, name: name, email: email);
      credential.user!.sendEmailVerification();
      addUserToFirestore(userModel);
      onSuccess();
      /*//How to save user's data and receive it
      credential.user?.sendEmailVerification();*/
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        onError(e.message);
      } else if (e.code == 'email-already-in-use') {
        onError(e.message);
      }
    } catch (e) {
      print(e);
    }
  }

  static Future<void> login(String email, String password, Function onSuccess,
      Function onError) async {
    try {
      final credential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
      if (credential.user!.emailVerified) {
        onSuccess();
      } else {
        onError('Please verify your email');
      }
    } on FirebaseAuthException catch (e) {
      //The text is the default error message created by auth
      onError("Wrong email or password");
      /* //Old method
     if (e.code == 'user-not-found') {
        print('No user found for that email.');
      } else if (e.code == 'wrong-password') {
        print('Wrong password provided for that user.');
      }*/
    }
  }
}
