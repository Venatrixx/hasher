import 'package:flutter/material.dart';
import 'package:material_symbols_icons/symbols.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  final inputController = TextEditingController();
  String? output;

  @override
  void dispose() {
    inputController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(leading: Icon(Symbols.tag_rounded), title: Text("Hasher")),

      body: SafeArea(
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: inputController,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: "raw string",
                    ),
                  ),
                ),
              ],
            ),

            if (output != null)
              Row(
                children: [
                  Expanded(child: Text(output!)),
                  IconButton(
                    onPressed: () {},
                    icon: Icon(Symbols.copy_all_rounded),
                  ),
                ],
              ),
          ],
        ),
      ),
    );
  }
}
