import 'package:flutter/material.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Calculator(),
    );
  }
}

class Calculator extends StatefulWidget {
  const Calculator({super.key});

  @override
  State<Calculator> createState() => _CalculatorState();
}

class _CalculatorState extends State<Calculator> {
  Widget calcButton(String btntxt, Color btnColor, Color txtColor) {
    return Container(
      child: ElevatedButton(
        onPressed: () {
          //Todo
          calculation(btntxt);
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: btnColor,
          shape: const CircleBorder(),
          padding: const EdgeInsets.all(35),
        ),
        child: Text(
          btntxt,
          style: TextStyle(fontSize: 40, color: txtColor),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: const Text(
          'Calculator',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.black,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 5),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            //Calculator Display
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Text(
                      text,
                      textAlign: TextAlign.left,
                      style:
                          const TextStyle(color: Colors.white, fontSize: 100),
                    ))
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                //Buttons to display
                ElevatedButton(
                  onPressed: () {
                    calculation("AC");
                  },
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue.shade300,
                      shape: const CircleBorder(),
                      padding: const EdgeInsets.all(30)),
                  child: const Text(
                    'AC',
                    style: TextStyle(color: Colors.white, fontSize: 30),
                  ),
                ),
                ElevatedButton(
                  onPressed: () {
                    calculation("%");
                  },
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                      shape: const CircleBorder(),
                      padding: const EdgeInsets.all(35)),
                  child: const Text(
                    '%',
                    style: TextStyle(color: Colors.black, fontSize: 35),
                  ),
                ),
                ElevatedButton(
                  onPressed: () {
                    calculation("-");
                  },
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                      shape: const CircleBorder(),
                      padding: const EdgeInsets.all(25)),
                  child: const Text(
                    '+/-',
                    style: TextStyle(color: Colors.black, fontSize: 40),
                  ),
                ),
                calcButton('÷', Colors.grey, Colors.black),
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                //Buttons to display
                calcButton('7', Colors.white, Colors.black),
                calcButton('8', Colors.white, Colors.black),
                calcButton('9', Colors.white, Colors.black),
                ElevatedButton(
                  onPressed: () {
                    calculation('*');
                  },
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.grey,
                      shape: const CircleBorder(),
                      padding: const EdgeInsets.all(35)),
                  child: const Text(
                    '*',
                    style: TextStyle(color: Colors.black, fontSize: 45),
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                //Buttons to display
                calcButton('6', Colors.white, const Color.fromRGBO(0, 0, 0, 1)),
                calcButton('5', Colors.white, Colors.black),
                calcButton('4', Colors.white, Colors.black),
                calcButton('−', Colors.grey, Colors.black),
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                //Buttons to display
                calcButton('3', Colors.white, Colors.black),
                calcButton('2', Colors.white, Colors.black),
                calcButton('1', Colors.white, Colors.black),
                calcButton('+', Colors.grey, Colors.black),
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                //Buttons to display
                calcButton('C', Colors.white, Colors.black),
                calcButton('0', Colors.white, Colors.black),
                ElevatedButton(
                  onPressed: () {
                    calculation(".");
                  },
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                      shape: const CircleBorder(),
                      padding: const EdgeInsets.all(40)),
                  child: const Text(
                    '.',
                    style: TextStyle(color: Colors.black, fontSize: 45),
                  ),
                ),
                calcButton('=', Colors.blue.shade300, Colors.white),
              ],
            ),
            const SizedBox(
              height: 10,
            ),
          ],
        ),
      ),
    );
  }

//Calculation Logic
  dynamic text = '0';
  double numOne = 0;
  double numTwo = 0;

  dynamic result = '';
  dynamic finalResult = '';
  dynamic opr = '';
  dynamic preOpr = '';

  void calculation(btntxt) {
    if (btntxt == 'AC') {
      text = '0';
      numOne = 0;
      numTwo = 0;
      result = '';
      finalResult = '0';
      opr = '';
      preOpr = '';
    } else if (btntxt == 'C') {
      if (finalResult.length >= 2) {
        finalResult = finalResult.substring(0, finalResult.length - 1);
        result = finalResult;
        opr = '';
        preOpr = '';
      } else {
        // finalResult = finalResult.substring(0, finalResult.length - 1);
        result = '';
        finalResult = '0';
        opr = '';
        preOpr = '';
      }
    } else if (opr == '=' && btntxt == '=') {
      if (preOpr == '+') {
        finalResult = add();
      } else if (preOpr == '−') {
        finalResult = sub();
      } else if (preOpr == '*') {
        finalResult = mul();
      } else if (preOpr == '÷') {
        finalResult = div();
      }
    } else if (btntxt == '+' ||
        btntxt == '−' ||
        btntxt == '*' ||
        btntxt == '÷' ||
        btntxt == '=') {
      if (numOne == 0) {
        numOne = double.parse(result);
      } else {
        numTwo = double.parse(result);
      }

      if (opr == '+') {
        finalResult = add();
      } else if (opr == '−') {
        finalResult = sub();
      } else if (opr == '*') {
        finalResult = mul();
      } else if (opr == '÷') {
        finalResult = div();
      }
      preOpr = opr;
      opr = btntxt;
      result = '';
    } else if (btntxt == '%') {
      result = numOne / 100;
      finalResult = doesContainDecimal(result);
    } else if (btntxt == '.') {
      if (!result.toString().contains('.')) {
        result = '$result.';
      }
      finalResult = result;
    } else if (btntxt == '+/-') {
      result.toString().startsWith('−')
          ? result = result.toString().substring(1)
          : result = '-$result';
      finalResult = result;
    } else {
      result = result + btntxt;
      finalResult = result;
    }

    setState(() {
      text = finalResult;
    });
  }

  String add() {
    result = (numOne + numTwo).toString();
    numOne = double.parse(result);
    return doesContainDecimal(result);
  }

  String sub() {
    result = (numOne - numTwo).toString();
    numOne = double.parse(result);
    return doesContainDecimal(result);
  }

  String mul() {
    result = (numOne * numTwo).toString();
    numOne = double.parse(result);
    return doesContainDecimal(result);
  }

  String div() {
    result = (numOne / numTwo).toString();
    numOne = double.parse(result);
    return doesContainDecimal(result);
  }

  String doesContainDecimal(dynamic result) {
    if (result.toString().contains('.')) {
      List<String> splitDecimal = result.toString().split('.');
      if (!(int.parse(splitDecimal[1]) > 0)) {
        return result = splitDecimal[0].toString();
      }
    }
    return result;
  }
}
