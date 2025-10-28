import 'package:flutter/material.dart';

void main() {
  runApp(const MaterialApp(home: FuelCalculator()));
}

class FuelCalculator extends StatefulWidget {
  const FuelCalculator({super.key});

  @override
  State<FuelCalculator> createState() => _FuelCalculatorState();
}

class _FuelCalculatorState extends State<FuelCalculator> {
  TextEditingController distanceController = TextEditingController();
  TextEditingController efficiencyController = TextEditingController();
  TextEditingController priceController = TextEditingController();
  double? distance = 0;
  double? efficiency = 0;
  double? price = 0;
  String estimatedPrice = '';
  String msg = '';
  String efficiencyType = 'km/l';

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: Colors.lime,
      body: Center(
        child: Column(
          children: [
            SizedBox(height: 20),
            Text('FuelOut', style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold, color: Colors.white)),
            SizedBox(height: 5),
            Container(
              width: 380,
              padding: EdgeInsets.symmetric(vertical: 15, horizontal: 20),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
                boxShadow: [
                  BoxShadow(
                    color: Color.fromARGB(148, 158, 158, 158),
                    spreadRadius: 1,
                    blurRadius: 5,
                    offset: Offset(0, 2), // diagonal shadow (bottom-right)
                  ),
                ],
              ), 
              margin: EdgeInsets.only(top: 0, bottom: 20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [ 
                  Row(
                    children: [
                      SizedBox(
                        width: 110,
                        child: Text('Distance: ')
                      ),
                      SizedBox(width: 150, height: 25, child: TextField(
                        keyboardType: TextInputType.number,
                        controller: distanceController,
                        textAlign: TextAlign.center,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          contentPadding: EdgeInsets.symmetric(vertical: 5),
                          hint: Text('Input a number', textAlign: TextAlign.center),
                          )
                        ),
                      ),
                    ]
                  ),
                  SizedBox(height: 0),
                  Row (
                    children: [
                      SizedBox(
                        width: 110,
                        child: Text('Vehicle fuel efficiency: ')
                      ),
                      SizedBox(width: 150, height: 25, child: TextField(
                        keyboardType: TextInputType.number,
                        controller: efficiencyController,
                        textAlign: TextAlign.center,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          contentPadding: EdgeInsets.symmetric(vertical: 5),
                          hint: Text('Input a number', textAlign: TextAlign.center),
                          )
                        ),
                      ),
                      SizedBox(width: 5),
                      DropdownButton<String>(
                        value: efficiencyType,
                        items: <String>['km/l', 'l/100km'].map((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value, style: TextStyle(fontSize: 13)),
                          );
                        }).toList(),
                        onChanged: (String? newValue) {
                          setState(() {
                            efficiencyType = newValue!; 
                          });
                        }
                      ),  
                    ],
                  ),
                  Row(
                    children: [
                      SizedBox(
                        width: 87,
                        child: Text('Fuel price: ')
                      ),
                      Text('RM', style: TextStyle(fontSize: 13)),
                      SizedBox(width: 3),
                      SizedBox(width: 150, height: 25, child: TextField(
                        keyboardType: TextInputType.number,
                        controller: priceController,
                        textAlign: TextAlign.center,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          contentPadding: EdgeInsets.symmetric(vertical: 5),
                          hint: Text('Input a number', textAlign: TextAlign.center),
                          )
                        ),
                      ),
                      SizedBox(width: 5),
                    ],
                  ),
                ],
              )
            ),
            ElevatedButton(style: ElevatedButton.styleFrom(backgroundColor: Colors.white), onPressed: () {
              efficiency = double.tryParse(efficiencyController.text);
              distance = double.tryParse(distanceController.text);
              price = double.tryParse(priceController.text);
              if (efficiency == null || distance == null || price == null || efficiency! <= 0 || distance! <= 0 || price! <= 0) {
                msg = 'Invalid input.';
              } else {
                if (efficiencyType == 'l/100km') {
                  estimatedPrice = ((distance! / 100) * efficiency! * price!).toStringAsFixed(2);
                } else {
                  estimatedPrice = ((distance! / efficiency!) * price!).toStringAsFixed(2);
                }
                msg = 'You will spend RM$estimatedPrice for gas.';
              };
              setState(() {});
            }, child: Text('Calculate')),
            Text(msg, style: TextStyle(fontSize: 16), selectionColor: Colors.white,)
          ],
        )
      ),
    );
  }
}
