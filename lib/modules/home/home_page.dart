import 'package:flutter/material.dart';
import 'package:payflow/modules/extract/extract_page.dart';
import 'package:payflow/modules/home/home_controller.dart';
import 'package:payflow/modules/meu_boletos/meus_boletos_page.dart';
import 'package:payflow/shared/models/user_model.dart';
import 'package:payflow/shared/themes/appcolors.dart';
import 'package:payflow/shared/themes/apptexts.dart';

class HomePage extends StatefulWidget {
  final UserModel user;
  const HomePage({Key? key, required this.user}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final HomeController homeController = HomeController();
  final pages = [
    Container(child: MeusBoletosPages()),
    Container(child: ExtractPage()),
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
                          text: "${widget.user.name}",
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
                  borderRadius: BorderRadius.circular(5),
                  image: DecorationImage(
                    image: NetworkImage(widget.user.photoURL!),
                  ),
                ),
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
                  color: homeController.currentPage == 0
                      ? AppColors.primary
                      : AppColors.body,
                )),
            Container(
                width: 56,
                height: 56,
                decoration: BoxDecoration(
                    color: AppColors.primary,
                    borderRadius: BorderRadius.circular(5)),
                child: IconButton(
                    onPressed: () async {
                      await Navigator.pushNamed(context, "/barcode_scanner");
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
                icon: Icon(
                  Icons.description_outlined,
                  color: homeController.currentPage == 1
                      ? AppColors.primary
                      : AppColors.body,
                ))
          ],
        ),
      ),
    );
  }
}
