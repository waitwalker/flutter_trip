import 'package:flutter/material.dart';

/**
  *
  * @ClassName:      加载进度条组件
  * @Description:    类作用描述
  * @Author:         作者名：liuchuanan
  * @CreateDate:     2019-07-01 13:24
  * @UpdateUser:     更新者：
  * @UpdateDate:     2019-07-01 13:24
  * @UpdateRemark:   更新说明：
  * @Version:        1.0
 */
class LoadingContainer extends StatelessWidget {

  final Widget child;
  final bool isLoading;
  final bool cover;


  LoadingContainer({
    Key key,
    @required this.child,
    @required this.isLoading,
    this.cover = false}):super(key:key);

  @override
  Widget build(BuildContext context) {
    return !cover? !isLoading? child : _loadingView :
      Stack(
        children: <Widget>[
          child,isLoading? _loadingView : null
        ],
      )
    ;
  }

  Widget get _loadingView{
    return Center(
      child: CircularProgressIndicator(),
    );
  }
}