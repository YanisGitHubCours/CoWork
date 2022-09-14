import 'package:backoffice_cowork/requests/services.dart';
import 'package:backoffice_cowork/requests/subscribes.dart';
import 'package:backoffice_cowork/screens/subscribe_admin/subscribe_screen.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';

import '../../../utils/constants.dart';


class CounterSubscribe extends StatelessWidget {
  const CounterSubscribe({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: MaterialStateMouseCursor.clickable,
      child: GestureDetector(
        onTap: () {
          Navigator.push(
              context,
              PageTransition(
                  type: PageTransitionType.fade, child: const SubscribeScreen()));
        },
        child: Container(
          decoration: BoxDecoration(
            border:
            Border.all(width: 8.0, color: primaryColor),
          ),
          child: Column(
            children: [
              const Padding(
                padding: EdgeInsets.all(defaultPadding),
                child: Text(
                  'Abonnements : ',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: primaryColor,
                    fontSize: 50,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Comfortaa',
                  ),
                ),
              ),
              Expanded(
                child: FutureBuilder(
                  future: Subscribes.countSubscribes(),
                  builder: (BuildContext context,
                      AsyncSnapshot snapshot) {
                    switch (snapshot.connectionState) {
                      case ConnectionState.waiting:
                        return const Center(
                          child: CircularProgressIndicator(
                              color: primaryColor),
                        );
                        break;
                      case ConnectionState.done:
                        if (snapshot.hasError) {
                          return Center(
                            child: Text("Error: ${snapshot.error}"),
                          );
                        }
                        if (snapshot.hasData) {
                          final counter = snapshot.data;
                          if (counter == 0) {
                            return Center(
                              child: Text(
                                "Aucun abonnement",
                                style: TextStyle(
                                  color: primaryColor.withOpacity(0.3),
                                ),
                              ),
                            );
                          }
                          return Center(
                            child: Text(
                              "$counter",
                              style: const TextStyle(
                                fontSize: 250,
                                color: primaryColor,
                                fontWeight: FontWeight.bold,
                                fontFamily: 'Comfortaa',
                              ),
                            ),
                          );
                        } else {
                          return const Center(
                            child: Text("No data"),
                          );
                        }
                        break;
                      default:
                        return Container();
                        break;
                    }
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}