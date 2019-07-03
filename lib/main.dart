import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(home: Home()));
}

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {

  TextEditingController weightController = TextEditingController();
  TextEditingController heightController = TextEditingController();

  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  String _infoText = "Informe seus dados";

  void _resetField() {
    weightController.text = "";
    heightController.text = "";
    setState(() {
      _infoText = "Informe seus dados";
      _formKey = GlobalKey<FormState>();
    });
  }

  void _calculate() {

    double weight = double.parse(weightController.text);
    double height = double.parse(heightController.text) / 100;

    double imc = weight / (height * height);
    print(imc);

    setState(() {
      if (imc < 18.6) {
        _infoText = "Abaixo do Peso (${imc.toStringAsPrecision(4)})";
      } else if (imc >= 18.6 && imc < 24.9) {
        _infoText = "Peso Ideal (${imc.toStringAsPrecision(4)})";
      } else if (imc >= 24.9 && imc < 34.9) {
        _infoText = "Obesidade Grau I (${imc.toStringAsPrecision(4)})";
      } else if (imc >= 34.9 && imc < 39.9) {
        _infoText = "Obesidade Grau II (${imc.toStringAsPrecision(4)})";
      } else if (imc >= 40) {
        _infoText = "Obesidade Grau III (${imc.toStringAsPrecision(4)})";
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Calculadora de IMC"),
        centerTitle: true,
        backgroundColor: Colors.black54,
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.refresh),
            onPressed: _resetField,
          )
        ],
      ),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        padding: EdgeInsets.fromLTRB(16.0, 24.0, 16.0, 0.0),
        child: Form(
          key: _formKey,
            child: Column(
              // Utiliza o eixo cruzado
              // tenta alargar tudo o que tiver na coluna
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Icon(
                  Icons.person_outline,
                  size: 120.0,
                  color: Colors.black54,
                ),

                TextFormField(
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    labelText: "Peso (kg)",
                    labelStyle: TextStyle(color: Colors.black54),
                  ),
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.black54, fontSize: 25.0),
                  controller: weightController,
                  validator: (value) {
                    if (value.isEmpty) {
                      return "Insira seu peso";
                    }
                  },
                ),

                TextFormField(
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    labelText: "Altura (cm)",
                    labelStyle: TextStyle(color: Colors.black54),
                  ),
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.black54, fontSize: 25.0),
                  controller: heightController,
                  validator: (value) {
                    if (value.isEmpty) {
                      return "Insira sua altura";
                    }
                  }
                ),

                Padding(
                  padding: EdgeInsets.only(top: 16.0, bottom: 16.0),
                  child: Container(
                    height: 50.0,
                    child: RaisedButton(
                      onPressed: () {
                        if (_formKey.currentState.validate()) {
                          _calculate();
                        }
                      },
                      child: Text(
                        "Calcular",
                        style: TextStyle(color: Colors.black54, fontSize: 25.0),
                      ),
                      color: Colors.amberAccent,
                    ),
                  ),
                ),

                Text(
                  _infoText,
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.amberAccent, fontSize: 25.0),
                )
              ],
            ),
        )
      )
    );
  }
}
