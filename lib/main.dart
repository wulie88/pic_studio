import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
        // This makes the visual density adapt to the platform that you run
        // the app on. For desktop platforms, the controls will be smaller and
        // closer together (more dense) than on mobile platforms.
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;
  Widget contentWidget;
  List<Widget> imageList = [Text("R")];
  List<File> files = [];

  Future listDir(String folderPath) async {
    Directory tempDir = await getTemporaryDirectory();
    String tempPath = tempDir.path;
    print(tempPath);

    Directory appDocDir = await getApplicationDocumentsDirectory();
    String appDocPath = appDocDir.path;
    print(appDocPath);

    var directory = new Directory(appDocPath + folderPath);
    print(directory);

    var exists = await directory.exists();
    if (exists) {
      print("exits");

      directory
          .list(recursive: true, followLinks: false)
          .listen((FileSystemEntity entity) async {
        if (FileSystemEntity.isFileSync(entity.path)) {
          if (RegExp(r"[jpg|png]$").hasMatch(entity.path)) {
            print(entity.path + " is image file");
            this.setState(() {
              imageList:
              imageList.add(Image.file(entity));
              files:
              files.add(entity);
            });
          }
        } else {
          await listDir(entity.path);
        }
        print(entity.path);
      });
    }
  }

  void _incrementCounter() {
    listDir("/PhotoLibrary");

    setState(() {
      // This call to setState tells the Flutter framework that something has
      // changed in this State, which causes it to rerun the build method below
      // so that the display can reflect the updated values. If we changed
      // _counter without calling setState(), then the build method would not be
      // called again, and so nothing would appear to happen.
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    // contentWidget = Text("contentWidget"); //ListView(clidren: imageList,);

    contentWidget = Expanded(
                  child: Column(
                    children: imageList,
                  ));
    return Scaffold(
      // appBar: AppBar(
      //   // Here we take the value from the MyHomePage object that was created by
      //   // the App.build method, and use it to set our appbar title.
      //   title: Text(widget.title),
      // ),
      body: Row(
        children: <Widget>[
          HomePannel(HomePannelType.HomePannelTypeSide, title: 'LEFT'),
          HomePannel(HomePannelType.HomePannelTypeSection,
              contentWidget: contentWidget, title: 'Section'),
          HomePannel(HomePannelType.HomePannelTypeSide, title: 'Right'),
          Column(
            children: imageList,
          )
          // ListView.builder(
          //   itemCount: files.length,
          //   itemBuilder: (BuildContext context, int index) {
          //     return Image.file(files[index]);
          //   }
          // ),
          // Text(
          //   '$_counter',
          //   style: Theme.of(context).textTheme.headline4,
          // ),
        ],
      ),

      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}

class HomePannelTypeSide {}

enum HomePannelType {
  HomePannelTypeSide,
  HomePannelTypeSection,
}

class HomePannel extends StatefulWidget {
  final String title;
  final HomePannelType type;
  final Widget contentWidget;

  const HomePannel(this.type, {Key key, this.contentWidget, this.title})
      : super(key: key);

  @override
  PannelState createState() =>
      PannelState(this.type, this.contentWidget, this.title);
}

class PannelState extends State<HomePannel> {
  final String title;
  final HomePannelType type;
  final Widget contentWidget;

  PannelState(this.type, this.contentWidget, this.title);

  @override
  Widget build(BuildContext context) {
    var container = type == HomePannelType.HomePannelTypeSide
        ? Container(
            padding: const EdgeInsets.all(10.0),
            width: 268,
            child: Column(
              children: [
                Text(
                  'yyy112' + title,
                )
              ],
            ),
            decoration: BoxDecoration(
              border: Border(top: BorderSide(color: Colors.black)),
              color: Colors.black87,
            ),
          )
        : Expanded(
            child: Container(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              children: [
                Text(
                  'yyy112' + title,
                ),
                contentWidget
              ],
            ),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.black),
              color: Colors.black87,
            ),
          ));
    return container;
  }
}
