import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:math_expressions/math_expressions.dart';
import 'package:flutter_svg/flutter_svg.dart';

class MyHomePage extends StatefulWidget {
  MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<String> list = [
    'C',
    '÷',
    '×',
    '⌫',
    '7',
    '8',
    '9',
    '-',
    '4',
    '5',
    '6',
    '+',
    '1',
    '2',
    '3',
    '=',
    '%',
    '0',
    '.',
  ];
  var input = '';
  var output = '';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xfff492b7c),
      appBar: AppBar(
        title: Row(
          children: [
            Text(
              'Calcu'.toUpperCase(),
              style: TextStyle(
                  color: Color(0xfff122c91),
                  fontFamily: 'myFont',
                  fontSize: 40,
                  fontWeight: FontWeight.bold),
            ),
            Text(
              'lator'.toUpperCase(),
              style: TextStyle(
                  fontFamily: 'myFont',
                  fontSize: 40,
                  fontWeight: FontWeight.bold),
            ),
          ],
        ),
        backgroundColor: Colors.transparent,
        elevation: 0.0,
      ),
      extendBodyBehindAppBar: true,
      body: Column(
        children: [
          Stack(clipBehavior: Clip.none, children: [
            Container(
              padding: EdgeInsets.all(20),
              alignment: Alignment.bottomRight,
              height: MediaQuery.of(context).size.height * 0.35,
              width: MediaQuery.of(context).size.width,
              child: Text(
                '$output',
                style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 40,
                    fontFamily: 'myFont'),
              ),
              decoration: BoxDecoration(
                  gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [Color(0xfff122c91), Color(0xfff492b7c)])),
            ),
            Positioned(
                top: -100,
                left: -90,
                child: Container(
                    child: SvgPicture.asset(
                  'assets/blob.svg',
                  height: 300,
                  color: Colors.white.withOpacity(0.6),
                ))),
          ]),
          Expanded(
              child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: GridView.builder(
              itemCount: list.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 4,
                  childAspectRatio: 1,
                  mainAxisSpacing: 10,
                  crossAxisSpacing: 10),
              itemBuilder: (context, index) {
                return costumButton(list[index]);
              },
            ),
          ))
        ],
      ),
    );
  }

  Widget costumButton(String text) {
    return InkWell(
      onTap: () {
        setState(() {
          onPressed(text);
        });
      },
      child: Container(
        alignment: Alignment.center,
        decoration: BoxDecoration(
            color: color(text), borderRadius: BorderRadius.circular(110)),
        child: Text(
          text,
          style: TextStyle(
              color: Colors.white, fontSize: size(text), fontFamily: 'myFont'),
        ),
      ),
    );
  }

  color(String text) {
    if (text == '+' ||
        text == '×' ||
        text == '-' ||
        text == '÷' ||
        text == '⌫' ||
        text == 'C') {
      return Colors.blue.withOpacity(0.6);
    } else if (text == '=') {
      return Color(0xfff122c91);
    } else
      return Colors.white.withOpacity(0.2);
  }

  onPressed(String text) {
    if (text == 'C') {
      output = "";
    } else if (text == '⌫') {
      if (output.length == 0) {
        output = '';
      } else {
        output = output.substring(0, output.length - 1);
      }
    } else if (text == '=') {
      output;
      output = output.replaceAll('×', '*');
      output = output.replaceAll('÷', '/');
      // output = output.replaceAll('.', ',');
      try {
        Parser p = Parser();

        Expression exp = p.parse(output);
        ContextModel cm = ContextModel();
        output = '${exp.evaluate(EvaluationType.REAL, cm)}';
      } catch (e) {
        output = 'Not possible';
      }
    } else {
      output = output + text;
    }
  }

  size(String text) {
    if (text == 'C' || text == '×' || text == '÷' || text == '⌫') {
      return 25.0;
    } else
      return 40.0;
  }
}
