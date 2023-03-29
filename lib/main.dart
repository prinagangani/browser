import 'package:browser/screens/home/provider/browserprovider.dart';
import 'package:browser/screens/home/view/browser_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main()
{
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => Browserprovider(),),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        routes: {
          '/' : (context) => Browserscreen(),
        },
      ),
    ),
  );
}