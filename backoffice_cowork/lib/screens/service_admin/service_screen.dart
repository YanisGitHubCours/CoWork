import 'package:flutter/material.dart';

import '../../widgets/side_menu.dart';
import 'components/service_content.dart';

class ServiceScreen extends StatefulWidget {
  const ServiceScreen({Key? key}) : super(key: key);

  @override
  State<ServiceScreen> createState() => _ServiceScreenState();
}

class _ServiceScreenState extends State<ServiceScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: const <Widget>[
            SideMenu(select: 4),
            Expanded(
              flex: 7,
              child: ServiceContent(),
            ),
          ],
        ),
      ),
    );
  }
}
