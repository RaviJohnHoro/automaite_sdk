import 'package:automaite_android_sdk/provider/cart_provider.dart';
import 'package:automaite_android_sdk/provider/chat_provider.dart';
import 'package:automaite_android_sdk/views/chat_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() => runApp(
      const MyApp(),
    );

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => ChatProvider(),
        ),
        ChangeNotifierProvider(
          create: (_) => CartProvider(),
        ),
      ],
      child: const MaterialApp(
        home: ChatScreen(),
      ),
    );
  }
}
