import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/facebook.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:wheel_chooser/wheel_chooser.dart';

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
      theme: ThemeData(
        // This is the theme of your application.
        //
        // TRY THIS: Try running your application with "flutter run". You'll see
        // the application has a purple toolbar. Then, without quitting the app,
        // try changing the seedColor in the colorScheme below to Colors.green
        // and then invoke "hot reload" (save your changes or press the "hot
        // reload" button in a Flutter-supported IDE, or press "r" if you used
        // the command line to start the app).
        //
        // Notice that the counter didn't reset back to zero; the application
        // state is not lost during the reload. To reset the state, use hot
        // restart instead.
        //
        // This works for code too, not just values: Most code changes can be
        // tested with just a hot reload.
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: Page1(),
    );
  }
}

class Page1 extends StatefulWidget {
  const Page1({super.key});

  @override
  State<Page1> createState() => _Page1State();
}

class _Page1State extends State<Page1> {
  final ScrollController _scrollController = ScrollController();
  final double itemHeight = 60.0; // Fixed height for each item
  final int myIndex = 18; // Index of the special item
  bool showFloating = true;

  late List<String> items;

  @override
  void initState() {
    super.initState();
    items = List.generate(30, (i) => "Item ${i + 1}");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Floating String Example")),
      body: Column(
        children: [
          SizedBox(height: 100),
          Expanded(
            child: Stack(
              children: [
                NotificationListener<ScrollNotification>(
                  onNotification: (scrollNotification) {
                    final scrollOffset = scrollNotification.metrics.pixels;
                    final screenHeight =
                        scrollNotification.metrics.viewportDimension;

                    final itemTop = myIndex * itemHeight;
                    final itemBottom = itemTop + itemHeight;

                    final visibleTop = scrollOffset;
                    final visibleBottom = scrollOffset + screenHeight;

                    final isInView =
                        itemBottom >= visibleTop && itemTop <= visibleBottom;
                    print(screenHeight);

                    if (isInView && showFloating) {
                      setState(() {
                        showFloating = false;
                      });
                    } else if (!isInView && !showFloating) {
                      setState(() {
                        showFloating = true;
                      });
                    }
                    return false;
                  },
                  child: ListView.builder(
                    controller: _scrollController,
                    itemCount: items.length,
                    itemBuilder: (context, index) {
                      return Container(
                        height: itemHeight,
                        alignment: Alignment.centerLeft,
                        padding: EdgeInsets.symmetric(horizontal: 16),
                        decoration: BoxDecoration(
                          border: Border(
                            bottom: BorderSide(color: Colors.grey.shade300),
                          ),
                        ),
                        child: Text(
                          items[index],
                          style: TextStyle(fontSize: 16),
                        ),
                      );
                    },
                  ),
                ),
                if (showFloating)
                  Positioned(
                    bottom: 0,
                    left: 0,
                    right: 0,
                    child: Container(
                      height: itemHeight,
                      color: Colors.green,
                      alignment: Alignment.centerLeft,
                      padding: EdgeInsets.symmetric(horizontal: 16),
                      child: Text(
                        items[myIndex],
                        style: TextStyle(fontSize: 16, color: Colors.white),
                      ),
                    ),
                  ),
              ],
            ),
          ),
          SizedBox(height: 100),
        ],
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;
  final List<int> spinList = [];
  final controller = FixedExtentScrollController();
  void _incrementCounter() {
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
    return Scaffold(
      appBar: AppBar(
        // TRY THIS: Try changing the color here to a specific color (to
        // Colors.amber, perhaps?) and trigger a hot reload to see the AppBar
        // change color while the other colors stay the same.
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
      ),
      body: Center(
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.
        child: Column(
          // Column is also a layout widget. It takes a list of children and
          // arranges them vertically. By default, it sizes itself to fit its
          // children horizontally, and tries to be as tall as its parent.
          //
          // Column has various properties to control how it sizes itself and
          // how it positions its children. Here we use mainAxisAlignment to
          // center the children vertically; the main axis here is the vertical
          // axis because Columns are vertical (the cross axis would be
          // horizontal).
          //
          // TRY THIS: Invoke "debug painting" (choose the "Toggle Debug Paint"
          // action in the IDE, or press "p" in the console), to see the
          // wireframe for each widget.
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text('You have pushed the button this many times:'),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            GestureDetector(
              onHorizontalDragEnd: (details) {
                print("pressed");
              },
              child: Text("something"),
            ),

            NotificationListener<ScrollNotification>(
              onNotification: (notification) {
                if (notification is ScrollStartNotification) {
                  print('starting');
                } else if (notification is ScrollEndNotification) {
                  print('stopped');
                  print(spinList.last);
                }
                return true;
              },
              child: WheelChooser(
                controller: controller,
                startPosition: null,
                listWidth: MediaQuery.of(context).size.width * 1.5,
                itemSize: 70,
                squeeze: 1.0,
                perspective: 0.01,
                datas: [1, 5, 10, 20, 30],
                isInfinite: true,
                magnification: 1,
                listHeight: 100,
                onValueChanged: (s) {
                  // appLog(s);
                  spinList.add(s);

                  // controller.handleWheelValueChanged2(s.toString());
                  // final selectedIndex = controller
                  //     .wheelController.selectedItem;
                  // controller.spinWheelByHand(selectedIndex);
                },
                // controller.spinWheel(),
                // Trim spaces for logging
                selectTextStyle: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.green,
                ),
                unSelectTextStyle: const TextStyle(
                  fontSize: 16,
                  color: Colors.grey,
                  backgroundColor: Colors.transparent,
                ),
                horizontal: true,
              ),
            ),

            ElevatedButton(
              onPressed: () {
                FacebookSignIn.signInWithFacebook();
              },
              child: Text("Sign in Facebook"),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
