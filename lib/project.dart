


import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'PhotoNote.dart';
import 'projects_screen.dart';


part 'project.g.dart';

@HiveType(typeId: 1)
class Project extends HiveObject{

  static List<dynamic> projectLists = [];
  

  @HiveField(1)
  String name;

  @HiveField(2)
  DateTime projectDate;

  @HiveField(3)
  List<dynamic> photoNotesList = [];

  
  Project(this.name, this.projectDate);
  


  static void createProject(String name, DateTime projectDate, context){
    
    Project yeniProje = Project(name, projectDate);
    projectLists.add(yeniProje);
    
    saveProjects();

  }


  static Widget projectWidget(Project project, context, state){

    return ElevatedButton(
      onPressed: (){
        Navigator.push(
          context, 
          MaterialPageRoute(
            builder: (context) {
              return ProjectPage(project);
            }
          )
        );
      },
      onLongPress: () {
        /*
        projectLists.remove(project);
        state.setState(() {
          state.setProjectButtonsList(createProjectButtons(context, state));
        
        });
        */
        openDialog(context,project, state);

      },         
      child: Text("${project.name} ${project.projectDate.toString()} ")
    );

  }


  static List<Widget> createProjectButtons(context,State state) {
    List<Widget> output =[const SizedBox(height: 50,)];

    for (Project p in projectLists){
      output.add(projectWidget(p, context,state));
    }
    return output;
  }



  static Future openDialog(context,Project project, state) => showDialog(
    context: context,
    builder: (context) => AlertDialog(
      icon: const Icon(Icons.abc),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          FilledButton(
            onPressed: (){
              project.removeThisProject();
              Navigator.pop(context);
              state.setState((){
              state.refreshProjectButtons;

              });
            },
            child: const Text("Remove"),
            )
        ],
      ),
    ),
  );


  static void loadProjects() async{
    final List<dynamic> data = await Hive.box('mybox').get('Projects') ?? [];

    projectLists = data;

    for (Project p in projectLists){
      p.loadPhotoNotes();
    }
  }

  static void saveProjects(){
    Hive.box('mybox').put('Projects', projectLists );

    for (Project p in projectLists){
      p.savePhotoNotes();
    }
  }


  void savePhotoNotes(){
    Hive.box('mybox').put('$name ${projectDate.toString()}', photoNotesList);
  }

  void loadPhotoNotes(){

    photoNotesList = Hive.box('mybox').get("$name ${projectDate.toString()}") ?? [];

  }

  void removeThisProject(){

    Hive.box('mybox').delete('$name ${projectDate.toString()}');
    projectLists.remove(this);
    saveProjects();

  }

  PhotoNote addNewPhotoNote(targetPath){
    PhotoNote newPhotoNote = PhotoNote(targetPath);

    photoNotesList.add(newPhotoNote);

    return  newPhotoNote;
  }
}

