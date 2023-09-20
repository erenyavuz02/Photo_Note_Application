
// ignore_for_file: prefer_const_constructors

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:path/path.dart' as path;
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';

import 'PhotoNote.dart';
import 'project.dart';

class ProjectPage extends StatefulWidget {
  Project currentProject;
  ProjectPage(this.currentProject, {super.key});

  @override
  State<ProjectPage> createState() => _ProjectPageState(currentProject);
}

class _ProjectPageState extends State<ProjectPage> {

  Project currentProject;
  List<Widget> photoNotes = [];
  
  _ProjectPageState(this.currentProject);
  


  @override
  Widget build(BuildContext context) {

    refreshPhotoNotesList();
    return Scaffold(

      appBar: AppBar(
        title: const Text('Projects'),
        backgroundColor: Colors.grey,
        actions: [
          IconButton(onPressed: (){
            //SendDataToJava.send(currentProject.photoNotesList!.first.imagePath, "deneme");
          }, icon: Icon(Icons.calendar_today)),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: (){
          showDialog(
            context: context,
            builder: (context) => AlertDialog(
              icon: Icon(Icons.abc),
              content: Container(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
              
                    FilledButton(
                      onPressed: () => pickImageFromCamera(),
                      child: Text("Take Photo"),
                    ),
                    FilledButton(
                      onPressed: () => pickImageFromGallery(),
                      child: Text("Choose From Gallery"),
                    )
                  ],
                ),
              ),
            ),
          );
        },
        child: Icon(Icons.camera),
      ),
      body: ListView(
        children:  photoNotes,
      ),
    );
  }

  Future pickImageFromGallery() async{

    try {

      final image = await ImagePicker().pickImage(source: ImageSource.gallery);
      if (image==null) return;

      Directory directory = await getApplicationDocumentsDirectory(); // or getApplicationDocumentsDirectory() for internal storage
      String targetDirectory = path.join(directory.path, currentProject.name);

      if (!(await Directory(targetDirectory).exists())) {
        await Directory(targetDirectory).create(recursive: true);
      }

      String targetPath = path.join(targetDirectory, DateTime.now().toString());

      // Move the image file to the target directory
      File imageFile = File(image.path);
      await imageFile.rename(targetPath);

      // Now the image is saved to the target directory with the same filename
      print('Image saved to: $targetPath');

      setState(() {
        

        photoNotes += [createPhotoNoteWidget(currentProject.addNewPhotoNote(targetPath))];

        Project.saveProjects();
        
      });


      
    
    } on PlatformException catch (e) {
      print("Failed to pick image: $e");
    }
    
  }

  Future pickImageFromCamera() async{
    try {
      final image = await ImagePicker().pickImage(source: ImageSource.camera);

      if (image==null) return;

      Directory directory = await getApplicationDocumentsDirectory(); // or getApplicationDocumentsDirectory() for internal storage
      String targetDirectory = path.join(directory.path, currentProject.name);

      if (!(await Directory(targetDirectory).exists())) {
        await Directory(targetDirectory).create(recursive: true);
      }

      String targetPath = path.join(targetDirectory, DateTime.now().toString());

      // Move the image file to the target directory
      File imageFile = File(image.path);
      await imageFile.rename(targetPath);

      // Now the image is saved to the target directory with the same filename
      print('Image saved to: $targetPath');

      setState(() {
        

        photoNotes += [createPhotoNoteWidget(currentProject.addNewPhotoNote(targetPath))];

        Project.saveProjects();
        
      });

      

    } on PlatformException catch (e) {
      print("Failed to pick image: $e");
    }
    
  }

  Widget createPhotoNoteWidget(PhotoNote photoNote){
    

    return Column(
      children: [
        Image.file(
          photoNote.getPhotoFile(),
          fit: BoxFit.fill,
        ),
        SingleChildScrollView(
          child: SizedBox(
            height: 200,
            child: TextField(
              onChanged: (text){ photoNote.imageNote = text;
                Project.saveProjects();
               },
              controller: TextEditingController(text: photoNote.imageNote),
              maxLines: null, // Allow the TextField to have unlimited lines
              decoration: InputDecoration(
                border: OutlineInputBorder(),
              ),
            ),
          ),
        )
      ],
    );

  }

  refreshPhotoNotesList(){
    photoNotes = [];
    
    List<dynamic>? projectPhotoNotesList =  currentProject.photoNotesList;
    if (projectPhotoNotesList != null){

      for (PhotoNote p in projectPhotoNotesList){

        photoNotes.add(createPhotoNoteWidget(p));
      }

    }
      
  }

  

  

}


