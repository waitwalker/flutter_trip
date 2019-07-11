import 'package:flutter/material.dart';
import 'package:flutter_trip/pages/search_page.dart';
import 'package:flutter_trip/plugin/asr_manager.dart';



const kSearch_Bar_Default_Text = "网红打卡地 景点 酒店 美食";
// 定义一个常量
const kAppBar_Scroll_Offset = 100;

/**
  *
  * @ClassName:      语音识别
  * @Description:    类作用描述
  * @Author:         作者名：liuchuanan
  * @CreateDate:     2019-06-26 11:17
  * @UpdateUser:     更新者：
  * @UpdateDate:     2019-06-26 11:17
  * @UpdateRemark:   更新说明：
  * @Version:        1.0
 */
class SpeakPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _SpeakPageState();
  }
}

class _SpeakPageState extends State<SpeakPage> with SingleTickerProviderStateMixin {

  String speakTips = "长按说话";
  String speakResult = "";

  Animation<double> animation;
  AnimationController controller;
  @override
  void initState() {
    controller = AnimationController(vsync: this, duration: Duration(microseconds: 1000));
    animation = CurvedAnimation(parent: controller, curve: Curves.easeIn)
    ..addStatusListener((status){
      if (status == AnimationStatus.completed) {
        controller.reverse();
      } else if (status == AnimationStatus.dismissed) {
        controller.forward();
      }
    });
    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      body: Container(
        padding: EdgeInsets.all(30),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              _topItem(),
              _bottomItem(),
            ],
          ),
        ),
      ),
    );
  }

  _topItem() {
    return Column(
      children: <Widget>[
        Padding(
          padding: EdgeInsets.fromLTRB(0, 30, 0, 30),
          child: Text("可以这样说",style: TextStyle(fontSize: 16,color: Colors.black54),
          ),
        ),
        Text(
          "故宫门票\n北京一日游\n迪士尼乐园",
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 15,
            color: Colors.grey
          ),
        ),
        Padding(
          padding: EdgeInsets.all(20),
          child: Text(
            speakResult,
            style: TextStyle(color: Colors.blue),),
        ),
      ],
    );
  }

  _speakStart() {
    controller.forward();
    setState(() {
      speakTips = "识别中";
    });
    AsrManager.start().then((text){
      if (text != null && text.length > 0) {
        setState(() {
          speakResult = text;
        });

        Navigator.pop(context);
        Navigator.push(context, MaterialPageRoute(builder: (context){
          return SearchPage(keyword: speakResult,);
        }));
      }

    }).catchError((e){
      print("识别出错:$e");
    });
  }

  _speakStop() {
    setState(() {
      speakTips = "长按说话";
    });
    controller.reset();
    controller.stop();
    AsrManager.stop();
  }

  _speakCancel() {

  }

  _bottomItem() {
    return FractionallySizedBox(
      widthFactor: 1,
      child: Stack(
        children: <Widget>[
          GestureDetector(
            onTapDown: (e){
              _speakStart();
            },
            onTapUp: (e){
              _speakStop();
            },
            onTapCancel: (){
              _speakCancel();
            },
            child: Column(
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.all(10),
                  child: Text(
                    speakTips,
                    style: TextStyle(color: Colors.blue,fontSize: 12),)
                ),
                Stack(
                  children: <Widget>[
                    // 防止动画过程导致父控件大小变化
                    Container(
                      height: Mic_Size,
                      width: Mic_Size,
                    ),
                    Center(
                      child: AnimatedMic(
                        animation: animation,
                      ),
                    )
                  ],
                ),
              ],
            ),
          ),
          Positioned(
            child: GestureDetector(
              child: Icon(Icons.close,size: 30,color: Colors.grey,),
              onTap: (){
                Navigator.pop(context);
              },
            ),
            right: 0,
            bottom: 30,
          )
        ],
      ),
    );
  }
}

const double Mic_Size = 80.0;
class AnimatedMic extends AnimatedWidget {

  static final _opacityTween = Tween<double>(begin: 1,end: 0.5);
  static final _sizeTween = Tween<double>(begin: Mic_Size, end: Mic_Size - 20);

  AnimatedMic({Key key,Animation<double> animation}) : super(key:key, listenable:animation);

  @override
  Widget build(BuildContext context) {
    final Animation<double> animation = listenable;
    return Opacity(
      opacity: _opacityTween.evaluate(animation),
      child: Container(
        height: _sizeTween.evaluate(animation),
        width: _sizeTween.evaluate(animation),
        decoration: BoxDecoration(
          color: Colors.blue,
          borderRadius: BorderRadius.circular(Mic_Size / 2),
        ),
        child: Icon(
          Icons.mic,
          color: Colors.white,
          size: 30,
        ),
      ),);
  }
}