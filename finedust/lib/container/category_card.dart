import 'package:finedust/component/card_title.dart';
import 'package:finedust/utils/data_utils.dart';
import 'package:flutter/material.dart';

import '../component/main_card.dart';
import '../component/main_stat.dart';
import '../const/colors.dart';
import '../model/stat_and_status.dart';

class CategoryCard extends StatelessWidget {
  final String region;
  final List<StatAndStatusModel> models;
  final Color darkColor;
  final Color lightColor;

  const CategoryCard({
    required this.region,
    required this.models,
    required this.darkColor,
    required this.lightColor,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 160,
      child: MainCard(
        backgroundColor: lightColor,
        child: LayoutBuilder(
          builder: (context, constraint) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                CardTitle(
                  title: '종류별 통계',
                  backgroundColor: darkColor,
                ),
                Expanded(
                  child: ListView(
                    scrollDirection: Axis.horizontal,
                    physics: PageScrollPhysics(),
                    children: models
                        .map((model) => MainStat(
                            width: constraint.maxWidth / 3,
                            category: DataUtils.getItemCodeKrString(
                                itemCode: model.itemCode),
                            imgPath: model.status.imagePath,
                            level: model.status.label,
                            stat: '${model.stat.getLevelFromRegion(
                              region,
                            )}${DataUtils.getUnitFromItemCode(itemCode: model.itemCode)}'))
                        .toList(),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
