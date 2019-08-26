import 'package:flutter/material.dart';
import 'cature_video.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:async';
import 'dart:io';
import 'dart:io' as io;
import 'package:video_player/video_player.dart';
import 'chewie_list_item.dart';


void main() => runApp(MyApp());

// Initiating App
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'TikTok',
        routes: {
          '/capture': (context) => CameraApp()
        },
        home: GetLocationPage(),
        builder: (BuildContext context, Widget child) {
          return Padding(
            child: child,
            padding: EdgeInsets.only(bottom: 0.0),
          );
        },
        theme: ThemeData(primaryColor: Colors.green));
  }
}

// Login Page
class GetLocationPage extends StatefulWidget {
  @override
  _GetLocationPageState createState() => _GetLocationPageState();
}

class _GetLocationPageState extends State<GetLocationPage> {
  List file = new List();
  @override
  void initState() {
    getPath().then((value){
      file = io.Directory(value).listSync();
    });
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        new Container(
          height: double.infinity,
          width: double.infinity,
          decoration: new BoxDecoration(
            image: new DecorationImage(
              image: new AssetImage("assets/VN_poster.png"),
              fit: BoxFit.cover,
            ),
          ),
        ),
        Scaffold(
          backgroundColor: Colors.transparent,
          appBar: new AppBar(
            title: new Text("Welcome Yoda!"),
            backgroundColor: Colors.transparent,
            elevation: 0.0,
          ),
          drawer: Drawer(
            child: ListView(
              children: <Widget>[
                ListTile(
                  title: Text('Welcome'),
                  leading: Icon(Icons.home),
                ),
                ListTile(
                  title: Text('Profile'),
                  leading: Icon(Icons.local_offer),
                ),
                ListTile(
                  title: Text('Liked Videos'),
                  leading: Icon(Icons.add_shopping_cart),
                ),
                ListTile(
                  title: Text('Followers'),
                  leading: Icon(Icons.help_outline),
                ),
                ListTile(
                  title: Text('Following'),
                  leading: Icon(Icons.graphic_eq),
                ),
                ListTile(
                  title: Text('About'),
                  leading: Icon(Icons.supervised_user_circle),
                )
              ],
            ),
          ),
          bottomNavigationBar: BottomNavigationBar(
            backgroundColor: Colors.transparent,
            items: const <BottomNavigationBarItem>[
              BottomNavigationBarItem(
                icon: Icon(Icons.home, color: Colors.white),
                title:
                Text('Home', style: TextStyle(color: Colors.white)),
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.camera, color: Colors.white),
                title: Text('Record',
                    style: TextStyle(color: Colors.white)),
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.search, color: Colors.white),
                title: Text('Search',
                    style: TextStyle(color: Colors.white)),
              )
            ],
            onTap: (int index) {
              if (index == 1) {
                //getCameras();
                main1();
                //Navigator.pushNamed(context, '/capture');
              }
            },
            selectedItemColor: Colors.amber[800],
          ),
          body:ListView(
            children: new List.generate(file.length, (index) =>  ChewieListItem(
                videoPlayerController: VideoPlayerController.file(file[index]),
                looping: true,
              )),
            //Fix: Had to iterate properly
//            children: <Widget>[
//              ChewieListItem(
//                videoPlayerController: VideoPlayerController.file(file[0]),
//                looping: true,
//              ),
//              ChewieListItem(
//                videoPlayerController: VideoPlayerController.file(file[1])
//              ),
//              ChewieListItem(
//                // This URL doesn't exist - will display an error
//                videoPlayerController: VideoPlayerController.file(file[2]),
//              ),
//            ],
          )
        ),
      ],
    );
  }
}

Future<String> getPath() async {
  final Directory extDir = await getApplicationDocumentsDirectory();
  final String dirPath = '${extDir.path}/Movies/flutter_test';
  //List<FileSystemEntity> _files;
  return dirPath;
  print(dirPath);
  //await Directory(dirPath).create(recursive: true);

  //final String filePath = '$dirPath/${timestamp()}.mp4';
}