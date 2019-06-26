import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';

/**
  *
  * @ClassName:      首页
  * @Description:    类作用描述
  * @Author:         作者名：liuchuanan
  * @CreateDate:     2019-06-26 11:17
  * @UpdateUser:     更新者：
  * @UpdateDate:     2019-06-26 11:17
  * @UpdateRemark:   更新说明：
  * @Version:        1.0
 */
class HomePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _HomePageState();
  }
}

class _HomePageState extends State<HomePage> {

  // 图片地址
  List<String> _imageUlrs = [
    "https://dimg04.c-ctrip.com/images/a10915000000xdmfo60F6.jpg",
    "https://dimg04.c-ctrip.com/images/a10i15000000xptxoA856.jpg",
    "https://dimg02.c-ctrip.com/images/a10s0u000000jbef9A566.jpg",
  ];

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      body: Center(
        child: Column(
          children: <Widget>[
            Container(
              height: 180,
              child: Swiper( //轮播图
                itemCount: _imageUlrs.length,
                autoplay: true,//自动播放
                itemBuilder: (BuildContext context, int index) { //显示得Widget
                  return Image.network(
                    _imageUlrs[index],
                    fit: BoxFit.fill,//图片适配方式
                  );
                },
                pagination: SwiperPagination(),//当前页指示器

              ),
            ),
          ],
        ),
      ),
    );
  }
}
