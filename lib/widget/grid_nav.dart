import 'package:flutter/material.dart';
import 'package:flutter_trip/models/grid_nav_model.dart';

/**
 *
 * @ProjectName:    flutter_trip
 * @Package:        widget
 * @Company         etiantian
 * @Description:    类作用描述
 * @Author:         作者名:
 * @CreateDate:     2019-06-28 14:30
 * @UpdateUser:     更新者：
 * @UpdateDate:     2019-06-28 14:30
 * @UpdateRemark:   更新说明：
 * @Version:        1.0
 */

class GridNav extends StatelessWidget {

  final GridNavModel gridNavModel;
  GridNav({Key key,@required this.gridNavModel}):super(key:key);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Text("GridNav");
  }
}