import 'package:flutter/material.dart';
import 'package:photo_notes_fresh_start_1/project.dart';

class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  State<MainPage> createState() => _MainPageState();
}

//Main Page Widget
class _MainPageState extends State<MainPage> {


  var number = 0;

  List<Widget> projectButtonsList = [];

  @override
  Widget build(BuildContext context) {

  refreshProjectButtons();

    return Scaffold(

      //appBar In Main Page
      appBar: AppBar(
        title: const Text('Projects'),
        backgroundColor: Colors.grey,
        actions: [
          IconButton(onPressed: (){}, icon: const Icon(Icons.calendar_today)),
          IconButton(onPressed: (){}, icon: const Icon(Icons.abc))
        ],
      ),

      //Floating action button for adding a new project
      floatingActionButton: FloatingActionButton(
        child: Text("$number"),
        onPressed: (){
          Project.createProject("name", DateTime.now(), context);

          print(Project.projectLists);

          setState(() {
            number++;
            projectButtonsList = Project.createProjectButtons(context,this);
    
          });
          
          print(projectButtonsList);
        }
      ),

      //List of project files
      body: 
          ListView(
            padding: const EdgeInsets.all(8),
            children: projectButtonsList ,
          )

    );
  
    
  
  }


  refreshProjectButtons(){
    projectButtonsList = [];
    projectButtonsList = Project.createProjectButtons(context,this);
  }
  
}



