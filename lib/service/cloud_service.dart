import 'package:cloud_firestore/cloud_firestore.dart';

class CloudService {
  final cloud_firestore = FirebaseFirestore.instance.collection('Students');

  Future<void> setStudent(String name, String gender, int age) async {
    await cloud_firestore.add({
      "age": age, 
      "name": name, 
      "gender": gender
    });
  }

  Stream<QuerySnapshot> getStudent(){
    return cloud_firestore.snapshots();
  }
}
