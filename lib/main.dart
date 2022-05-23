import 'dart:io';
import 'package:flutter/material.dart';
import 'package:splash_screen_view/SplashScreenView.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import 'package:myapp/src/pages/home/page.dart';
import 'package:teta_cms/teta_cms.dart';
import 'globals.dart' as globals;

///NOTE:
///if you have an error while running <flutter run>
///run <flutter pub upgrade> and than <flutter run --no-sound-null-safety>
void main() async {
  // Inicilizo variables a usar en la mayoria de mis pantallas
  globals.email = "melo";
  globals.idRestaurant = "1";

  WidgetsFlutterBinding.ensureInitialized();
  TetaCMS.initialize(
    token:
        'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJlbWFpbCI6ImpiYXJyZXJhMDk0QGdtYWlsLmNvbSIsImVtYWlsX3ZlcmlmaWVkIjp0cnVlLCJwcm9qZWN0cyI6WzEwNjY2OV0sIm5hbWUiOiJKZWlzc29uIEhhcnZleSBCYXJyZXJhIFNhbmNoZXoiLCJlbWl0dGVyIjoiVGV0YS1BdXRoIiwiaWF0IjoxNjUyODM5OTA3LCJleHAiOjQ4MDg1OTk5MDd9.BXjs-rHVRInH0ye5AXnP7BI47NKv68zr_NQGiKj7Pcs',
    prjId: 106669,
  );

  Supabase.initialize(
    url: 'https://vljgeizgbbophoeqhyox.supabase.co',
    anonKey:
        'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InZsamdlaXpnYmJvcGhvZXFoeW94Iiwicm9sZSI6ImFub24iLCJpYXQiOjE2NDk2MjA0NjAsImV4cCI6MTk2NTE5NjQ2MH0.ukioq7IIfPkrihdrxi4MlePD2Ys_QC91O-x4yTKocjI',
  );

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'COSIFI',
      home: SplashScreenView(
        navigateRoute: PageHome(),
        duration: 2200,
        imageSize: 80,
        imageSrc: 'assets/logo_small.png',
        text: '',
        textType: TextType.NormalText,
        textStyle: TextStyle(
          fontSize: 30.0,
        ),
        backgroundColor: Colors.black,
      ),
    );
  }
}
