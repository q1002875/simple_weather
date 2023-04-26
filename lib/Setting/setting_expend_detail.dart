
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:simple_weahter/Setting/setting_list.dart';

import '../ExtensionToolClass/CustomText.dart';
import '../provider/provider_ localization.dart';
import '../provider/provider_theme.dart';

class setting_expend_detail extends StatelessWidget {
  final int section;
  final int index;
  final SettingList data;
  final double screenheight;

  const setting_expend_detail({key, this.data, this.section, this.index,this.screenheight});

  Widget show_detailText(
      Locale lcale, Image image, SettingList item, int section, int index) {
    switch (section) {
      case 0:
        if (lcale == item.locale[index]) {
          return Flex(
            direction: Axis.horizontal,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Flexible(
                  flex: 1,
                  child: CustomText(
                    textContent: item.body[index],
                    textColor: Colors.yellow,
                  )),
              Flexible(
                  flex: 1,
                  child: Icon(
                    Icons.check_circle_sharp,
                    color: Colors.yellow,
                  ))
            ],
          );
        } else {
          return CustomText(
            textContent: item.body[index],
            textColor: Colors.white,
          );
        }

        break;

      case 1:
       String imagePath = (image.image as AssetImage).assetName;
        print(imagePath);
        if (imagePath == item.imageS[index]) {
          return Flex(
            direction: Axis.horizontal,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Flexible(
                  flex: 1,
                  child: CustomText(
                    textContent: item.body[index],
                    textColor: Colors.yellow,
                  )),
              Flexible(
                  flex: 1,
                  child: Icon(
                    Icons.check_circle_sharp,
                    color: Colors.yellow,
                  ))
            ],
          );
        } else {
          return CustomText(
            textContent: item.body[index],
            textColor: Colors.white,
          );
        }
    }
  }

  @override
  Widget build(BuildContext context) {
    final locale = context.read<LocaleProvider>().locale;
    final image = context.read<ThemeProvider>().pimage;
    return Center(
      child:
       Container(
          decoration: BoxDecoration(
            color: Color.fromARGB(255, 74, 57, 131),
            borderRadius: BorderRadius.circular(10),
          ),
          margin: EdgeInsets.all(4),
          alignment: Alignment.center,
          height: (screenheight/2),
          width: double.infinity,
          child: show_detailText(locale, image, data, section, index)),
    );
  }
}
