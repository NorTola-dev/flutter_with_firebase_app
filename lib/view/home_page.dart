import 'package:firebasedemoapp/service/cloud_service.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  CloudService serviceCloud = CloudService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Welcome to HomePage')),
      drawer: Drawer(),
      body: StreamBuilder(
        stream: serviceCloud.getStudent(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }

          if (!snapshot.hasData) {
            return Center(child: Text('No Data'));
          }

          final studentList = snapshot.data?.docs ?? [];

          return ListView.builder(
            itemCount: studentList.length,
            itemBuilder: (context, index) {
              var data = studentList[index];
              return Card(
                child: ListTile(
                  leading: CircleAvatar(child: Icon(Icons.person)),
                  title: Text(data['name']),
                  subtitle: Text(data['gender']),
                  trailing: PopupMenuButton(
                    itemBuilder: (context) {
                      return [
                        PopupMenuItem(
                          onTap: () async {
                            await serviceCloud.updateStudents(
                              data.id,
                              'sovat',
                              'male',
                              19,
                            );
                          },
                          child: Text('Update'),
                        ),
                        PopupMenuItem(
                          onTap: () async {
                            await serviceCloud.deleteStudent(data.id);
                          },
                          child: Text('Delete'),
                        ),
                      ];
                    },
                  ),
                ),
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          await serviceCloud.setStudent('fofo', 'male', 10);
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
