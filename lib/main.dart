import 'dart:convert';
import 'package:flutter/services.dart' show rootBundle;
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'dart:async';
import 'package:localstorage/localstorage.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Shelf Life',
        home: Home(
          listItems: const [],
        ),
        theme: ThemeData(
          // Define the default brightness and colors.
          brightness: Brightness.light,
          primaryColor: const Color(0xFF000000),

          // Define the default font family.
          fontFamily: 'Georgia',

          // Define the default `TextTheme`. Use this to specify the default
          // text styling for headlines, titles, bodies of text, and more.
          textTheme: const TextTheme(
            displayLarge:
                TextStyle(fontSize: 72.0, fontWeight: FontWeight.bold),
            titleLarge: TextStyle(fontSize: 36.0, fontStyle: FontStyle.italic),
            bodyMedium: TextStyle(fontSize: 14.0, fontFamily: 'Hind'),
          ),
        ));
  }
}

class Home extends StatelessWidget {
  final LocalStorage storage = LocalStorage('items');
  final List<String> listItems;
  Home({
    super.key,
    required this.listItems,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('ISTE 252 Final Project'),
      ),
      body: Center(
        child: Container(
          constraints: const BoxConstraints(maxWidth: 800),
          margin: const EdgeInsets.only(
              left: 6.0, right: 6.0, top: 6.0, bottom: 100.0),
          child: Column(
            children: [
              Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(
                      width: 50,
                      height: 50,
                      child: SvgPicture.asset("icons/dairy.svg"),
                    ),
                    Row(
                      children: const [
                        Text("My Fridge"),
                        Icon(
                          Icons.list,
                          size: 24.0,
                        )
                      ],
                    ),
                  ]),
              if (itemTracker.isEmpty)
                const Expanded(child: Text("Your list is empty!"))
              else
                Expanded(
                  child: ListView.builder(
                    itemCount: itemTracker.length,
                    prototypeItem: ListTile(
                      title: Text(itemTracker.first.name),
                    ),
                    itemBuilder: (context, index) {
                      return ListTile(
                          title: Container(
                        margin: const EdgeInsets.only(bottom: 10.0),
                        decoration: BoxDecoration(
                            border: Border.all(color: Colors.black)),
                        child: Row(children: [
                          Container(
                            height: 80,
                            padding: const EdgeInsets.all(4.0),
                            decoration: const BoxDecoration(
                              color: Colors.black,
                            ),
                            child: Padding(
                                padding: const EdgeInsets.all(4),
                                child: Text(
                                  "Expires in ${itemTracker.first.shelfLife} Days",
                                  style: const TextStyle(color: Colors.white),
                                )),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 10),
                            child: Text(itemTracker.first.name),
                          )
                        ]),
                      ));
                    },
                  ),
                )
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        // tooltip: 'Add New Items',
        hoverElevation: 6.0,
        hoverColor: const Color.fromRGBO(255, 255, 255, 220),
        backgroundColor: Colors.black,
        label: const Text("Add New Items"),
        icon: const Icon(Icons.add),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const Categories()),
          );
        },
      ),
    );
  }
}

