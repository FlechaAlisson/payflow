import 'package:flutter/material.dart';
import 'package:payflow/modules/home/home_controller.dart';
import 'package:payflow/shared/themes/appcolors.dart';
import 'package:payflow/shared/themes/apptexts.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final HomeController homeController = HomeController();
  final pages = [
    Container(
      color: Colors.blue,
    ),
    Container(color: Colors.red),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(152),
        child: Container(
          height: 130,
          color: AppColors.primary,
          child: Center(
            child: ListTile(
              title: Text.rich(
                TextSpan(
                    text: "Olá, ",
                    style: TextStyles.titleRegular,
                    children: [
                      TextSpan(
                          text: "Alisson Flecha",
                          style: TextStyles.titleBoldBackground),
                    ]),
              ),
              subtitle: Text(
                "Mantenha seus boletos em dia.",
                style: TextStyles.captionShape,
              ),
              trailing: Container(
                height: 48,
                width: 48,
                decoration: BoxDecoration(
                    color: Colors.black,
                    borderRadius: BorderRadius.circular(5)),
              ),
            ),
          ),
        ),
      ),
      body: pages[homeController.currentPage],
      bottomNavigationBar: Container(
        height: 90,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            IconButton(
                onPressed: () {
                  homeController.setPage(0);
                  setState(() {});
                },
                icon: Icon(
                  Icons.home,
                  color: AppColors.primary,
                )),
            Container(
                width: 56,
                height: 56,
                decoration: BoxDecoration(
                    color: AppColors.primary,
                    borderRadius: BorderRadius.circular(5)),
                child: IconButton(
                    onPressed: () {
                      print('oi');
                    },
                    icon: Icon(
                      Icons.add_box_outlined,
                      color: AppColors.background,
                    ))),
            IconButton(
                onPressed: () {
                  homeController.setPage(1);

                  setState(() {});
                },
                icon: Icon(Icons.description_outlined))
          ],
        ),
      ),
    );
  }
}
