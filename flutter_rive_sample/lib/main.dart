import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:rive/rive.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      home: MyPage(),
    );
  }
}

class MyPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Using Rive'),
        ),
        body: RocketContainer());
  }
}

class RocketContainer extends StatefulWidget {
  @override
  _RocketContainerState createState() => _RocketContainerState();
}

class _RocketContainerState extends State<RocketContainer> {
  Artboard _artboard;
  RiveAnimationController _rocketController;

  @override
  void initState() {
    _loadRiveFile();
    super.initState();
  }

  void _loadRiveFile() async {
    final bytes = await rootBundle.load('assets/rocket.riv');
    final file = RiveFile.import(bytes);

    setState(() {
      _artboard = file.mainArtboard;
    });
  }

  void _launch() async {
    _artboard.addController(
      _rocketController = SimpleAnimation('launch'),
    );
    setState(() => _rocketController.isActive = true);
  }

  void _fall() async {
    _artboard.addController(
      _rocketController = SimpleAnimation('fall'),
    );
    setState(() => _rocketController.isActive = true);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height - 250,
            child: _artboard != null
                ? Rive(
                    artboard: _artboard,
                    fit: BoxFit.cover,
                  )
                : Container()),
        TextButton(onPressed: () => _launch(), child: Text('launch')),
        TextButton(onPressed: () => _fall(), child: Text('fall'))
      ],
    );
  }
}