class Categories extends StatelessWidget {
  const Categories({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Categories'),
      ),
      body: Center(
        child: Container(
          margin: const EdgeInsets.all(6.0),
          child: Column(
            children: [
              Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  // ignore: prefer_const_literals_to_create_immutables
                  children: [
                    IconButton(
                        tooltip: "Back",
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        icon: const Icon(Icons.arrow_back)),
                    // ignore: prefer_const_literals_to_create_immutables
                    const Text("Quick Add"),
                  ]),
              Expanded(
                  child: Container(
                constraints: const BoxConstraints(maxWidth: 800),
                margin: const EdgeInsets.all(10),
                child: GridView(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 60,
                      mainAxisSpacing: 40),
                  children: [
                    InkWell(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const Subcategories(
                                  subcategoryName: 'Meats',
                                ),
                              ));
                        },
                        child: Container(
                            decoration: BoxDecoration(border: Border.all()),
                            padding: const EdgeInsets.all(10),
                            child: Center(
                                child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    // ignore: prefer_const_literals_to_create_immutables
                                    children: [
                                  SvgPicture.asset("icons/meats.svg"),
                                  const Text("Meats"),
                                ])))),
                    InkWell(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const Subcategories(
                                  subcategoryName: 'Vegetables',
                                ),
                              ));
                        },
                        child: Container(
                            decoration: BoxDecoration(border: Border.all()),
                            padding: const EdgeInsets.all(10),
                            child: Center(
                                child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    // ignore: prefer_const_literals_to_create_immutables
                                    children: [
                                  SvgPicture.asset("icons/vegetables.svg"),
                                  const Text("Vegetables"),
                                ])))),
                    InkWell(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const Subcategories(
                                  subcategoryName: 'Fruits',
                                ),
                              ));
                        },
                        child: Container(
                            decoration: BoxDecoration(border: Border.all()),
                            padding: const EdgeInsets.all(10),
                            child: Center(
                                child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    // ignore: prefer_const_literals_to_create_immutables
                                    children: [
                                  SvgPicture.asset("icons/fruits.svg"),
                                  const Text("Fruits"),
                                ])))),
                    InkWell(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const Subcategories(
                                  subcategoryName: 'Fresh Seafood',
                                ),
                              ));
                        },
                        child: Container(
                            decoration: BoxDecoration(border: Border.all()),
                            padding: const EdgeInsets.all(10),
                            child: Center(
                                child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    // ignore: prefer_const_literals_to_create_immutables
                                    children: [
                                  SvgPicture.asset("icons/seafood.svg"),
                                  const Text("Fresh Seafood"),
                                ])))),
                    InkWell(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const Subcategories(
                                  subcategoryName: 'Dairy',
                                ),
                              ));
                        },
                        child: Container(
                            decoration: BoxDecoration(border: Border.all()),
                            padding: const EdgeInsets.all(10),
                            child: Center(
                                child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    // ignore: prefer_const_literals_to_create_immutables
                                    children: [
                                  SvgPicture.asset("icons/dairy.svg"),
                                  const Text("Dairy"),
                                ])))),
                  ],
                ),
              ))
            ],
          ),
        ),
      ),
    );
  }
}

class Subcategories extends StatelessWidget {
  final String subcategoryName;
  const Subcategories({super.key, required this.subcategoryName});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Subcategories'),
      ),
      body: Center(
          child: Container(
              margin: const EdgeInsets.all(6.0),
              child: Column(children: [
                Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    // ignore: prefer_const_literals_to_create_immutables
                    children: [
                      IconButton(
                          tooltip: "Back",
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          icon: const Icon(Icons.arrow_back)),
                      // ignore: prefer_const_literals_to_create_immutables
                      Text(subcategoryName),
                    ]),
                Expanded(
                    child: ShelfLifeList(
                  itemName: subcategoryName,
                ))
              ]))),
      floatingActionButton: FloatingActionButton.extended(
        // tooltip: 'Back to My List',
        hoverElevation: 6.0,
        hoverColor: const Color.fromRGBO(255, 255, 255, 220),
        backgroundColor: Colors.black,
        label: const Text('Finish'),
        icon: const Icon(Icons.check),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => Home(
                      listItems: const [],
                    )),
          );
        },
      ),
    );
  }
}

class NewItem {
  String name;
  String shelfLife;

  NewItem({required this.name, required this.shelfLife});
}

List<NewItem> itemTracker = [];

class ShelfLifeList extends StatefulWidget {
  final String itemName;
  const ShelfLifeList({super.key, required this.itemName});

  @override
  State<ShelfLifeList> createState() => _ShelfLifeListState();
}

class _ShelfLifeListState extends State<ShelfLifeList> {
  late NewItem tempItem;
  List _items = [];
  final LocalStorage storage = LocalStorage('todo_app');
  bool initialized = false;

  // Fetch content from the json file
  Future<void> readJson() async {
    final String response = await rootBundle.loadString('items.json');
    final data = await json.decode(response);

    setState(() {
      _items = data[widget.itemName];
    });
  }

  void setItem(NewItem itemFinal) {
    setState(() {
      itemTracker.add(itemFinal);
    });
  }

  @override
  void initState() {
    super.initState();
    readJson();
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: _items.length,
      itemBuilder: (context, index) {
        return InkWell(
            onTap: () {
              NewItem itemFinal = NewItem(
                  name: _items[index]["name"],
                  shelfLife: _items[index]["shelfLife"]);
              setItem(itemFinal);

              // debugPrint(itemTracker as String?);
            },
            child: Card(
              key: ValueKey(_items[index]),
              margin: const EdgeInsets.all(10),
              color: Colors.amber.shade100,
              child: ListTile(
                title: Text(_items[index]["name"]),
              ),
            ));
      },
    );
  }
}
