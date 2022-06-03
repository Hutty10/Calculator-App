import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';


class ScientificCalculator extends StatefulWidget {
  @override
  _ScientificCalculator createState() => _ScientificCalculator();
}

class _ScientificCalculator extends State<ScientificCalculator>
    with WidgetsBindingObserver {
  @override
  dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    print('state');
  }

  @override
  void initState() {
    WidgetsBinding.instance.addObserver(this);
    super.initState();
  }

  String equation = '0';
  String result = '0';
  String expression = '';
  double equationFontSize = 38;
  double resultFontSize = 48;

  buttonPressed(String buttonText) {
    setState(() {
      if (buttonText == 'C') {
        equationFontSize = 38;
        resultFontSize = 48;
        equation = '0';
        result = '0';
      } else if (buttonText == '⌫') {
        equationFontSize = 48;
        resultFontSize = 38;
        equation = equation.substring(0, equation.length - 1);
        if (equation == '') {
          equation = '0';
        }
      } else if (buttonText == '=') {
        equationFontSize = 38;
        resultFontSize = 48;
        expression = equation;
        expression = expression.replaceAll('×', '*');
        expression = expression.replaceAll('÷', '/');

        try {
          Parser p = Parser();
          Expression exp = p.parse(expression);
          ContextModel cm = ContextModel();
          result = '${exp.evaluate(EvaluationType.REAL, cm)}';
        } catch (e) {
          result = 'Error';
        }
      } else {
        if (equation == '0') {
          equationFontSize = 48;
          resultFontSize = 38;
          equation = buttonText;
        } else {
          equation = equation + buttonText;
        }
      }
    });
  }

  Widget buildButton(
    String buttonText,
    double buttonHeight,
    Color buttonColor,
  ) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.1 * buttonHeight,
      color: buttonColor,
      child: FlatButton(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(0),
          side: BorderSide(
            color: Colors.white,
            width: 1,
            style: BorderStyle.solid,
          ),
        ),
        padding: EdgeInsets.all(16),
        onPressed: () => buttonPressed(buttonText),
        child: Text(
          buttonText,
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w300,
            color: Colors.white,
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Scientific Calculator'),
      ),
      body: Column(
        children: <Widget>[
          Container(
            alignment: Alignment.centerRight,
            padding: EdgeInsets.fromLTRB(10, 20, 10, 0),
            child: Text(
              equation,
              style: TextStyle(fontSize: equationFontSize),
            ),
          ),
          Container(
            alignment: Alignment.centerRight,
            padding: EdgeInsets.fromLTRB(10, 30, 10, 0),
            child: Text(
              result,
              style: TextStyle(fontSize: resultFontSize),
            ),
          ),
          Expanded(
            child: Divider(),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Container(
                width: MediaQuery.of(context).size.width * 1,
                child: Table(
                  children: [
                    TableRow(
                      children: <Widget>[
                        buildButton('sin', 1, Colors.blue),
                        buildButton('cos', 1, Colors.blue),
                        buildButton('tan', 1, Colors.blue),
                        buildButton('log', 1, Colors.blue),
                        buildButton('⌫', 1, Colors.blue),
                      ],
                    ),
                    TableRow(
                      children: <Widget>[
                        buildButton('÷', 1, Colors.blue),
                        buildButton('×', 1, Colors.blue),
                        buildButton('-', 1, Colors.blue),
                        buildButton('+', 1, Colors.blue),
                        buildButton('ln', 1, Colors.blue),
                      ],
                    ),
                    TableRow(
                      children: <Widget>[
                        buildButton('7', 1, Colors.black54),
                        buildButton('8', 1, Colors.black54),
                        buildButton('9', 1, Colors.black54),
                        buildButton('(', 1, Colors.blue),
                        buildButton(')', 1, Colors.blue),
                      ],
                    ),
                    TableRow(
                      children: <Widget>[
                        buildButton('4', 1, Colors.black54),
                        buildButton('5', 1, Colors.black54),
                        buildButton('6', 1, Colors.black54),
                        buildButton('-//', 1, Colors.blue),
                        buildButton('!', 1, Colors.blue),
                      ],
                    ),
                    TableRow(
                      children: <Widget>[
                        buildButton('1', 1, Colors.black54),
                        buildButton('2', 1, Colors.black54),
                        buildButton('3', 1, Colors.black54),
                        buildButton('//-', 1, Colors.blue),
                        buildButton('-//', 1, Colors.blue),
                      ],
                    ),
                    TableRow(
                      children: <Widget>[
                        buildButton('.', 1, Colors.black54),
                        buildButton('0', 1, Colors.black54),
                        buildButton('00', 1, Colors.black54),
                        buildButton('e', 1, Colors.blue),
                        buildButton('=', 1, Colors.redAccent),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
