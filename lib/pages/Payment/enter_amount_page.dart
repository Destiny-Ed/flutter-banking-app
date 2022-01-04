import 'package:flutter/material.dart';
import 'package:flutter_banking_app/Constants/colors.dart';
import 'package:flutter_banking_app/pages/Payment/flutterwave_payment.dart';
import 'package:flutter_banking_app/widgets/snack_bar.dart';

class WalletPage extends StatefulWidget {
  const WalletPage({Key? key}) : super(key: key);

  @override
  State<WalletPage> createState() => _WalletPageState();
}

class _WalletPageState extends State<WalletPage> {
  final List<String> keyPad = [
    '1',
    '2',
    '3',
    '4',
    '5',
    '6',
    '7',
    '8',
    '9',
    '',
    '0',
    '<'
  ];

  int? index;

  String amount = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: GestureDetector(
          onTap: () {
            Navigator.of(context).pop();
          },
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Icon(
              Icons.arrow_back_ios,
              color: MyColors().primaryColor,
            ),
          ),
        ),
      ),
      body: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: Container(
                height: MediaQuery.of(context).size.height - 120,
                padding: const EdgeInsets.all(10),
                child: Column(
                  children: [
                    // Container(
                    //   child: Text('Total Balance',
                    //       style: TextStyle(color: MyColors().primaryColor)),
                    // ),
                    // Container(
                    //   alignment: Alignment.center,
                    //   child:const Text(
                    //     'NGN 0',
                    //     style: TextStyle(
                    //       fontWeight: FontWeight.bold,
                    //       fontSize: 36,
                    //     ),
                    //     textAlign: TextAlign.center,
                    //   ),
                    // ),
                    Container(
                      alignment: Alignment.center,
                      margin: const EdgeInsets.only(top: 20),
                      padding: const EdgeInsets.all(20),
                      width: MediaQuery.of(context).size.width - 80,
                      decoration: BoxDecoration(
                          color: MyColors().grey,
                          borderRadius: BorderRadius.circular(50)),
                      child: SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Text(amount,
                            style: TextStyle(
                                color: MyColors().black,
                                fontWeight: FontWeight.bold,
                                fontSize: 18)),
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.symmetric(vertical: 10),
                      child: Text('Enter Top Up Amount',
                          style: TextStyle(
                              color: MyColors().black,
                              fontWeight: FontWeight.bold)),
                    ),

                    const SizedBox(
                      height: 20,
                    ),

                    Expanded(
                      child: GridView(
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 3,
                                  mainAxisSpacing: 20,
                                  crossAxisSpacing: 20,
                                  childAspectRatio: 1.3),
                          children: List.generate(
                              keyPad.length,
                              (i) => GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        index = i;
                                      });

                                      print(i);
                                      if (i == 11 && amount != '') {
                                        ///Clear last number
                                        setState(() {
                                          amount = amount.substring(
                                              0, amount.length - 1);
                                        });
                                      } else if (i != 9) {
                                        setState(() {
                                          amount = amount + keyPad[i];
                                        });
                                      }
                                    },
                                    child: Card(
                                      elevation: 8,
                                      shape: const CircleBorder(),
                                      child: CircleAvatar(
                                        backgroundColor: index == null
                                            ? MyColors().white
                                            : index == i
                                                ? MyColors().primaryColor
                                                : MyColors().white,
                                        radius: 10,
                                        child: Text(
                                          keyPad[i],
                                          style: const TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 24),
                                        ),
                                      ),
                                    ),
                                  ))),
                    ),

                    ///Make Withdrawal
                    if (amount != '')
                      GestureDetector(
                        onTap: () {
                          ///
                          if (amount.contains('<')) {
                            showSuccessSnackBar(
                                context, "Invalid character '<'");
                          } else {
                            ///Make payment by calling flutter wave
                            FlutterWavePayment(
                              amount: amount,
                              name: 'gfgh',
                              email: 'destiny@gmail.com',
                              phone: '123456765',
                              ctx: context,
                            ).makePayment();
                          }
                        },
                        child: Container(
                          alignment: Alignment.center,
                          margin: const EdgeInsets.only(top: 20),
                          padding: const EdgeInsets.all(15),
                          width: MediaQuery.of(context).size.width - 160,
                          decoration: BoxDecoration(
                              color: MyColors().primaryColor,
                              borderRadius: BorderRadius.circular(50)),
                          child: Text('Proceed',
                              style: TextStyle(
                                  color: MyColors().white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16)),
                        ),
                      ),
                  ],
                )),
          )
        ],
      ),
    );
  }
}
