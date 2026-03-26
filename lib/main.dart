import 'package:catalog_app/core/routes/app_routes.dart';
import 'package:flutter/material.dart';


void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',

      initialRoute: AppRoutes.products,
      onGenerateRoute: AppRoutes.generateRoute,
    );
  }
}


/*
import 'package:flutter/material.dart';

import 'model/person_model.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {

    List<PersonModel>personList = [
      PersonModel(name: 'Asif'),
      PersonModel(name: 'john'),
      PersonModel(name: null),
    ];
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
      floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.indigo.shade200,
          onPressed: (){
            PersonModel personModel1 = PersonModel(name: 'Pragya');
            PersonModel personModel2 = PersonModel(name: 'pragya');
            print(personModel1.hashCode.toString());
            print(personModel2.hashCode.toString());
            print(personModel1 == personModel2);


          }),
        appBar: AppBar(
          title: const Text("Freezed App"),
          backgroundColor: Colors.pink,
        ),
        body: ListView.builder(
            itemCount: personList.length,
            itemBuilder: (context,index){
          return ListTile(
            title: Text(personList[index].name ?? 'xyz'),
          );
        }),
      ),
    );
  }
}*/
