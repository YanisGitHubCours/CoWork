import 'package:backoffice_cowork/models/model_service.dart';
import 'package:backoffice_cowork/requests/services.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';

import '../../../utils/constants.dart';
import '../../../widgets/custom_appbar.dart';
import '../../../widgets/services_data_row.dart';
import '../new_service.dart';

class ServiceContent extends StatefulWidget {
  const ServiceContent({Key? key}) : super(key: key);

  @override
  State<ServiceContent> createState() => _ServiceContentState();
}

class _ServiceContentState extends State<ServiceContent> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          const CustomAppBar(title: "Services", backward: false),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(defaultPadding),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  MouseRegion(
                    cursor: MaterialStateMouseCursor.clickable,
                    child: GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          PageTransition(
                            type: PageTransitionType.fade,
                            child: const NewService(),
                          ),
                        );
                      },
                      child: const Icon(
                        Icons.add,
                        color: primaryColor,
                        size: 35,
                      ),
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.all(defaultPadding),
                    child: SizedBox(
                      width: double.infinity,
                      child: FutureBuilder(
                        future: Services.getAllServicesDesc(),
                        builder: (BuildContext context, AsyncSnapshot snapshot) {
                          switch (snapshot.connectionState) {
                            case ConnectionState.waiting:
                              return const Center(
                                child:
                                CircularProgressIndicator(color: primaryColor),
                              );
                              break;
                            case ConnectionState.done:
                              if (snapshot.hasError) {
                                return Center(
                                  child: Text("Error: ${snapshot.error}"),
                                );
                              }
                              if (snapshot.hasData) {
                                final List<Service> services = snapshot.data;
                                if (services.isEmpty) {
                                  return const Center(
                                    child: Text(
                                      "Aucun utilisateur",
                                      style: TextStyle(
                                        fontStyle: FontStyle.italic,
                                        fontFamily: 'Helvetica',
                                        fontSize: 40,
                                        color: Colors.black12,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  );
                                }
                                return DataTable(
                                  horizontalMargin: 0,
                                  columnSpacing: defaultPadding,
                                  columns: const [
                                    DataColumn(
                                      label: Text(
                                        "ID",
                                        style: TextStyle(
                                          fontFamily: "Comfortaa",
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                    DataColumn(
                                      label: Text(
                                        "Nom",
                                        style: TextStyle(
                                          fontFamily: "Comfortaa",
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                    DataColumn(
                                      label: Text(
                                        "Prix",
                                        style: TextStyle(
                                          fontFamily: "Comfortaa",
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                    DataColumn(
                                      label: Text(""),
                                    ),
                                  ],
                                  rows: List.generate(
                                    services.length,
                                        (index) => servicesDataRow(services[index], context),
                                  ),
                                );
                              } else {
                                return const Center(
                                  child: Text(
                                    "Aucun Utilisateur",
                                    style: TextStyle(
                                      fontStyle: FontStyle.italic,
                                      fontFamily: 'Helvetica',
                                      fontSize: 40,
                                      color: Colors.black12,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                );
                              }
                            default:
                              return Container();
                          }
                        },
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
