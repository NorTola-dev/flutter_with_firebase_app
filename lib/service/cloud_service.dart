import 'package:cloud_firestore/cloud_firestore.dart';

class CloudService {
  final cloud_firestore = FirebaseFirestore.instance.collection('Students');

  Future<void> setStudent(String name, String gender, int age) async {
    await cloud_firestore.add({"age": age, "name": name, "gender": gender});
  }

  Stream<QuerySnapshot> getStudent() {
    return cloud_firestore.snapshots();
  }

  Future<void> updateStudents(
    String id,
    String name,
    String gender,
    int age,
  ) async {
    await cloud_firestore.doc(id).update({
      "age": age,
      "name": name,
      "gender": gender,
    });
  }

  Future<void> deleteStudent(String id) async{
      await cloud_firestore.doc(id).delete();
  }
}
