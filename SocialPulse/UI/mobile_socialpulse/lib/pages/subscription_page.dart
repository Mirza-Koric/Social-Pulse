import 'package:flutter/material.dart';
import 'package:flutter_paypal/flutter_paypal.dart';
import 'package:mobile_socialpulse/providers/subscription_provider.dart';
import 'package:provider/provider.dart';

import '../utils/utils.dart';

class SubscriptionPage extends StatefulWidget {
  const SubscriptionPage({super.key});

  @override
  State<SubscriptionPage> createState() => _SubscriptionPageState();
}

class _SubscriptionPageState extends State<SubscriptionPage> {
  late SubscriptionProvider _subscriptionProvider = SubscriptionProvider();

  bool isPayed = false;
  String make = "";

  @override
  void initState() {
    super.initState();
    _subscriptionProvider = context.read<SubscriptionProvider>();
  }

  @override
  Widget build(BuildContext context) {
    make = "Make Payment";
    return Scaffold(
        appBar: AppBar(
            title: const Text("Payment"),
            centerTitle: true,
            leading: IconButton(
                onPressed: () {
                  Navigator.pop(context,true);
                },
                icon: const Icon(Icons.arrow_back))
        ),
        body: Center(
          child: isPayed == true
              ? const Text(
            "Purchase successful.\n Your premium account last for a month.",
            style: TextStyle(fontSize: 18),
            textAlign: TextAlign.center,
          )
              : ElevatedButton.icon(
              icon: const Icon(Icons.paypal, color: Colors.lightBlue),
              style: ElevatedButton.styleFrom(
                  backgroundColor: const Color.fromRGBO(0, 48, 135, 1)),
              onPressed: () {


                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (BuildContext context) => UsePaypal(
                        sandboxMode: true,
                        clientId:
                        'AWofpeGnoOl2NenkQZ6T5rxxbtdO75rxI870_ALM2LQUZDtvD0hnQ2Ck9P9iF_5yxEF1J5EIFe1_ZR3o',
                        secretKey:
                        'EELynPzPkxI0xDIP7MREiqV5XtvCyQNH8LldMA42BkMQTmEph9KSCmSUv1AcAZBdVCPBhSGrau9OoiS8',
                        returnURL: "https://samplesite.com/return",
                        cancelURL: "https://samplesite.com/cancel",
                        transactions: const [
                          {
                            "amount": {
                              "total": '5.00',
                              "currency": "USD",
                              "details": {
                                "subtotal": '5.00',
                                "shipping": '0',
                                "shipping_discount": 0
                              }
                            },
                            "description":
                            "The payment transaction description.",
                            "item_list": {
                              "items": [
                                {
                                  "name": "Premium account",
                                  "quantity": 1,
                                  "price": '5.00',
                                  "currency": "USD"
                                }
                              ],
                            }
                          }
                        ],
                        note:
                        "Contact us for any questions on your subscription.",
                        onSuccess: (Map params) async {
                          try {
                            await _subscriptionProvider.paySubscription(int.parse(
                                Authentification.tokenDecoded!['Id']));

                            if (mounted) {
                              setState(() {
                                isPayed = true;
                              });
                            }
                          } on Exception catch (e) {
                            if(mounted) {
                              alertBoxMoveBack(
                                  context,
                                  "Error",
                                  e.toString());
                            }
                          }
                        },
                        onError: (error) {
                        },
                        onCancel: (params) {
                          alertBox(
                              context,
                              "Error",
                              'Payment is canceled');
                        }),
                  ),
                );
              },
              label: Text(
                make,
                style: const TextStyle(fontSize: 18, color: Colors.lightBlue),
              )),
        ));
  }
}
