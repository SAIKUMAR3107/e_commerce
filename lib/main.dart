import 'package:e_commerce/provider/product_provider.dart';
import 'package:e_commerce/screens/notification_service.dart';
import 'package:e_commerce/screens/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

void main(){
  WidgetsFlutterBinding.ensureInitialized();
  NotificationService().initNotification();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(create: (_) => ProductProvider(),
      child: Builder(builder: (BuildContext context) =>
          MaterialApp(
              debugShowCheckedModeBanner: false,
              title: "E-commerce Application",
              home: SplashScreen()
            //fakeproducts(),
          )
      ),);/*MaterialApp(
      title: "E-commerce Application",
      debugShowCheckedModeBanner: false,
      home: SplashScreen(),
    )*/;
  }
}
