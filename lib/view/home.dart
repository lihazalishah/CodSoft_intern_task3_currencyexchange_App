import 'package:currency_converter_app/components/anyToAny.dart';
import 'package:currency_converter_app/components/usdToAny.dart';
import 'package:currency_converter_app/functions/fetchdata.dart';
import 'package:currency_converter_app/models/ratesmodel.dart';
import 'package:flutter/material.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late Future<RatesModel> result;
  late Future<Map> allcurrencies;
  final formkey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    result = fetchrates();
    allcurrencies = fetchCurrencies();
  }

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: const Text(
          'Currency Converter',
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
      ),
      body: Container(
        height: height,
        width: width,
        padding: EdgeInsets.only(top: 60, left: 15, right: 15),
        decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage('assets/demo.jpeg'),
              fit: BoxFit.cover,
              colorFilter:
                  ColorFilter.mode(Colors.grey.shade500, BlendMode.color)),
        ),
        child: SingleChildScrollView(
          child: Form(
            key: formkey,
            child: FutureBuilder<RatesModel>(
              future: result,
              builder: (context, snapshot) {
                try {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(
                      child: Center(child: CircularProgressIndicator()),
                    );
                  }
                  return Center(
                    child: FutureBuilder(
                      future: allcurrencies,
                      builder: (context, Currsnapshot) {
                        try {
                          if (Currsnapshot.connectionState ==
                              ConnectionState.waiting) {
                            return Center(child: CircularProgressIndicator());
                          }
                          return Column(
                            children: [
                              UsdToAny(
                                  rates: snapshot.data!.rates,
                                  currencies: Currsnapshot.data!),
                              SizedBox(
                                height: 50,
                              ),
                              AnyToAny(
                                  rates: snapshot.data!.rates,
                                  currencies: Currsnapshot.data!),
                            ],
                          );
                        } catch (e) {
                          return Center(
                            child: Text(
                              'No internet connection',
                              style:
                                  TextStyle(fontSize: 20, color: Colors.white),
                            ),
                          );
                        }
                      },
                    ),
                  );
                } catch (e) {
                  return Center(
                    child: Text(
                      '${e.toString()}',
                      style: TextStyle(fontSize: 20, color: Colors.white),
                    ),
                  );
                }
              },
            ),
          ),
        ),
      ),
    );
  }
}
